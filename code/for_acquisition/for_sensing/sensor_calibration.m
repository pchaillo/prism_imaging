function calibration_array = sensor_calibration(app, robot,sensor)

% do the calibration of the new sensor (ILD1320-25 Microepsilon)
% Better handling of criticals values

% Will go one way up, then one way down, and will only keep the similar value for the same height => security to remove all false point on the calibration_array

global scan
global zone
% global robot % passe en argument

update_log(app, 'Starting calibration')

calibration_finished = 0;
calib_tab_ind = 0;
going_down = 0;

calibration_resolution = sensor.class.calibration_step;

calibration_band = 25; % plage de mesure du capteur en mm % a remonter en argument ? #TODO

% REFAIRE UNE NOUVELLE VERSION DE LA FONCTION D'ÉTALONNAGE, (NOUVEAU NOM)
% AVEC CES VALEURS EXTRÊME EN ARGUMENT ?

% The starting height of calibration depends on the distance between the
% camera and the laser pointer. The closer they are, the lower we can start
% the calibration.

init_height = 71 + parameters.surface_offset - 0.75 ;% - 1.5 ; % + 5; % height of the beginnig of the calibration (71 cool) / +5 to avoid the tube 3d piece
final_height = init_height + calibration_band + 3 ;%-5 ; %-5 to offset the aforementioned +5

current_height = init_height;

pos_x = zone.dec - 10;
pos_y = 0;

pos = [pos_x pos_y current_height 180 0 180 ];
robot.class.set_position(robot.connexion, pos);
pause(7)

while calibration_finished == 0

    value = sensor.class.get_value(app, sensor.connexion);

    if going_down == 0 % Determines if the robot is traveling upwards or downwards
        current_height = current_height + calibration_resolution;
        if current_height == final_height % When final height is reached, the robot starts descending 
            going_down = 1;
        end
    else
        current_height = current_height - calibration_resolution;
        if current_height == init_height + 0.25% lorsqu'on est revenu à la position initiale, l'étalonnage s'arrete
            calibration_finished = 1;
        end
    end

    if current_height < 50 % current_height étant la hauteur de l'effecteur, il s'agit d'une sécurité pour arrêter la calibration si le robot s'approche trop près du sol
        calibration_finished = 1;
        update_log(app, 'Calibration aborted over safety concerns.')
    end

    pos = [pos_x pos_y current_height 180 0 180 ];
    robot.class.set_position(robot.connexion,pos);

    calib_tab_ind = calib_tab_ind + 1;
    full_tab(:,calib_tab_ind) = [current_height ; value]; % full tab contains both going up and going down value

    if current_height == final_height % pour avoir un beau tableau bien symetrique
        calib_tab_ind = calib_tab_ind+1;
        full_tab(:,calib_tab_ind) = [current_height ; value];
    end

end

final_tab_length = (final_height - init_height)/calibration_resolution ; % récupération de la taille attendue du tableau

up_tab = tab(:,1: final_tab_length); % division en deux tableaux équivalents (un pour la montée, un pour la descente)
down_tab_raw = tab(:,final_tab_length+1:2*final_tab_length);
down_tab = fliplr(down_tab_raw);

error = 0.1; % Tolerance margin in volts
final_tab_ind = 0;

si = size(up_tab);
for j = 1 : si(2) - 1
        % if up_tab(2,j+1) > up_tab(2,j) - error && up_tab(2,j+1) < up_tab(2,j) + error % je compare une valeur et sa suivante, si les deux se suivent d'une valeur inferieure à l'erreur, je garde le point comme moyenne de la valeur en montée et en descente
    if up_tab(2,j+1) > down_tab(2,j) - error && up_tab(2,j+1) < down_tab(2,j) + error % je compare les tableaux de montée et de descente point par point,  si les valeurs correspondent je les garde dans le tableau final
        final_tab_ind = final_tab_ind + 1;
        calibration_array(:,final_tab_ind) =  [ (up_tab(1,j)+down_tab(1,j+1))/2 ; (up_tab(2,j)+down_tab(2,j+1))/2 ];
    end
end