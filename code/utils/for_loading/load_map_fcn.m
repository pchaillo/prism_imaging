function map = load_map_fcn(nom)

% Load data from .map file into Matlab

out = load(nom);
si = size(out);

%%% ENG : Dimension recovery // FR : Récupération des dimensions %%%
si_1 = out(1,1);
si_2 = out(1,2);

seuil = out(1,3);

u = 1;
if si(2) > 3
    t_b = out(1,4);
    for i = 1 : si_1
        for j = 1 : si_2
            u = u + 1;
            map_x(i,j) = out(u,1);
            map_y(i,j) = out(u,2);
            map_z(i,j) = out(u,3);
            map_time(i,j) = out(u,4);
        end
    end
else
    for i = 1 : si_1
        for j = 1 : si_2
            u = u + 1;
            map_x(i,j) = out(u,1);
            map_y(i,j) = out(u,2);
            map_z(i,j) = out(u,3);
        end
    end
end

map.x = map_x;
map.y = map_y;
map.z = map_z;

if exist('map_time') % to be compatible with map file without time recording
    map.time = map_time;
end