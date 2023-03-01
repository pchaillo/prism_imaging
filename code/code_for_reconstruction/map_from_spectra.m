function map_from_spectra(bio_dat,carte)

plot_all_spectra(bio_dat);

[x1,y1] = ginput(1);
[x2,y2] = ginput(1);

if x1 < x2 
    limits = [x1 x2];
else
    limits = [x2 x1];
end

carte_x = carte.x;
carte_y = carte.y;
carte_z = carte.z;
if isfield(carte,'time')
    carte_time = carte.time;
end

fprintf('(%s) - The map file is loaded \n', datestr(now,'HH:MM:SS'));
fprintf('(%s) - Starting to build the intensity matrix\n', datestr(now,'HH:MM:SS'));

if isfield(carte,'time')
    time_flag = 1;
    %[ bio_ind ,bio_map ] = mzXML_on_map_norm12(bio_dat,carte_z,limits,carte_time); % put the information on the map
else
    time_flag = 0;
    %[ bio_ind ,bio_map ] = mzXML_on_map_norm8_4(bio_dat,carte_z,limits,seuil); % put the information on the map
end

<<<<<<< HEAD
%[ bio_ind, bio_num, bio_map, deiso_tab] = mzXML_on_map_norm17(bio_dat,carte_z,limits,carte_time,time_flag,loud_flag);
[ bio_ind ,bio_map ] = mzXML_on_map_norm13(bio_dat,carte_z,limits,carte_time,time_flag);
=======
[ bio_ind ,bio_map ] = mzXML_on_map_norm13(bio_dat,carte_z,limits,carte_time,time_flag); 
>>>>>>> prism_copy_for_tests

[ carte_x,carte_y,carte_z,bio_map  ] = fix_border_2(carte_x,carte_y,carte_z,bio_map,bio_ind);

fprintf('(%s) - Done, displaying the image\n', datestr(now,'HH:MM:SS'));
figure()
s = surf(carte_x,carte_y,carte_z,bio_map);
s.FaceAlpha = 0.9; % niveau de transparence
s.FaceColor = 'flat'; % set color interpolation or not
s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
axis equal
title(['biometric map, mass limits : ', num2str(limits(1)),'  ',num2str(limits(2))]);
