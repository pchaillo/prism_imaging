function topographic_acquisition(robot,sensor)
% with time recording

global carte
global scan
global zone

disp('Creating the map...');

opo_flag = 0 ; % sans message lors du repositionnement pour le watchdog % inutile = pas de laser ici !

% Initialisation of the variable => necessary for real time acquisition display
v = 0;
for k = zone.dec : scan.pas : zone.dim_x+zone.dec
    v = v + 1 ;
    u = 0;
    for j = 2 : scan.pas : zone.dim_y +2
        u = u + 1 ;
        carte.x(v,u) = k;
        carte.y(v,u) = j;
    end
end

si_c = size(carte.x);
carte.i = zeros(si_c(1),si_c(2));
v = 0;
delta = 0;

first_point = 1;

for k = zone.dec : scan.pas : zone.dim_x+zone.dec
    v = v + 1 ;
    if ( mod(v,2) ~= 0 )
        u = 0;
        for j = 2 : scan.pas : zone.dim_y +2
            u = u +1;
            a = [k  j  scan.dh+delta 180 0 180];
            if robot.arret == 0
                [k j ] % show the current position of the robot / may be useless ( comment it )
                robot.class.set_position(robot.connexion,a);
            end
            carte.x(v,u) = k;
            carte.y(v,u) = j;
%             measured_height = get_rectified_data(sensor,t,k,j,delta,opo_flag);

            measured_height = sensor.class.get_data(robot,k,j,delta,opo_flag);
            carte.i(v,u) =  measured_height ;
            real_time_topography_display()
            
            delta =  measured_height ;
            
            if first_point == 1
                first_point = 0;
                tic;
            end
            carte.time(v,u) = toc;
                    
        end
    else
        u =  ( zone.dim_y  ) / scan.pas +2  ;
        for j = zone.dim_y+2 : -scan.pas : 2 % décalage de deux millimètres pour éviter les bloquages
            u = u - 1;
            a = [k  j  scan.dh+delta 180 0 180];
            if robot.arret == 0
                [k j ] % show the current position of the robot / may be useless ( comment it )
                robot.class.set_position(robot.connexion,a);
            end
            carte.x(v,u) = k;
            carte.y(v,u) = j;
%             measured_height = get_rectified_data(sensor,t,k,j,delta,opo_flag);
            measured_height = sensor.class.get_data(robot,k,j,delta,opo_flag);
            carte.i(v,u) =  measured_height ;
            real_time_topography_display()
            
            delta = measured_height;
            carte.time(v,u) = toc;
        end
    end
end