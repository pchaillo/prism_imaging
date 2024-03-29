classdef ILD_1320_25 < handle
    % (Analogic)
    % ILD1320-25 renvoie la tension lu sur l'Arduino, qd le VL6180x renvoie directement la distance => comment combiner les deux ?
    % => Mettre la conversion tension / distance dans le code orienté objet

    properties
        need_calibration = 1; % bool, 0 = no // 1 = yes  
        pin = "A1"; % Analogic sensor, send a voltage between 0 qnd 5V, analog to a distance. A1 is the pin of the arduino that is connected to the analog sensor
        wait_time = 0.05 
        calibration_step = 0.5 % In mm, used for sensor calibration DEBUG
        sensor_connexion = "";
        calibration_array = 0;
        calibration_band = 25; % in mm
    end

    methods
        function init(self,arduino_object) %, arduino, pin) % I'm confused as to how this is supposed to work. The logic behind this version is sound, so I'm not touching it for now.
%             self.pin = pin
%             self.arduino = arduino
            % Insert laser connexion and return connection object variable
%             sensor_co = arduino(); % Connect the arduino sensor acquisition
            self.sensor_connexion = arduino_object;
            disp("Sensor connexion :")
            disp(self.sensor_connexion)
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

        function value = get_value(self, app) 
            % contain laser connexion and return measured depth
            stop = 0; % bool to stop acquistion (will stop the while loop)
            nb_err = 0; % error counter
            nb_err_threshold= 10; % threshold that will stop trying measurement if the error counter reach it
            while stop == 0
                pause(self.wait_time)
                u = readVoltage(self.sensor_connexion , self.pin); % get analog voltage
                if u < 0.75 % Pourquoi 0.75 ? % #TODO
                    nb_err = nb_err + 1 ;
                    if nb_err > nb_err_threshold
                        value = 0; % peut etre trouver une meilleure solution ? #TODO
%                         update_log(app, string(value))
                        stop = 1;
                    end
                else
                    value = u;
%                     update_log(app, string(value))
                    stop = 1;
                end
            end
        end
    end
end
