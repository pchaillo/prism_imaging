% Pour charger la carte (.map) avec le seuil
% avec les temps de tir enregistrés !

clc
clear all

close all

path(path,'map files')

nom = '3D_acquisition_tracking.map';

out = load(nom);

si = size(out);
i = 0;

for u = 1 : length(out)
    if  out(u,3) > -10
        i = i+1;
        carte_x(i) = out(i,1);
        carte_y(i) = out(i,2);
        carte_z(i) = out(i,3);
        carte_time(i) = out(i,4);
    end
end


figure()
%surf(carte_x,carte_y,carte_z);
% mesh(carte_x,carte_y,carte_z);
pcshow([carte_z(:) carte_y(:) carte_x(:)])
title(['topographic map : ',nom]);
% colormap(autumn);
axis equal
grid off
axis off

