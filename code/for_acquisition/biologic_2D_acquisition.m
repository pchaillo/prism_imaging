
function biologic_2D_acquisition(app, robot,laser,nb_shot,t_b,time_ref)

%with spectro time_ref

%pas d'adaptation angulaire

upate_log(app, app.info_log, 'Biometric Scan')

% global robot
global map
global scan
global state
global zone

v = 0;

if laser.continuous_flag == 1
    laser.class.tir_continu_ON(laser.connexion, app)
end

for k = zone.dec : scan.pas : zone.dim_x+zone.dec
    v = v + 1 ;
    if ( mod(v,2) ~= 0 )
        u = 0;
        for j = 2 : scan.pas : zone.dim_y +2
            u = u +1;
            a = [k  j  scan.dh 180 0 180];
            if state.arret == 0
                [k j ] % show the current position of the robot / may be useless ( comment it )
                robot.class.set_position(robot.connexion,a);
            end
            map.x(v,u) = k;
            map.y(v,u) = j;
            map.i(v,u) =  0 ;

            if laser.continuous_flag == 0
                laser.class.tir(laser.connexion, nb_shot, app)
            end

            pause(t_b);
            map.time(v,u) = toc(time_ref);
        end
    else
        u =  ( zone.dim_y  ) / scan.pas +2  ;
        for j = zone.dim_y+2 : -scan.pas : 2 % décalage de deux millimètres pour éviter les bloquages
            u = u - 1;
            a = [k  j  scan.dh 180 0 180];
            if state.arret == 0
                [k j ] % show the current position of the robot / may be useless ( comment it )
                robot.class.set_position(robot.connexion,a);
            end
            map.x(v,u) = k;
            map.y(v,u) = j;
            map.i(v,u) =  0 ;

            if laser.continuous_flag == 0
                laser.class.tir(laser.connexion, nb_shot, app)
            end
            
            pause(t_b);
            
            map.time(v,u) = toc(time_ref);
        end
    end
end

if laser.continuous_flag == 1
    laser.class.tir_continu_OFF(laser.connexion, app)
end

end