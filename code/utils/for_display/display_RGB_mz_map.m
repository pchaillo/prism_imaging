function display_RGB_mz_map(map,pixels_mz_R,pixels_mz_G,pixels_mz_B,limits_R,limits_G,limits_B,title_str)

% to see image as 2D from front display = "2D". Otherwise pick "3D"

rgb_map(:,:,1) = pixels_mz_R ;
rgb_map(:,:,2) = pixels_mz_G ;
rgb_map(:,:,3) = pixels_mz_B ;

figure()
s = surf(map.x,map.y,map.z,rgb_map);
s.FaceAlpha=0.9; % niveau de tranparence
s.FaceColor = 'flat'; % set color interpolqtion
s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
title(['RGB biometric map, mass limits : R =', num2str(limits_R),' G = ',num2str(limits_G),' B = ',num2str(limits_B), title_str]);
axis equal
