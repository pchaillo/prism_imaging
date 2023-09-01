
clc
% clear all
%close all
% Pour charger et afficher une carte biométrique

path(path,'BIOmap files')

out = load('20211026_oc_47-1_neg2_744.biomap');

si = size(out);

%%% Récupération des dimensions %%%
si_1 = out(1,1);
si_2 = out(1,2);
import_limits(1) = out(1,3);
import_limits(2) = out(1,4);

u = 1;

for i = 1 : si_1
    for j = 1 : si_2
        u = u + 1;
        carte_x(i,j) = out(u,1);
        carte_y(i,j) = out(u,2);
        carte_z(i,j) = out(u,3);
        bio_map(i,j) = out(u,4);
    end
end

figure()
s = surf(carte_x,carte_y,carte_z,bio_map);
s.FaceAlpha=0.9; % niveau de tranparence
s.FaceColor = 'flat'; % set color interpolqtion
s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
title(['biometric map, mass limits : ', num2str(import_limits(1)),'  ',num2str(import_limits(2))]);
axis equal
%grid off
axis off