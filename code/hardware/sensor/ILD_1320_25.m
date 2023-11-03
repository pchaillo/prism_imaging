classdef ILD_1320_25
    
    % ILD1320-25 renvoie la tension lu sur l'Arduino, qd le VL6180x renvoie directement la distance => comment combiner les deux ?
    % => Mettre la conversion tension / distance dans le code orienté
    % objet

    % voir les fonctions etal_vid3() et mesure9()
   
    properties
        % Nb_shoot_per_burst = 0
        need_calibration = 1; % 0 = no // 1 = yes
    end

    methods
        function sensor_co = connect(sensor) 
           % insert laser connexion and return connection object variable
           sensor_co = arduino(); % connect the arduino (sensor acquisition

        end

        function data = get_data(sensor,sensor_co) 
           % insert laser connexion and return measured depth
        end
       

   end
end
