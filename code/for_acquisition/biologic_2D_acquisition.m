
function map = biologic_2D_acquisition(app, robot,source,parameters,time_ref)

%with spectro time_ref

%pas d'adaptation angulaire

update_log(app, 'Biometric Scan')

global state

x_ind = 0;

if source.continuous_flag == 1
    source.class.continuous_trigerring(app)
end

for pos_x = parameters.x_offset : parameters.mapping_step : parameters.dim_x + parameters.x_offset
    x_ind = x_ind + 1 ;
    if ( mod(x_ind,2) ~= 0 )
        y_ind = 0;
        for pos_y = parameters.y_offset : parameters.mapping_step : parameters.dim_y + parameters.y_offset
            if emergency_check(app)

                y_ind = y_ind +1;
                position = [pos_x  pos_y  parameters.initial_height 180 0 180];
                if state.arret == 0
                    [pos_x pos_y ] % show the current position of the robot / may be useless ( comment it )
                    robot.class.set_position(position);
                end
                map.x(x_ind,y_ind) = pos_x;
                map.y(x_ind,y_ind) = pos_y;
                map.i(x_ind,y_ind) =  0 ;

                if source.continuous_flag == 0
                    source.class.trigger(source.nb_shot, app)
                end

                pause(source.time_step);
                map.time(x_ind,y_ind) = toc(time_ref);
            end
        end
    else
        y_ind =  ( parameters.dim_y  ) / parameters.mapping_step + parameters.y_offset  ;
        for pos_y = parameters.dim_y + parameters.y_offset : -parameters.mapping_step : parameters.y_offset % décalage de deux millimètres pour éviter les bloquages
            if emergency_check(app)

                y_ind = y_ind - 1;
                position = [pos_x  pos_y  parameters.initial_height 180 0 180];
                if state.arret == 0
                    [pos_x pos_y ] % show the current position of the robot / may be useless ( comment it )
                    robot.class.set_position(position);
                end
                map.x(x_ind,y_ind) = pos_x;
                map.y(x_ind,y_ind) = pos_y;
                map.i(x_ind,y_ind) =  0 ;

                if source.continuous_flag == 0
                    source.class.trigger( source.nb_shot, app)
                end

                pause(source.time_step);

                map.time(x_ind,y_ind) = toc(time_ref);
            end
        end
    end
end

if source.continuous_flag == 1
    source.class.STOP_continuous_trigerring( app)
end

end