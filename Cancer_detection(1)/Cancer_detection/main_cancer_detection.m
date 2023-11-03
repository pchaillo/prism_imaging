% 
% mzxml_r = "nom_du_fichier";
% 
% nom_mzxml = strcat(mzxml_r,'.mzXML');
% mzXML.Struct = mzxmlread(nom_mzxml);
% 
% [bio_dat ,time,g] = peak_detection_pt_par_pt_8(mzXML.Struct,threshold_begin,t_b,min_threshold,intern_flag,tolerance,carte_time); % take only the usefull informations

%%%%%%%%%%%%%%%% Paramètres %%%%%%%%%%%%%%
nom_map = "M13_T1.map";
nom_mat = "M13_T1.mat";
nom_csv = "M13_T1_H2.csv";
load(nom_mat);

limits = [885.4 885.7];
threshold = 7e3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ind = 0;

for i = 1 : length(bio_dat)
    value = set_peaks_norm4(limits,bio_dat(i));
    if value > threshold
        bool_cancer(i) = 1; % booleen qui determine si il y a cancer ou pas
        ind = ind + 1;
        i_tab(ind) = i;
        scan_tab(ind) = bio_dat(i).num;
    else 
        bool_cancer(i) = 0;
    end
end

carte = load_map4_fcn(nom_map);
carte_time = carte.time;
carte_x = carte.x;
carte_y = carte.y;
carte_z = carte.z;

si = size(carte_z);

carte_ind = time_to_indice_3(carte_time);

d_ind = 0 ;

for i =  1  :  si(1)
    for j = 1 : si(2)
        bool_map(i,j) = bool_cancer(carte_ind(i,j));
%         d_ind = d_ind + 1;
%         bio_map(i,j)= value(carte_ind(i,j))*med;
%         %             bio_num(i,j) = bio_dat.num(carte_ind(i,j));
%         bio_num(i,j) = bio_dat(carte_ind(i,j)).num;
%         deiso_tab(d_ind) = {bio_dat(carte_ind(i,j)).deisotoped};
    end
end

bio_ind = carte_ind ;

[ carte_x,carte_y,carte_z,bool_map  ] = fix_border_2(carte_x,carte_y,carte_z,bool_map,bio_ind);

fprintf('(%s) - Done, displaying the image\n', datestr(now,'HH:MM:SS'));
figure()
s = surf(carte_x,carte_y,carte_z,bool_map);
s.FaceAlpha = 0.9; % niveau de transparence
s.FaceColor = 'flat'; % set color interpolation or not
s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
axis equal
title(['biometric map, mass limits : ', num2str(limits(1)),'  ',num2str(limits(2))]);

% data = rand(100, 3);  % Test data
csvwrite(nom_csv, scan_tab);

