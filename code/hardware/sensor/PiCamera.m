classdef PiCamera < handle
   % Uses an external targetting laser and a Raspberry Pi camera. Ethernet
   % is used to connect the Pi. Data is sent through a TCP server built in
   % the measurement script. NOTEE: In this implementation, the user
   % session on the Pi must NOT have a password
    properties
        need_calibration = 1; % bool, 0 = no // 1 = yes   % if you set it to 0, no need to fill sensor_calibration funtcion (will not be called)
        host = "prism@192.168.0.5"; % Be sure to change this to the raspberry pi's name, and to assign it a static IP adress on the same subnet as the main computer's 
        filepath = "~/Documents/Depth_Sensor/camera_py.py"; % Location of the measurement script
    
        tcp_client = "";
        tcp_host = "192.168.0.5";
        tcp_port = 5000;
        magic_bytes = uint8([hex2dec('FE'), hex2dec('ED')]);

        calibration_step = 0.5 % In mm, used for sensor calibration
        calibration_array = 0;
        calibration_band = 35; % in mm
        calibration_min_height = 115 % Minimum working height
        cal_samples = 10; % The calibration will take the average of 10 readouts as the value of interest

        previous_meas = [0.0 0.0 0.0 0.0];
    end

    methods
        function  init(self, ~) % Creates a communication instance 
            % Establish SSH connection between the main computer and the
            % Pi, the latter parts of the command are used to redirect all
            % input and output of the script to avoid hangups
            initial_command = sprintf('ssh -T %s "nohup setsid python3 -u %s > /dev/null 2>&1 < /dev/null &"', self.host, self.filepath);
            % Execute the initial command to establish the connection
            if system(initial_command) ~= 0
                error('Failed to connect to the Raspberry Pi. Check the host, credentials and filepath.');
            end
            system(initial_command)
           
            % Wait for the Python script to initialize and start sending data
            pause(1);
            fprintf('Measurement starting...\n');
            
            self.tcp_client = tcpclient(self.tcp_host, self.tcp_port);
            
        end

        function [spot_size, roundness, pos_x, pos_y] = get_value(self, ~) % Provides the raw sensor measurements, and not an actual height
            flush(self.tcp_client)
            raw = read(self.tcp_client, 34, "uint8"); % This forces us to always have a full measurement at least, which is guaranteed to be in the middle of the text
            hits = find(raw == self.magic_bytes(1));
            
            if isempty(hits)
                error('No valid data received from the sensor.');
            end
            
            for i = 1:length(hits)
                if raw(hits(1) + 1) ==  self.magic_bytes(2)
                    data = raw(hits(1) + 2:hits(1) + 17);
                    break
                end
            end

            if ~exist("data", "var")
                error("No valid start was found for the data.")
            end

            % Extract the relevant data from the hit of interest
            spot_size = typecast(data(1:4), 'single');
            roundness = typecast(data(5:8), 'single');
            pos_x = typecast(data(9:12), 'int32');
            pos_y = typecast(data(13:16), 'int32');
        end
        
        function height = get_data(self, ~, ~, ~, ~, ~)
            %TODO: Accumulate readings for enhanced precision
            meas = nan(2, self.cal_samples);
            for j = 1:self.cal_samples
                [spot_size, roundness, meas_x, meas_y] = self.get_value();
                    
                while ismember(-1, [spot_size, roundness, meas_x, meas_y])
                    success = false;

                    for k = 1:10
                        [spot_size, roundness, meas_x, meas_y] = self.get_value();
                        if ~ismember(-1, [spot_size, roundness, meas_x, meas_y])
                            success = true;
                            break;
                        end
                    end
                    if ~success
                        disp("Warning: Could not get measure, reverting to previous value")
                        spot_size = self.previous_meas(1);
                        roundness = self.previous_meas(2);
                        meas_x = self.previous_meas(3);
                        meas_y = self.previous_meas(4);
                    end
                end
                meas(:, j) = [meas_x, meas_y];
            end
            meas = mean(meas, 2);
            meas = double([meas(1), meas(2)]);

            points = nan(length(self.calibration_array.x), 2);
            points(:, 1) = self.calibration_array.x;
            points(:, 2) = self.calibration_array.y;

            best_distance = inf;
            best_height = nan;

            for i = 1:size(points,1)-1
                
                % Get XY for each segment
                p1 = points(i, :); 
                p2 = points(i+1, :);

                segment = p2-p1;

                % Projection
                t = dot(meas - p1, segment) / dot(segment, segment);

                % Restrict the projection to the segment
                t = max(0, min(1, t));

                % Find closest point on segment
                closest = p1 + t*segment;
                
                distance = norm(meas - closest);

                if distance < best_distance
                    best_distance = distance;

                    % Interpolate the height
                    z1 = self.calibration_array.height(i);
                    z2 = self.calibration_array.height(i+1);

                    best_height = z1 + t * (z2 - z1);
                
                end
            end

            height = best_height;
            disp(height)

            distance_to_curve = best_distance; % Measures how far off of calibration we are
        end
        
        function calibration_array = calibration(self, robot, parameters, app)
            % Modified version of default_sensor_calibration for X and Y
            % measurements
            % calibration_finished = 0;
            % calibration_array_index = 0;
            % going_down = 0;
            
            init_height = self.calibration_min_height + parameters.surface_offset - 0.75;
            final_height = init_height + self.calibration_band + 3;
            current_height = final_height; % Best practice would be to swap those values 

            robot_x = parameters.x_offset - 10;
            robot_y = parameters.y_offset;

            % Compute calibration positions
            num_points = floor((final_height - init_height)/self.calibration_step) + 1;
            heights = linspace(final_height, init_height, num_points);

            pos = [robot_x robot_y current_height app.rotation(1) app.rotation(2) app.rotation(3)];
            robot.class.set_position(pos);
            pause(7)
            
            calibration_data = nan(4, num_points);

            % Simplified, single-pass calibration for now, going downwards
            for i = 1:num_points
                current_height = heights(i);
                pos = [robot_x robot_y current_height app.rotation(1) app.rotation(2) app.rotation(3)];
                robot.class.set_position(pos);
                pause(0.1)

                fprintf("Current height: %.2f/%.2f\n", current_height, init_height) % A quirk of only going downards for now. This should be final_height otherwise
                    
                measurements = nan(2, self.cal_samples);
                for j = 1:self.cal_samples
                    [spot_size, roundness, meas_x, meas_y] = self.get_value();
                    
                    while ismember(-1, [spot_size, roundness, meas_x, meas_y])
                        success = false;

                        for k = 1:10
                            [spot_size, roundness, meas_x, meas_y] = self.get_value();
                            if ~ismember(-1, [spot_size, roundness, meas_x, meas_y])
                                success = true;
                                break;
                            end
                        end
                        if ~success
                            fprintf("Warning: Could not get measure %d/%d at height %.2f\n", i, num_points, current_height)
                            spot_size = 0;
                            roundness = 0;
                            meas_x = 0;
                            meas_y = 0;
                        end
                    end
                    measurements(:, j) = [meas_x, meas_y];
                end
                
                % Remove zero values
                measurements(:, any(measurements == 0, 1)) = [];
                
                if isempty(measurements)
                    error("No measures could be obtained at height %.2f. Try changing laser detection thresholds, getting a better sensor,\n or moving it to a more advantageous position.\n", current_height)
                end

                mean_meas = mean(measurements, 2);
                std_meas = std(measurements, 0, 2);
                calibration_data(:, i) = [mean_meas(1), mean_meas(2), std_meas(1), std_meas(2)];
            end
            
            calibration_array.x = calibration_data(1, :);
            calibration_array.y = calibration_data(2, :);
            calibration_array.x_std = calibration_data(3, :);
            calibration_array.y_std = calibration_data(4, :);
            calibration_array.height = heights;
            
            self.calibration_array = calibration_array;
            disp("Finished calibration. Displaying results.")
            
            % Creating and displaying the calibration plot
            figure()
            plot(calibration_array.x, calibration_array.y, "o-")
            hold on

            xlabel("Centroid X (Pixels)")
            ylabel("Centroid Y (Pixels)")
            title("Calibration Curve (Height in mm)")
            for i = 1:num_points
                text(calibration_array.x(i), calibration_array.y(i), ...
                    sprintf(" %.2f", calibration_array.height(i)), ...
                    'VerticalAlignment', 'bottom', ...
                    'HorizontalAlignment', 'left');
            end
        end         
   end
end