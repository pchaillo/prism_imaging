function calibration_array = default_sensor_calibration(robot, sensor, parameters, app)

% do the calibration of the new sensor (ILD1320-25 Microepsilon)
% Better handling of criticals values

% Will go one way up, then one way down, and will only keep the similar value for the same height => security to remove all false point on the calibration_array

update_log(app, 'Starting calibration')

calibration_finished = 0;
calibration_array_indice = 0;
going_down = 0;

% calibration_resolution = sensor.class.calibration_step; It looks like the
% 'sensor' passed as an argument here is different from the global sensor
% in the interface. Be careful.
calibration_resolution = sensor.calibration_step;

calibration_band = 25; % plage de mesure du capteur en mm % a remonter en argument ? #TODO

% REFAIRE UNE NOUVELLE VERSION DE LA FONCTION D'ÉTALONNAGE, (NOUVEAU NOM)
% AVEC CES VALEURS EXTRÊME EN ARGUMENT ?

% The starting height of calibration depends on the distance between the
% camera and the laser pointer. The closer they are, the lower we can start
% the calibration.

% init_height = 71 - 0.75 ;% The surface offset must be recovered from the interface as an argument
init_height = 71 + parameters.surface_offset - 0.75 ;% - 1.5 ; % + 5; % height of the beginnig of the calibration (71 cool) / +5 to avoid the tube 3d piece 
final_height = init_height + calibration_band + 3 ;%-5 to offset the aforementioned +5

current_height = init_height;

pos_x = parameters.x_offset - 10;
pos_y = 0;

pos = [pos_x pos_y current_height 180 0 180];
robot.class.set_position(pos);
pause(7)

while calibration_finished == 0

    value = sensor.get_value(app);

    disp("Current height :")
    disp(current_height)
    disp("final_height")
    disp(final_height)

    if going_down == 0 % Determines if the robot is traveling upwards or downwards
        current_height = current_height + calibration_resolution;
        if current_height == final_height || current_height > final_height % When final height is reached, the robot starts descending 
            going_down = 1;
        end
    else
        current_height = current_height - calibration_resolution;
        if current_height == init_height || current_height < init_height  % lorsqu'on est revenu à la position initiale, l'étalonnage s'arrete
            calibration_finished = 1;
        end
    end

    if current_height < 50 % current_height étant la hauteur de l'effecteur, il s'agit d'une sécurité pour arrêter la calibration si le robot s'approche trop près du sol
        calibration_finished = 1;
        update_log(app, 'Calibration aborted over safety concerns.')
    end

    pos = [pos_x pos_y current_height 180 0 180 ];
    robot.class.set_position(pos);

    calibration_array_indice = calibration_array_indice + 1;
    full_array(:,calibration_array_indice) = [current_height ; value]; % full array contains both going up and going down value

    if current_height == final_height % pour avoir un beau tableau bien symetrique
        calibration_array_indice = calibration_array_indice+1;
        full_array(:,calibration_array_indice) = [current_height ; value];
    end

end

final_array_length = (final_height - init_height)/calibration_resolution ; % récupération de la taille attendue du tableau

up_array = full_array(:,1: final_array_length); % division en deux tableaux équivalents (un pour la montée, un pour la descente) tab ligne 77 et 78 eq to full array ? #TODO
down_array_raw = full_array(:,final_array_length+1:2*final_array_length);
down_array = fliplr(down_array_raw);

error = 0.1; % Tolerance margin in volts
final_array_ind = 0;

si = size(up_array);
for j = 1 : si(2) - 1
        % if up_array(2,j+1) > up_array(2,j) - error && up_array(2,j+1) < up_array(2,j) + error % je compare une valeur et sa suivante, si les deux se suivent d'une valeur inferieure à l'erreur, je garde le point comme moyenne de la valeur en montée et en descente
    if up_array(2,j+1) > down_array(2,j) - error && up_array(2,j+1) < down_array(2,j) + error % je compare les tableaux de montée et de descente point par point,  si les valeurs correspondent je les garde dans le tableau final
        final_array_ind = final_array_ind + 1;
        calibration_array(:,final_array_ind) =  [ (up_array(1,j)+down_array(1,j+1))/2 ; (up_array(2,j)+down_array(2,j+1))/2 ];
    end
end