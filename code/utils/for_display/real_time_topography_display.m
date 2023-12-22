function real_time_topography_display(map)
% Passer map en argument et supprimer la variable globale ? #TODO

% FR : Pour afficher la carte en temps réel
% ENG : To display the acquisition of the topography in real time

% global carte

figure(3) % #TODO : 3 ? not better do don't set anything ?
axis equal; 
mesh(map.x,map.y,map.i)
axis equal; 


