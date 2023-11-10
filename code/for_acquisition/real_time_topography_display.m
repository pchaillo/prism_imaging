function real_time_topography_display()

% FR : Pour afficher la carte en tps réel
% ENG : To display the acquisition of the topography in real time
global carte

figure(3)
axis equal; 
mesh(carte.x,carte.y,carte.i)
axis equal; 

%drawnow ;

