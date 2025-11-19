classdef ILD_1750_20 < handle

    properties
        need_calibration = 1; % bool, 0 = no // 1 = yes  
        pin = "A1"; % Analogic sensor, send a voltage between 0 qnd 5V, analog to a distance. A1 is the pin of the arduino that is connected to the analog sensor
        wait_time = 0.05 
        calibration_step = 0.5 % In mm, used for sensor calibration
        sensor_connection = "";
        calibration_array = 0;
        calibration_band = 20; % in mm
    end

    methods
        function init(self) %, arduino, pin) % I'm confused as to how this is supposed to work. The logic behind this version is sound, so I'm not touching it for now.
%             self.pin = pin
%             self.arduino = arduino
            % Insert laser connexion and return connection object variable
%             sensor_co = arduino(); % Connect the arduino sensor acquisition
            self.sensor_connection = serialport("COM4", 921600);
            
            if contains(query_sensor(self.sensor_connection, "BAUDRATE"), "BAUDRATE") == 1
                disp("Sensor connexion :")
                disp(self.sensor_connection)

                query_sensor("OUTPUT RS422");
            else
                disp("Something went wrong with the connection. Try again.")
            end
        end

        function out = query_sensor(self, msg)
            flush(self.sensor_connection)
            write(self.sensor_connection, msg, "uint8")
            pause(0.1)
            out = read(self.sensor_connection);
        end

        function calibration_array = calibration(self, robot,parameters, app)
            calibration_array = default_sensor_calibration(robot, self,parameters, app);
            self.calibration_array = calibration_array;
        end

        function sample_height = get_data(self, robot,sample_height,watchdog_flag,parameters,app) % Robot as input : could be usefull to change th height of the robot in case the sensor that is in a impossible configuration (could be useful for triangulation software for exemple).
            x_pos = robot.class.current_x;
            y_pos = robot.class.current_y;
            sample_height = get_rectified_data(app, self,robot,x_pos,y_pos,sample_height,watchdog_flag,parameters);
            % Watchdog_flag ici ? #TODO
        end

        function value = get_value(self) 
            flush(self.sensor_connection);
            raw = read(self.sensor_connection, 3, "uint8");
            bin = dec2bin(raw);
            bin = bin(:, 3:8); % Removes the two flag bits for each byte
            bin_final = strcat(bin(3,:), bin(2,:), bin(1,:));

            if bin_final == "011101011001011101"
                value = "Error: Out of range";
                return
            end

            dist_out = bin2dec(bin_final);
        
            meas_range = 20; % in mm
            meas_start = 40; % in mm
            
            value = (((dist_out - 98232) / 65536) * meas_range) + meas_start; % in mm
        end
    end
end
