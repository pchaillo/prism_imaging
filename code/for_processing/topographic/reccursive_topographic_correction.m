function map_z_out = reccursive_topographic_correction(app, map, map_z,min_threshold,max_threshold)

% Recursive function to select, step by step, all the points that the users
% wants to rectify

fig = figure();
mesh(map.x,map.y,map_z) % map_z separed for recursive usage
title({'Click on the point you want to rectify by placing a cursor on it' ,'(you may place multiple cursor with CRTL key)', 'Then press any key to go to the next step,',' and the S key to save the corrected map'});
axis equal

datacursormode on
dcm_obj = datacursormode(gcf);
set(gcf,'CurrentCharacter','@');

pause()

current_key = get(gcf,'CurrentCharacter');

cursor_info = getCursorInfo(dcm_obj);

l = length(cursor_info);

if l ~= 0
    for i = 1 : l

        selected_x_pos = cursor_info(i).Position(1);
        selected_y_pos = cursor_info(i).Position(2);

        [x_list_raw,~] = find (map.x == selected_x_pos);% && map.y == selected_y_pos);
        x = unique(x_list_raw);
        [~,y_list_raw] = find (map.y == selected_y_pos);
        y = unique(y_list_raw);
       
        if length(v) > 1 % old security check => should be useless now ?
            v = v(1);
            u = u(1);
            update_log(app, string(y_v))
            update_log(app, 'Warning: The exact value is false. It may remove an unselected point');
        end

        x_list(i) = x;
        y_list(i) = y;
        
    end

    [map_out, nb_err] = map_rectification_multi(map_z,min_threshold,max_threshold,x_list,y_list);
end
close(fig);

if current_key == 's' % S key to stop the recursive loop and get out the function and record the rectified map
%     This input should definitely be explained in the GUI, at least with a
%     tooltip
    map_z_out = map_z;
else
    map_z_out = reccursive_topographic_correction(app, map,map_out,min_threshold,max_threshold);
end
