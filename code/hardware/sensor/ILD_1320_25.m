classdef ILD_1320_25
    % (Analogic)
    % ILD1320-25 renvoie la tension lu sur l'Arduino, qd le VL6180x renvoie directement la distance => comment combiner les deux ?
    % => Mettre la conversion tension / distance dans le code orienté objet

    properties
        need_calibration = 1; % bool, 0 = no // 1 = yes  
        pin = "A1"; % Analogic sensor, send a voltage between 0 qnd 5V, analog to a distance. A1 is the pin of the arduino that is connected to the analog sensor
        wait_time = 0.05 
    end

    methods
        function sensor_co = connect(sensor)
            % Insert laser connexion and return connection object variable
            sensor_co = arduino(); % Connect the arduino sensor acquisition

        end

        function calibration_array = calibration(sensor, robot)
            calibration_array = sensor_calibration(robot, sensor, app);
        end

        function height = get_data(sensor,robot) % Robot as input : could be usefull to change th height of the robot in case the sensor that is in a impossible configuration (could be useful for triangulation software for exemple).
            k_pos = robot.class.current_x;
            j = robot.class.current_y;
            % delta et opo_flag % #TODO
            sample_height = get_rectified_data(app, sensor,robot,k_pos,j,delta,opo_flag);
        end

        function value = get_value(sensor, sensor_co, app) % #TODO : get_value() ?
            % contain laser connexion and return measured depth
            stop = 0; % bool to stop acquistion (will stop the while loop)
            nb_err = 0; % error counter
            nb_err_threshold= 10; % threshold that will stop trying measurement if the error counter reach it
            while stop == 0
                pause(sensor.wait_time)
                u = readVoltage(sensor_co , sensor.pin); % get analog voltage
                if u < 0.75 % Pourquoi 0.75 ? % #TODO
                    nb_err = nb_err + 1 ;
                    if nb_err > nb_err_threshold
                        value = 0; % peut etre trouver une meilleure solution ? #TODO
                        update_log(app, string(value))
                        stop = 1;
                    end
                else
                    value = u;
                    update_log(app, string(value))
                    stop = 1;
                end
            end
        end
    end
end
