function sample_height = get_rectified_data(sensor,robot,k_pos,j,delta,opo_flag)

% This function will get the data from the sensor, and if is not able to (sensor return error value), it will correct itself automatically by putting the position higher (uselful for triangulation sensor)

% #TODO : what is delta variable in input ? 
% #TODO : ranme k_pos as x_pos and j as y_pos ?

% global opotek; % Pour Mass spectro imaging, with taking in care the opotek watchdog (send a frame on a regular temporal basis to avoid security blocking)

global scan;

% # TODO : supress both useles variable
u = 0; % bool, to do the loop at least once => useless, reundant with meas_ok (#TODO : suppress and test it)
measured_distance = 0; % initialize the variable => useful ? (#TODO : suppress it)

loop_counter = 0; 
is_measured = 0 ; % bool : if is_measured == 0 : no good value yet, continue the while loop // if is_measured == 1 : we get a value or we reach time limite, so we quit the while loop
first_loop = 1; % bool, if 1, it's the first loop in while for repositioning, then set to 0

nb_boucle_mesure = 1200; % 1200
nb_boucle_repeat = 100; % 1200

shift = 0; % height shift for the repositionning of the robot
max_shift = 5; % maximal height shift

calibration_tab = sensor.tab_etal; % #TODO : rename tab_etal to calibration_tab

while u == 0  || is_measured == 0
    loop_counter = loop_counter + 1;
    %    if  mod(loop_counter,100) == 0 && k> 500
    if  loop_counter >= nb_boucle_mesure && mod(loop_counter,nb_boucle_repeat) == 0
        
        d_y = sensor.class.get_data(sensor.connexion); % voltage send by the sensor #TODO => unifier le framework pour les réutilisation
        
        si = size(calibration_tab);
        
        for z = 1 : si(2)-3
            if abs(d_y) > abs(calibration_tab(2,z+1)) && abs(d_y) < abs(calibration_tab(2,z+2))
                %       measured_distance = ( calibration_tab(1,z) + calibration_tab(1,z+1) ) / 2; % to get raw value directly
                y = [ calibration_tab(1,z) calibration_tab(1,z+1)  calibration_tab(1,z+2) calibration_tab(1,z+3) ];
                x = [ calibration_tab(2,z) calibration_tab(2,z+1) calibration_tab(2,z+2) calibration_tab(2,z+3)];
                p = polyfit(x,y,3);
                measured_distance = p(1)*d_y^3 + p(2)*d_y^2 + p(3)*d_y + p(4); % use polynomial interpolation to get measured value from calibration tab
                sample_height = scan.dh + shift - measured_distance  + delta ;
                is_measured = 1;
            end
        end
        
        %% nouveau repos
        if d_y < calibration_tab(2,1)% || d_y == 0
            if scan.fast == 0 % faire ressortir de la fonction = refactor ? des fonctions différentes, avec des entree sortie differente pour la version modulaire ? 
                if first_loop == 1
                    shift = -3; % The sensor will first get a bit closer to see if it help the sensor, then it will move one millimetter by one millimetter
                    first_loop = 0;
                end
                disp('Repositioning. New height :');
                shift = shift + 1
                
                % if opo_flag == 1 % #TODO
                %     state_double = get_state(opotek);
                % end
                                
                a = [k_pos j scan.dh+delta+shift 180 0 180];
                robot.class.set_position(robot.connexion,a); 
              %  set_pos(a,t);
                if shift > max_shift
                    shift = 0;
                    sample_height = -2;
                    disp('Measurement impossible : will set negative value (-2) for sample haight');
                    is_measured = 1;
                end
            else
                sample_height = -2;
                is_measured = 1;
            end
        end
        u = 1;
    end 
end

% if sample_height < -3 % en donnant des valeurs fixes impossibles aux points faux, cela permet de les retrouver pour les corriger par la suite
%     sample_height = 0.01;
% end

if sample_height > scan.s_offset + scan.hmax
    sample_height = 0.02;
end


