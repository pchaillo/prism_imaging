function real_time_topography_display(map)

% FR : Pour afficher la carte en temps réel
% ENG : To display the acquisition of the topography in real time

figure(3)
axis equal; 
mesh(map.x,map.y,map.i)
axis equal; 


