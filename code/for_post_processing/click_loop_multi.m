function map_out = click_loop_multi(carte,map_z,min_threshold,max_threshold)

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

% a = set(h_fig,'KeyPressFcn',@pressed_key3);
k=get(gcf,'CurrentCharacter');

%carte.z = map_z;

c_info = getCursorInfo(dcm_obj);

l = length(c_info);

if l ~= 0
    for i = 1 : l
        z_value(i) = c_info(i).Position(3) ;
        [x_v_r,y_v_r] = find (map_z == z_value(i));

        if length(x_v_r) > 1
            x_v = x_v_r(1);
            y_v = y_v_r(1)
            disp('Attention, risque de supression du mauvais point, valeur exacte fausse');
        else
            x_v = x_v_r;
            y_v = y_v_r;
        end

        x_tab(i) = x_v;
        y_tab(i) = y_v;
    end

    [map_out1, nb_err ] = map_rectification_multi(map_z,min_threshold,max_threshold,x_tab,y_tab);
end
close(fig);

if k == 's'
    map_out = map_z;
else
    map_out = click_loop_multi(carte,map_out1,min_threshold,max_threshold);
end
