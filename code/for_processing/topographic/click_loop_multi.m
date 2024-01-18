function map_z_out = click_loop_multi(app, carte,map_z,min_threshold,max_threshold)

% Recursive function to select, step by step, all the points that the users
% wants to rectify

fig = figure();
mesh(carte.x,carte.y,map_z)
title({'Click on the point you want to rectify by placing a cursor on it' ,'(you may place multiple cursor with CRTL key)', 'Then press any key to go to the next step,',' and the S key to save the corrected map'});
axis equal

datacursormode on
dcm_obj = datacursormode(gcf);
set(gcf,'CurrentCharacter','@');

pause()

k = get(gcf,'CurrentCharacter');

c_info = getCursorInfo(dcm_obj);

l = length(c_info);

if l ~= 0
    for i = 1 : l
        z_value(i) = c_info(i).Position(3) ;
        [x_v_r,y_v_r] = find (map_z == z_value(i));

        if length(x_v_r) > 1
            x_v = x_v_r(1);
            y_v = y_v_r(1);
            update_log(app, string(y_v))
            update_log(app, 'Warning: The exact value is false. It may remove an unselected point');
        else
            x_v = x_v_r;
            y_v = y_v_r;
        end

        x_tab(i) = x_v;
        y_tab(i) = y_v;
    end

    [map_out1, nb_err] = map_rectification_multi(map_z,min_threshold,max_threshold,x_tab,y_tab);
end
close(fig);

if k == 's' % S key to stop the recursive loop and get out the function and record the rectified map
%     This input should definitely be explained in the GUI, at least with a
%     tooltip
    map_z_out = map_z;
else
    map_z_out = click_loop_multi(app, carte,map_out1,min_threshold,max_threshold);
end
