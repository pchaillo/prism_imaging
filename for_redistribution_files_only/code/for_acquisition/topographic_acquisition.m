function map = topographic_acquisition(robot,sensor,parameters)
% with time recording

% global map
% global scan
% global zone

update_log(app, log, 'Creating the map...');

opo_flag = 0 ; % sans message lors du repositionnement pour le watchdog % inutile = pas de laser ici !

% Initialisation of the variable => necessary for real time acquisition display
v = 0;
for k = parameters.mapping_step : parameters.mapping_step : parameters.dim_x + parameters.mapping_step
    v = v + 1 ;
    u = 0;
    for j = 2 : parameters.mapping_step : parameters.dim_y +2
        u = u + 1 ;
        map.x(v,u) = k;
        map.y(v,u) = j;
    end
end

si_c = size(map.x);
map.i = zeros(si_c(1),si_c(2));
v = 0;
delta = 0;

first_point = 1;

for k = parameters.mapping_step : parameters.mapping_step : parameters.dim_x + parameters.mapping_step
    v = v + 1 ;
    if ( mod(v,2) ~= 0 )
        u = 0;
        for j = 2 : parameters.mapping_step : parameters.dim_y +2
            u = u +1;
            a = [k  j  parameters.initial_height + delta 180 0 180];
            if robot.arret == 0
                [k j ] % show the current position of the robot / may be useless ( comment it )
                robot.class.set_position(robot.connexion,a);
            end
            map.x(v,u) = k;
            map.y(v,u) = j;
%             measured_height = get_rectified_data(sensor,t,k,j,delta,opo_flag);
            measured_height = sensor.class.get_data(robot,k,j,delta,opo_flag);
            map.i(v,u) =  measured_height ;
            real_time_topography_display(map)
            
            delta =  measured_height ;
            
            if first_point == 1
                first_point = 0;
                tic;
            end
            map.time(v,u) = toc;
                    
        end
    else
        u =  ( parameters.dim_y  ) / parameters.mapping_step +2  ;
        for j = parameters.dim_y+2 : - parameters.mapping_step : 2 % décalage de deux millimètres pour éviter les bloquages
            u = u - 1;
            a = [k  j  parameters.initial_height + delta 180 0 180];
            if robot.arret == 0
                [k j ] % show the current position of the robot / may be useless ( comment it )
                robot.class.set_position(robot.connexion,a);
            end
            map.x(v,u) = k;
            map.y(v,u) = j;
%             measured_height = get_rectified_data(sensor,t,k,j,delta,opo_flag);
            measured_height = sensor.class.get_data(robot,k,j,delta,opo_flag);
            map.i(v,u) =  measured_height ;
            real_time_topography_display(map)
            
            delta = measured_height;
            map.time(v,u) = toc;
        end
    end
end