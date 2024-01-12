function display_mz_map(map,pixels_mz,title_str)
% to see image as 2D from front display = "2D". Otherwise pick "3D"

pixels_mz = replace_NaN_by_zero(pixels_mz);

figure() % fonction d'affichage a factoriser #TODO
% hold on
s = surf(map.x,map.y,map.z,pixels_mz);
s.FaceColor = 'flat'; % set color interpolqtion
s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
title(title_str);
axis equal
%grid off
% axis off
% if display == "2D"
%     view(2)
% end
% hold off
