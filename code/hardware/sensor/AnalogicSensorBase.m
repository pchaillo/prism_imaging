classdef AnalogicSensorBase
   
    properties
        need_calibration = 1; % bool, 0 = no // 1 = yes   % if you set it to 0, no need to fill sensor_calibration funtcion (will not be called)
    end

    methods
        function sensor_co = connect(sensor) 
           % insert laser connexion and return connection object variable
        end

        function data = get_value(sensor,sensor_co) % function that give the analog value for analog sensors (useless for numerics ones)
            % insert code to get the analog value (basically, current or
            % voltage
        end

        function calibration_array = calibration(sensor,robot)

        end

        function height = get_data(sensor,robot) % Robot as input : could be usefull to change th height of the robot in case the sensor that is in a impossible configuration (could be useful for triangulation software for exemple).

        end
   end
end