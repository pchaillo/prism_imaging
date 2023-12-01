function carte = load_map_fcn(nom)

path(path,'map files')

out = load(nom);

si = size(out);

%%% Récupération des dimensions %%%
si_1 = out(1,1);
si_2 = out(1,2);

seuil = out(1,3);

u = 1;

if si(2) > 3
    t_b = out(1,4);
    for i = 1 : si_1
        for j = 1 : si_2
            u = u + 1;
            carte_x(i,j) = out(u,1);
            carte_y(i,j) = out(u,2);
            carte_z(i,j) = out(u,3);
            carte_time(i,j) = out(u,4);
        end
    end
else
    for i = 1 : si_1
        for j = 1 : si_2
            u = u + 1;
            carte_x(i,j) = out(u,1);
            carte_y(i,j) = out(u,2);
            carte_z(i,j) = out(u,3);
        end
    end
end

% figure()
% %surf(carte_x,carte_y,carte_z);
% mesh(carte_x,carte_y,carte_z);
% % colormap(autumn);
% axis equal
% grid off
% axis off

carte.x = carte_x;
carte.y = carte_y;
carte.z = carte_z;

if exist('carte_time') % to be compatible with map file without time recording
    carte.time = carte_time;
end