% to record the biometric map in the .biomap firecord_BIOmap_time(carte_x,carte_y,carte_z,bio_map,nom,limits,carte_time,time_diff_med)les

function record_BIOmap_time(carte_x,carte_y,carte_z,bio_map,nom,limits,carte_time,time_diff_med)

% also record the map time in the biomap

path(path,'BIOmap files')

objet.x = carte_x;
objet.y = carte_y;
objet.z = carte_z;
objet.time = carte_time;

% figure() % uncomment to display the image
% s = surf(carte_x,carte_y,carte_z,bio_map);
% s.FaceAlpha=0.9; % niveau de tranparence
% s.FaceColor = 'interp'; % set color interpolqtion
% s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
% axis equal

folder_name = 'BIOmap files';
chemin  = choix_chemin(folder_name,nom);

punto = fopen(chemin,'w');

%%% On rentre les dimensions pour la reconstruction %%%
si = size(objet.z);
fprintf(punto,'%f %f %f %f %f \n', si(1), si(2), limits(1), limits(2),time_diff_med );

%%% On rentre les données dans le document %%%
for i = 1 : si(1)
    for j = 1 : si(2)
        fprintf(punto,'%f %f %f %f %f\n',objet.x(i,j), objet.y(i,j), objet.z(i,j), objet.bio(i,j),objet.time(i,j) );
    end
end

fclose(punto);

end