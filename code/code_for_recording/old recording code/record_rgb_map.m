%global carte
%path(path,'rgb map files')

function record_rgb_map(data,file_name)

%file_name = 'skintest2.rgbmap';
bio_map(:,:,1) = data.b1 ;
bio_map(:,:,2) = data.b2 ;
bio_map(:,:,3) = data.b3 ;
carte_x = data.x;
carte_y = data.y;
carte_z = data.z;
i_1 = data.i1 ;
i_2 = data.i2 ;
i_3 = data.i3 ;


objet.x = carte_x;
objet.y = carte_y;
objet.z = carte_z;
objet.bio1 = bio_map(:,:,1);
objet.bio2 = bio_map(:,:,2);
objet.bio3 = bio_map(:,:,3);

% figure()
% s = surf(carte_x,carte_y,carte_z,bio_map);
% s.FaceAlpha=0.9; % niveau de tranparence
% s.FaceColor = 'interp'; % set color interpolqtion
% s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
% axis equal

% repertoire = 'C:\Users\Administrator\Documents\PAUL\MAIN - TOP\rgb map files\';
% chemin = [repertoire nom_du_fichier];
folder_name = 'rgb map files';
chemin = choix_chemin(folder_name,file_name);

punto = fopen(chemin,'w');

%%% On rentre les dimensions pour la reconstruction %%%
si = size(objet.z);
fprintf(punto,'%f %f %f %f %f %f \n', si(1), si(2), i_1, i_2, i_3, 0 );

%%% On rentre les données dans le document %%%
for i = 1 : si(1)
    for j = 1 : si(2)
        fprintf(punto,'%f %f %f %f %f %f\n',objet.x(i,j), objet.y(i,j), objet.z(i,j), objet.bio1(i,j), objet.bio2(i,j), objet.bio3(i,j) );
    end
end

fclose(punto);