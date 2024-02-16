
function biologic_2D_acquisition(app, robot,laser,nb_shot,t_b,time_ref)

%with spectro time_ref

%pas d'adaptation angulaire

upate_log(app, app.info_log, 'Biometric Scan')

% global robot
global map
global scan
global state
global zone

x_ind = 0;

if laser.continuous_flag == 1
    laser.class.tir_continu_ON(app)
end

for pos_x = zone.dec : scan.pas : zone.dim_x+zone.dec
    x_ind = x_ind + 1 ;
    if ( mod(x_ind,2) ~= 0 )
        y_ind = 0;
        for pos_y = 2 : scan.pas : zone.dim_y +2
            y_ind = y_ind +1;
            position = [pos_x  pos_y  scan.dh 180 0 180];
            if state.arret == 0
                [pos_x pos_y ] % show the current position of the robot / may be useless ( comment it )
                robot.class.set_position(position);
            end
            map.x(x_ind,y_ind) = pos_x;
            map.y(x_ind,y_ind) = pos_y;
            map.i(x_ind,y_ind) =  0 ;

            if laser.continuous_flag == 0
                laser.class.tir(nb_shot, app)
            end

            pause(t_b);
            map.time(x_ind,y_ind) = toc(time_ref);
        end
    else
        y_ind =  ( zone.dim_y  ) / scan.pas +2  ;
        for pos_y = zone.dim_y+2 : -scan.pas : 2 % décalage de deux millimètres pour éviter les bloquages
            y_ind = y_ind - 1;
            position = [pos_x  pos_y  scan.dh 180 0 180];
            if state.arret == 0
                [pos_x pos_y ] % show the current position of the robot / may be useless ( comment it )
                robot.class.set_position(position);
            end
            map.x(x_ind,y_ind) = pos_x;
            map.y(x_ind,y_ind) = pos_y;
            map.i(x_ind,y_ind) =  0 ;

            if laser.continuous_flag == 0
                laser.class.tir( nb_shot, app)
            end
            
            pause(t_b);
            
            map.time(x_ind,y_ind) = toc(time_ref);
        end
    end
end

if laser.continuous_flag == 1
    laser.class.tir_continu_OFF( app)
end

end