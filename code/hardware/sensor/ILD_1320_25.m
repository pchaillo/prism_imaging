classdef ILD_1320_25
    
    % ILD1320-25 renvoie la tension lu sur l'Arduino, qd le VL6180x renvoie directement la distance => comment combiner les deux ?
    % => Mettre la conversion tension / distance dans le code orienté
    % objet

    % voir les fonctions etal_vid3() et mesure9()
   
    properties
        % Nb_shoot_per_burst = 0
        need_calibration = 1; % 0 = no // 1 = yes
        % Analogic sensor, send a voltage between 0 qnd 5V, analog to a distance :
        pin = "A1"
    end

    methods
        function sensor_co = connect(sensor) 
           % insert laser connexion and return connection object variable
           sensor_co = arduino(); % connect the arduino (sensor acquisition

        end

        function data = get_data(sensor,sensor_co) 
           % insert laser connexion and return measured depth
           stop = 0;
           nb_err = 0;
           nb_err_attente = 10;
           while stop == 0
               pause(0.05)
               u = readVoltage(sensor_co , sensor.pin); % ressort la tension en V
               % u = readVoltage(ard , 'A1'); % ressort la tension en V
               if u < 0.75 % Pourquoi 0.75 ? % #TODO
                   nb_err = nb_err + 1 ;
                   if nb_err > nb_err_attente
                       data = 0 % peut etre trouver une meilleure solution ?
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
