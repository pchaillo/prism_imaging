function display_mz_map(map,pixels_mz,display = "3D")
% to see image as 2D from front display = "2D"

figure() % fonction d'affichage a factoriser #TODO
hold on
s = surf(map.x,map.y,map.z,pixels_mz);
 s.FaceColor = 'flat'; % set color interpolqtion
 s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
%title(['biometric map, mass limits : ', num2str(import_limits(1)),'  ',num2str(import_limits(2))]);
axis equal
%grid off
axis off
if display == "2D"
    view(2)
end
hold off

[x1,y1] = ginput(1);