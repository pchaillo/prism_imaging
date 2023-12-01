classdef ILD_1320_25

    % ILD1320-25 renvoie la tension lu sur l'Arduino, qd le VL6180x renvoie directement la distance => comment combiner les deux ?
    % => Mettre la conversion tension / distance dans le code orienté objet

    properties
        need_calibration = 1; % bool, 0 = no // 1 = yes  
        pin = "A1"; % Analogic sensor, send a voltage between 0 qnd 5V, analog to a distance. A1 is the pin of the arduino that is connected to the analog sensor
        wait_time = 0.05 
    end

    methods
        function sensor_co = connect(sensor)
            % insert laser connexion and return connection object variable
            sensor_co = arduino(); % connect the arduino sensor acquisition

        end

        function data = get_data(sensor,sensor_co) % #TODO : get_voltage() ?
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
                        data = 0 % peut etre trouver une meilleure solution ? #TODO
                        stop = 1;
                    end
                else
                    data = u
                    stop = 1;
                end

            end

        end


    end
end
