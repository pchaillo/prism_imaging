function biologic_3D_acquisition(app, robot,sensor,source,t_b,nb_shot,time_ref)

% with spectro time_ref

% mono_carto_top_real_time3
% rajoute msg state pour watchdog opotek (avec mesure8)
% un seul passage => nvx capteur
% cartographie la zone et non l'objet
% avec enregistrement des temps

% global map % Try to remove those implicit dependencies
% global scan
% global zone
global state

update_log(app, 'Creating the map');

opo_flag = 0 ; % Message sent upon repositioning to deal with the watchdog

%% Creation of the empty map variable (useful for real_display of the topographic map)
x_ind = 0;
for pos_x = zone.dec : scan.pas : zone.dim_x+zone.dec
    x_ind = x_ind + 1 ;
    y_ind = 0;
    for pos_y = 2 : scan.pas : zone.dim_y +2
        y_ind = y_ind + 1 ;
        map.x(x_ind,y_ind) = pos_x;
        map.y(x_ind,y_ind) = pos_y;
    end
end

if source.continuous_flag == 1
    source.class.continuous_trigerring(app)
end

si_c = size(map.x);
map.i = zeros(si_c(1),si_c(2));
x_ind = 0;
delta = 0;

for pos_x = zone.dec : scan.pas : zone.dim_x + zone.dec
    x_ind = x_ind + 1 ;
    if ( mod(x_ind,2) ~= 0 )
        y_ind = 0;
        for pos_y = 2 : scan.pas : zone.dim_y +2
            y_ind = y_ind +1;
            position = [pos_x  pos_y  scan.dh+delta 180 0 180];
            if state.arret == 0
                [pos_x pos_y ] % Shows the current position of the robot. May be useless (Comment it)
                robot.class.set_position(position);
            end
            map.x(x_ind,y_ind) = pos_x;
            map.y(x_ind,y_ind) = pos_y;
            h_m = get_rectified_data(app, sensor,robot,pos_x,pos_y,delta,opo_flag);
            map.i(x_ind,y_ind) =  h_m ;

            % state_double = get_state(app, opotek); % pour watchdog

            real_time_topography_display(map)

            delta = h_m;

            position = [pos_x  pos_y  scan.dh+delta 180 0 180]; % Repositions the robot to ensure that it remains at a proper distance (scan.dh) of the surface
            if state.arret == 0
                [pos_x pos_y ] % Shows the current position of the robot. May be useless (Comment it)
                robot.class.set_position(position);
                if source.continuous_flag == 0
                    source.class.trigger(nb_shot, app)
                end
                map.time(x_ind,y_ind) = toc(time_ref);
                pause(t_b);
            end

        end
    else
        y_ind =  ( zone.dim_y  ) / scan.pas +2  ;
        for pos_y = zone.dim_y+2 : -scan.pas : 2 % décalage de deux millimètres pour éviter les bloquages
            y_ind = y_ind - 1;
            position = [pos_x  pos_y  scan.dh+delta 180 0 180];
            if state.arret == 0
                [pos_x pos_y ] % show the current position of the robot / may be useless ( comment it )
                robot.class.set_position(position);
            end
            map.x(x_ind,y_ind) = pos_x;
            map.y(x_ind,y_ind) = pos_y;
            h_m = get_rectified_data(app, sensor,robot,pos_x,pos_y,delta,opo_flag);
            map.i(x_ind,y_ind) =  h_m ;

            % state_double = get_state(app, opotek); % pour watchdog

            real_time_topography_display(map)

            delta = h_m;

            position = [pos_x  pos_y  scan.dh+delta 180 0 180]; %replace le robot pour s'assurer d'etre a la distance scan.dh de la surface
            if state.arret == 0
                [pos_x pos_y ] % show the current position of the robot / may be useless ( comment it )
                robot.class.set_position(position);
                if source.continuous_flag == 0
                    source.class.trigger(nb_shot, app)
                end                
                map.time(x_ind,y_ind) = toc(time_ref);
                pause(t_b);
            end
        end
    end

end

if source.continuous_flag == 1
    source.class.STOP_continuous_trigerring(app)
end

end