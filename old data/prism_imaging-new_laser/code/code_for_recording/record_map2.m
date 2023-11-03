function record_map2(carte_x,carte_y,carte_z,nom,seuil)

% Pour enregistrer la carte .map dans le fichier correspondant
% record the threshold

objet.x = carte_x;
objet.y = carte_y;
objet.z = carte_z;

figure()
mesh(objet.x,objet.y,objet.z)
axis equal

% file_name = 'a_test.map';

folder_name = 'map files';

chemin = choix_chemin(folder_name,nom);

punto = fopen(chemin,'w');

%%% On rentre les dimensions pour la reconstruction %%%
si = size(objet.z);
fprintf(punto,'%f %f %f \n', si(1), si(2),seuil );

%%% On rentre les données dans le document %%%
for i = 1 : si(1)
    for j = 1 : si(2)
        fprintf(punto,'%f %f %f \n',objet.x(i,j), objet.y(i,j), objet.z(i,j) );
    end
end

fclose(punto);