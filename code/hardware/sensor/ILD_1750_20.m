classdef ILD_1750_20 < handle

    properties
        need_calibration = 0; % bool, 0 = no // 1 = yes  
        wait_time = 0.05 
        sensor_connection = "";
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

        function sample_height = get_data(self, ~,sample_height,~,parameters, ~) % Robot as input : could be useful to change th height of the robot in case the sensor that is in a impossible configuration (could be useful for triangulation software for exemple).
            meas_value = self.get_value();
            sample_height = parameters.initial_height - meas_value + sample_height;
        end

        function dist = get_value(self) 
            flush(self.sensor_connection);
            raw = read(self.sensor_connection, 3, "uint8");
            bin_raw = dec2bin(raw);
            idx = find(strcmp(bin_raw(:,1:2), "00"), 1, "first");
        
            bin = bin_raw(idx:idx+2, 3:8); % Removes the two flag bits for each byte
            bin_final = strcat(bin(3,:), bin(2,:), bin(1,:));
            
            if bin_final == "111111111110111100"/
                dist = "Error: Out of range";
                return
            end
        
            dist_out = bin2dec(bin_final);
        
            meas_range = 20; % in mm
            meas_start = 40; % in mm
            
            dist = (((dist_out - 98232) / 65536) * meas_range) + meas_start; % In mm
        end
    end
end
