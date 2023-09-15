function time_diff_med = record_map(carte_x,carte_y,carte_z,name,seuil,carte_time)

% Pour enregistrer la carte .map dans le fichier correspondant
% record the threshold
% record the time ! -> with time output

objet.x = carte_x;
objet.y = carte_y;
objet.z = carte_z;
objet.time = carte_time;
size_time = size(carte_time);
u = 0;

for i = 1 : size_time(1)
    if ( mod(i,2) ~= 0 )
        for j = 1 : size_time(2)
            u = u + 1;
            tab_time(u) = carte_time(i,j) ;
        end
    else
        for j = size_time(2) : -1 : 1 % décalage de deux millimètres pour éviter les bloquages
            u = u + 1;
            tab_time(u) = carte_time(i,j) ;
        end
    end
end

for i = 2 : length(tab_time) % crée un tableau des ecarts temporels
    tab_time_diff(i) = tab_time(i) - tab_time(i-1) ;
end
time_diff_med = median(tab_time_diff);
time_diff_moy = mean(tab_time_diff);

figure()
mesh(objet.x,objet.y,objet.z)
title(name)
axis equal

folder_name = 'map files';

chemin = choix_chemin(folder_name,name);

punto = fopen(chemin,'w');

%%% We set the size of the map on the top of the file for reconstruction %%%
si = size(objet.z);
fprintf(punto,'%f %f %f %f \n', si(1), si(2),seuil,time_diff_med );

%%% We store the data in the file %%%
for i = 1 : si(1)
    for j = 1 : si(2)
        fprintf(punto,'%f %f %f %f \n',objet.x(i,j), objet.y(i,j), objet.z(i,j),objet.time(i,j) );
    end
end

fclose(punto);

fprintf('Recommended time gap for peak detection %f \n', time_diff_med);