% A supprimer
function record_map_without_time_deleted(map_x,map_y,map_z,name,seuil)

% To store map files without time

objet.x = map_x;
objet.y = map_y;
objet.z = map_z;

figure()
mesh(objet.x,objet.y,objet.z)
title(name)
axis equal

folder_name = 'files/map files';

chemin = path_editor(folder_name,name);

punto = fopen(chemin,'w');

%%% We set the size of the map on the top of the file for reconstruction %%%
si = size(objet.z);
fprintf(punto,'%f %f %f \n', si(1), si(2),seuil );

%%% We store the data in the file %%%
for i = 1 : si(1)
    for j = 1 : si(2)
        fprintf(punto,'%f %f %f \n',objet.x(i,j), objet.y(i,j), objet.z(i,j) );
    end
end

fclose(punto);