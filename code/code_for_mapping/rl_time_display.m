function rl_time_display()

% Pour afficher la carte en tps réel

global carte

figure(3)
axis equal; 
mesh(carte.x,carte.y,carte.i)
axis equal; 

%drawnow ;

