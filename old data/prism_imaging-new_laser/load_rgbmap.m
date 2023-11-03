% Permet de charger une carte biométrique en RGB (.rgbmap) contenant les
% informations biométriques de 3 masses d'ionisation différentes sur la
% même carte topographique

clc
close all
clear all

path(path,'BIOmap files')
path(path,'rgb map files')

out = load('mouse_test.rgbmap');

si = size(out);

%%% Récupération des dimensions %%%
si_1 = out(1,1);
si_2 = out(1,2);
i_1 = out(1,3);
i_2 = out(1,4);
i_3 = out(1,5);

u = 1;

for i = 1 : si_1
    for j = 1 : si_2
        u = u + 1;
        carte_x(i,j) = out(u,1);
        carte_y(i,j) = out(u,2);
        carte_z(i,j) = out(u,3);
        bio_map1(i,j) = out(u,4);
        bio_map2(i,j) = out(u,5);
        bio_map3(i,j) = out(u,6);
    end
end

bio_map(:,:,1) = bio_map1 ;
bio_map(:,:,2) = bio_map2 ;
bio_map(:,:,3) = bio_map3 ;

figure()
s = surf(carte_x,carte_y,carte_z,bio_map);
s.FaceAlpha=0.9; % niveau de tranparence
s.FaceColor = 'interp'; % set color interpolqtion
s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
title(['biometric map, mass limits : ', num2str(i_1),'  ',num2str(i_2),' ',num2str(i_3)]);
axis equal