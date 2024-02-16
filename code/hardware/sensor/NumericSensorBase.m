classdef NumericSensorBase
   
    properties
        need_calibration = 0; % bool, 0 = no // 1 = yes   % if you set it to 0, no need to fill sensor_calibration funtcion (will not be called)
    end

    methods
        function  connect(self) 
            self.sensor_co = communication_initialisation % or you may put the communication object as an input variable of the sensor.connect function
           % insert laser connexion and return connection object variable
        end

        function height = get_data(self, robot) % Robot as input : could be usefull to change th height of the robot in case the sensor that is in a impossible configuration (could be useful for triangulation software for exemple).
            % Faire 3 fonctions différentes ? = une avec repostionnement,
            % une avec watchdog ? Puis une 4e avec les 2 => non c'est trop
            % trouve autre chose ...
        end
   end
end