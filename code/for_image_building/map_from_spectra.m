
function map_from_spectra(app, pixels_scans,map,compute_flag)

% compute_flag : booleen qui détermine s'il faut recalculer un spectre
% global. 0 => rien en mémoire / 1 => reprendre le tableau en mémoire

[x1,y1] = ginput(1);
[x2,y2] = ginput(1);

if x1 < x2 
    limits = [x1 x2];
else
    limits = [x2 x1];
end

fprintf('(%s) - The map file is loaded \n', datestr(now,'HH:MM:SS'));
fprintf('(%s) - Starting to build the intensity matrix\n', datestr(now,'HH:MM:SS'));

if isfield(map,'time')
    time_flag = 1;
else
    time_flag = 0;
end

loud_flag = 0; % faire propre #TODO
[ pixels_ind, ~, pixels_mz, ~] = data_on_map(app, pixels_scans,map,limits,map.time,time_flag,loud_flag);

[ map.x,map.y,map.z,pixels_mz  ] = fix_border(map.x,map.y,map.z,pixels_mz,pixels_ind);

fprintf('(%s) - Done, displaying the image\n', datestr(now,'HH:MM:SS'));
title_str = strcat("biometric map, mass limits : ", num2str(limits(1)),"  ",num2str(limits(2)) );
display_mz_map(map,pixels_mz,title_str)
% figure()
% s = surf(map.x,map.y,map.z,pixels_mz);
% s.FaceAlpha = 0.9; % niveau de transparence
% s.FaceColor = 'flat'; % set color interpolation or not
% s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
% axis equal
% title(['biometric map, mass limits : ', num2str(limits(1)),'  ',num2str(limits(2))]);
