
function time_diff_med = record_map_time(carte_x,carte_y,carte_z,nom,seuil,carte_time)

% Pour enregistrer la carte .map dans le fichier correspondant
% record the threshold
% record the time ! -> with time output

objet.x = carte_x;
objet.y = carte_y;
objet.z = carte_z;
objet.time = carte_time;


% écart temporel entre les points !
size_time = size(carte_time);
u = 0;
for i = 1 : size_time(1)
    for j = 1 : size_time(2)
        u = u + 1;
        tab_time_r(u) = carte_time(i,j);
    end
end
tab_time = sort(tab_time_r);
for i = 2 : length(tab_time) % crée un tableau des ecarts temporels
    tab_time_diff(i) = tab_time(i) - tab_time(i-1) ;
end
time_diff_med = median(tab_time_diff);
time_diff_moy = mean(tab_time_diff);

figure()
mesh(objet.x,objet.y,objet.z)
axis equal

% file_name = 'a_test.map';

folder_name = 'map files';

chemin = choix_chemin(folder_name,nom);

punto = fopen(chemin,'w');

%%% On rentre les dimensions pour la reconstruction %%%
si = size(objet.z);
fprintf(punto,'%f %f %f %f \n', si(1), si(2),seuil,time_diff_med );

%%% On rentre les données dans le document %%%
for i = 1 : si(1)
    for j = 1 : si(2)
        fprintf(punto,'%f %f %f %f \n',objet.x(i,j), objet.y(i,j), objet.z(i,j),objet.time(i,j) );
    end
end

fclose(punto);

fprintf('Recommended time gap for peak detection %f \n', time_diff_med);