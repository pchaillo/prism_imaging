function carte_f = click_loop_multi(carte,carte_z,seuil_min,seuil_max)

% Recursive function to select, step by step, all the points that the users
% wants to rectify

fig = figure();
mesh(carte.x,carte.y,carte_z)
axis equal

datacursormode on
dcm_obj = datacursormode(gcf);
set(gcf,'CurrentCharacter','@'); 

pause()

% a = set(h_fig,'KeyPressFcn',@pressed_key3);
k=get(gcf,'CurrentCharacter');

%carte.z = carte_z;

if k == 's'
    carte_f = carte_z;
else
    
    c_info = getCursorInfo(dcm_obj);
    
    l = length(c_info);
    
    for i = 1 : l
        z_value(i) = c_info(i).Position(3) ;
        [x_v_r,y_v_r] = find (carte_z == z_value(i));
        
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
    
%     seuil_min = 0;
%     seuil_max = 8;
    
    [carte_f1, nb_err ] = map_rectification_multi(carte_z,seuil_min,seuil_max,x_tab,y_tab);
    
    close(fig); 
    
    carte_f = click_loop_multi(carte,carte_f1,seuil_min,seuil_max);
    
end


% figure()
% mesh(carte.x,carte.y,carte_f)
% axis equal

