function biologic_3D_acquisition(app, robot,sensor,source,parameters,time_ref)

% with spectro time_ref

% mono_carto_top_real_time3
% rajoute msg state pour watchdog opotek (avec mesure8)
% un seul passage => nvx capteur
% cartographie la zone et non l'objet
% avec enregistrement des temps

global state

update_log(app, 'Creating the map');

watchdog_flag = 0 ; % Message sent upon repositioning to deal with the watchdog => Watchdog flag ? #TODO ?

%% Creation of the empty map variable (useful for real_display of the topographic map)
x_ind = 0;
for pos_x = parameters.x_offset : parameters.mapping_step : parameters.dim_x + parameters.x_offset
    x_ind = x_ind + 1 ;
    y_ind = 0;
    for pos_y = parameters.y_offset  : parameters.mapping_step : parameters.dim_y + parameters.y_offset 
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

for pos_x = parameters.x_offset : parameters.mapping_step : parameters.dim_x + parameters.x_offset
    x_ind = x_ind + 1 ;
    if ( mod(x_ind,2) ~= 0 )
        y_ind = 0;
        for pos_y = parameters.y_offset  : parameters.mapping_step : parameters.dim_y + parameters.y_offset 
            y_ind = y_ind +1;
            position = [pos_x  pos_y  parameters.initial_height+delta 180 0 180];
            if state.arret == 0
                [pos_x pos_y ] % Shows the current position of the robot. May be useless (Comment it)
                robot.class.set_position(position);
            end
            map.x(x_ind,y_ind) = pos_x;
            map.y(x_ind,y_ind) = pos_y;
            h_m = sensor.class.get_data(app, sensor,robot,pos_x,pos_y,delta,watchdog_flag);
            map.i(x_ind,y_ind) =  h_m ;

            % state_double = get_state(app, opotek); % pour watchdog

            real_time_topography_display(map)

            delta = h_m;

            position = [pos_x  pos_y parameters.initial_height+delta 180 0 180]; % Repositions the robot to ensure that it remains at a proper distance (parameters.initial_height) of the surface
            if state.arret == 0
                [pos_x pos_y ] % Shows the current position of the robot. May be useless (Comment it)
                robot.class.set_position(position);
                if source.continuous_flag == 0
                    source.class.trigger(source.nb_shot, app)
                end
                map.time(x_ind,y_ind) = toc(time_ref);
                pause(source.t_b);
            end

        end
    else
        y_ind =  ( parameters.dim_y  ) / parameters.mapping_step + parameters.y_offset   ;
        for pos_y = parameters.dim_y + parameters.y_offset  : - parameters.mapping_step : parameters.y_offset  % décalage de deux millimètres pour éviter les bloquages
            y_ind = y_ind - 1;
            position = [pos_x  pos_y  parameters.initial_height+delta 180 0 180];
            if state.arret == 0
                [pos_x pos_y ] % show the current position of the robot / may be useless ( comment it )
                robot.class.set_position(position);
            end
            map.x(x_ind,y_ind) = pos_x;
            map.y(x_ind,y_ind) = pos_y;
            h_m = sensor.class.get_data(sensor,robot,pos_x,pos_y,delta,watchdog_flag);
            map.i(x_ind,y_ind) =  h_m ;

            % state_double = get_state(app, opotek); % pour watchdog

            real_time_topography_display(map)

            delta = h_m;

            position = [pos_x  pos_y  parameters.initial_height+delta 180 0 180]; %replace le robot pour s'assurer d'etre a la distance parameters.initial_height de la surface
            if state.arret == 0
                [pos_x pos_y ] % show the current position of the robot / may be useless ( comment it )
                robot.class.set_position(position);
                if source.continuous_flag == 0
                    source.class.trigger(source.nb_shot, app)
                end                
                map.time(x_ind,y_ind) = toc(time_ref);
                pause(source.t_b);
            end
        end
    end

end

if source.continuous_flag == 1
    source.class.STOP_continuous_trigerring(app)
end

end