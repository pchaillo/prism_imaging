function sample_height = get_rectified_data(app, sensor,robot,x_pos,y_pos,sample_height,watchdog_flag,parameters)

% This function will get the data from the sensor, and if is not able to (sensor return error value), it will correct itself automatically by putting the position higher (uselful for triangulation sensor)

% global opotek; % For MSI, takes care of the opotek watchdog (send a frame on a regular temporal basis to avoid security blocking)

% # TODO : Remove the two useless variables
get_first_value = 0; % bool, to do the loop at least once
measured_distance = 0; % initialize the variable 

loop_counter = 0; 
is_measured = 0 ; % bool : if is_measured == 0 : no good value yet, continue the while loop // if is_measured == 1 : we get a value or we reach time limite, so we quit the while loop
first_loop = 1; % bool, if 1, it's the first loop in while for repositioning, then set to 0

nb_boucle_mesure = 200 ; % 1200 % Specifiaue au ILD1320_25 # TODO
nb_boucle_repeat = 50 ; % 100

shift = 0; % height shift for the robot repositioning 
max_shift = 5; % maximal height shift

calibration_array = sensor.calibration_array; 
% disp(calibration_array) $ useful for debug

if calibration_array == 0
    disp("This analogic sensor require calibration");
end

while get_first_value == 0  || is_measured == 0
    loop_counter = loop_counter + 1;
    %    if  mod(loop_counter,100) == 0 && k> 500
    if  loop_counter >= nb_boucle_mesure && mod(loop_counter,nb_boucle_repeat) == 0
        
        value = sensor.get_value(app); 
        
        si = size(calibration_array);
        
        for z = 1 : si(2)-3
            if abs(value) > abs(calibration_array(2,z+1)) && abs(value) < abs(calibration_array(2,z+2))
                %       measured_distance = ( calibration_array(1,z) + calibration_array(1,z+1) ) / 2; % to get raw value directly
                y = [ calibration_array(1,z) calibration_array(1,z+1)  calibration_array(1,z+2) calibration_array(1,z+3) ];
                x = [ calibration_array(2,z) calibration_array(2,z+1) calibration_array(2,z+2) calibration_array(2,z+3)];
                p = polyfit(x,y,3);
                measured_distance = p(1)*value^3 + p(2)*value^2 + p(3)*value + p(4); % use polynomial interpolation to get measured value from calibration array
                sample_height = parameters.initial_height + shift - measured_distance  + sample_height ;
                is_measured = 1;
            end
        end
        
        %% nouveau repos
        if value < calibration_array(2,1) % || value == 0
            if parameters.fast_flag == 0 % faire ressortir de la fonction = refactor ? des fonctions différentes, avec des entree sortie differente pour la version modulaire ? 
                if first_loop == 1
                    shift = -3; % The sensor will first get a bit closer to see if it help the sensor, then it will move one millimetter by one millimetter
                    first_loop = 0;
                end
                update_log(app, 'Repositioning. New height :');
                shift = shift + 1;
                update_log(app, string(shift))
                
                % if watchdog_flag == 1 % #TODO
                %     state_double = get_state(app, opotek);
                % end
                                
                position = [x_pos y_pos parameters.initial_height+sample_height+shift 180 0 180];
                robot.class.set_position(position); 
              %  set_pos(a,t);
                if shift > max_shift
                    shift = 0;
                    sample_height = -2;
                    update_log(app, 'Measurement impossible : will set negative value (-2) for sample height');
                    is_measured = 1;
                end
            else
                sample_height = -2;
                is_measured = 1;
            end
        end
        get_first_value = 1;
    end 
end

if sample_height < -3 % en donnant des valeurs fixes impossibles aux points faux, cela permet de les retrouver pour les corriger par la suite
    sample_height = 0.01;
end

if sample_height > parameters.surface_offset + parameters.maximal_height
    sample_height = 0.02;
end


