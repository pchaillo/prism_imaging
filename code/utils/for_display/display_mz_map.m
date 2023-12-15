function display_mz_map(map,pixels_mz,title)
% to see image as 2D from front display = "2D". Otherwise pick "3D"

figure() % fonction d'affichage a factoriser #TODO
hold on
s = surf(map.x,map.y,map.z,pixels_mz);
s.FaceColor = 'flat'; % set color interpolqtion
s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
title(title);
axis equal
%grid off
axis off
% if display == "2D"
%     view(2)
% end
hold off
