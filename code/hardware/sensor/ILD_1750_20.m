classdef ILD_1750_20 < handle

    properties
        need_calibration = 0; % bool, 0 = no // 1 = yes  
        wait_time = 0.05 
        sensor_connection = "";
        meas_range = 20; % In mm, amplitude of the sensor's measuring range
        meas_start = 40; % In mm, minimal distance that can be measured
        repositioning_step = 1; % In mm
        repositioning_range = 10; % In mm, maximal distance in either direction for repositioning
        sensor_offset = 89 % In mm, distance from the effector to the sensor. Can be deduced from a measurement on the ground
    end

    methods
        function init(self, varargin)
            self.sensor_connection = serialport("COM4", 921600);
            test = self.query_sensor("BAUDRATE");
                        
            if contains(test, "BAUDRATE") == 1
                disp("Sensor connected!")
                query_sensor("OUTPUT RS422");
            else
                disp("Something went wrong with the connection. Try again.")
            end
        end

        function out = query_sensor(self, msg)
            flush(self.sensor_connection)
            writeline(self.sensor_connection, msg)
            pause(0.1)
            out = readline(self.sensor_connection);
        end

        function sample_height = get_data(self, robot, sample_height, parameters, app) % Robot as input, allowing for error correction
            x_pos = robot.class.current_x;
            y_pos = robot.class.current_y;
            z_pos = robot.class.current_z;
            meas_value = self.get_value();
            shift = 0; % Deviation of the robot caused by correction

            % Error handling
            if strcmp(meas_value, "Error: Out of range") == 1
                % Measure again to confirm the error
                meas_value_2 = self.get_value();
                if strcmp(meas_value_2, "Error: Out of range") == 1
                    % Error confirmed, we must now handle it
                    % First case: Assume that we are too low, limiting the risk
                    % of a collision
                    new_z_pos = z_pos;
                    while strcmp(meas_value_2, "Error: Out of range") == 1
                        new_z_pos = new_z_pos + self.repositioning_step;
                        shift = shift + 1;
                        if new_z_pos > z_pos + self.repositioning_range
                            break
                        end
                        position = [x_pos, y_pos, new_z_pos, app.rotation(1), app.rotation(2), app.rotation(3)];
                        robot.class.set_position(position);
                        pause(0.1)
                        meas_value_2 = self.get_value();
                    end
                    
                    % Second case: Assume that we are too high, lowering the
                    % effector as long as it is safe to do so
                    shift = 0;
                    new_z_pos = z_pos;
                    while strcmp(meas_value_2, "Error: Out of range") == 1
                        new_z_pos = new_z_pos - self.repositioning_step;
                        shift = shift - 1;
                        if new_z_pos < z_pos - self.repositioning_range || new_z_pos < robot.class.stop_distance + parameters.surface_offset % Could take parameters.maximal_height as well for added safety
                            break
                        end
                        position = [x_pos, y_pos, new_z_pos, app.rotation(1), app.rotation(2), app.rotation(3)];
                        robot.class.set_position(position);
                        pause(0.1)
                        meas_value_2 = self.get_value(); 
                    end
                    % Third case: Going up or down has not helped. Assume that
                    % the height is identical to the previous position and move
                    % on
                    shift = 0;
                    position = [x_pos, y_pos, z_pos, app.rotation(1), app.rotation(2), app.rotation(3)];
                    robot.class.set_position(position);
                    pause(0.1)
                    return % Should provide the previous height as an output, bypassing the remainder of the function
                else
                    % Error cleared, proceed as usual
                    meas_value = meas_value_2;
                end
                clear meas_value_2
            end

            sample_height = parameters.initial_height + shift - meas_value - self.sensor_offset + sample_height;

        end

        function value = get_value(self) 
            flush(self.sensor_connection);
            raw = read(self.sensor_connection, 5, "uint8");
            bin_raw = dec2bin(raw);
            idx = find(strcmp(bin_raw(:,1:2), "00"), 1, "first");

            bin = bin_raw(idx: idx+2, 3:8); % Removes the two flag bits of each byte
            bin_final = strcat(bin(3,:), bin(2,:), bin(1,:));

            if strcmp(bin_final, "111111111110111100") == 1
                value = "Error: Out of range";
                return
            end
        
            dist_out = bin2dec(bin_final);
            
            value = (((dist_out - 98232) / 65536) * self.meas_range) + self.meas_start; % In mm
        end
    end
end
