function map = topographic_acquisition(app, robot,sensor,parameters)
% with time recording

% global map
% global scan
% global zone

update_log(app, 'Creating the map...');

opo_flag = 0 ; % No need to accound for the laser watchdog since this workflow only performs topography

% Initialization of the variable => necessary for real time acquisition display
x_ind = 0;
for pos_x = parameters.mapping_step : parameters.mapping_step : parameters.dim_x + parameters.mapping_step
    x_ind = x_ind + 1 ;
    y_ind = 0;
    for pos_y = 2 : parameters.mapping_step : parameters.dim_y +2
        y_ind = y_ind + 1 ;
        map.x(x_ind,y_ind) = pos_x;
        map.y(x_ind,y_ind) = pos_y;
    end
end

si_c = size(map.x);
map.i = zeros(si_c(1),si_c(2));
x_ind = 0;
delta = 0;

first_point = 1;

for pos_x = parameters.mapping_step : parameters.mapping_step : parameters.dim_x + parameters.mapping_step
    x_ind = x_ind + 1 ;
    if ( mod(x_ind,2) ~= 0 )
        y_ind = 0;
        for pos_y = 2 : parameters.mapping_step : parameters.dim_y +2
            y_ind = y_ind +1;
            position = [pos_x  pos_y  parameters.initial_height + delta 180 0 180];
            if robot.arret == 0
                [pos_x pos_y ] % show the current position of the robot / may be useless ( comment it )
                robot.class.set_position(a);
            end
            map.x(x_ind,y_ind) = pos_x;
            map.y(x_ind,y_ind) = pos_y;
%             measured_height = get_rectified_data(app, sensor,t,pos_x,pos_y,delta,opo_flag);
            measured_height = sensor.class.get_data(robot,pos_x,pos_y,delta,opo_flag);
            map.i(x_ind,y_ind) =  measured_height ;
            real_time_topography_display(map)
            
            delta =  measured_height ;
            
            if first_point == 1
                first_point = 0;
                tic;
            end
            map.time(x_ind,y_ind) = toc;
                    
        end
    else
        y_ind =  ( parameters.dim_y  ) / parameters.mapping_step +2  ;
        for pos_y = parameters.dim_y+2 : - parameters.mapping_step : 2 % 2mm offset to avoid stoppages
            y_ind = y_ind - 1;
            a = [pos_x  pos_y  parameters.initial_height + delta 180 0 180];
            if robot.arret == 0
                update_log(app, string([pos_x pos_y])) % Shows the current position of the robot. May be useless (Comment it)
                robot.class.set_position(a);
            end
            map.x(x_ind,y_ind) = pos_x;
            map.y(x_ind,y_ind) = pos_y;
%             measured_height = get_rectified_data(app, sensor,t,pos_x,pos_y,delta,opo_flag);
            measured_height = sensor.class.get_data(robot,pos_x,pos_y,delta,opo_flag);
            map.i(x_ind,y_ind) =  measured_height ;
            real_time_topography_display(map)
            
            delta = measured_height;
            map.time(x_ind,y_ind) = toc;
        end
    end
end