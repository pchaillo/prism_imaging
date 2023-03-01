function stop = collision_top(x,y,z)

% fonctionne => a bien tester avec objet
% 
% global robot;
% global objet;
% global carte;
 global scan;

e_s = 60 ; % distance de sécurité 
e_c = 65 ; % distance de sécurité critique
e_w = 70 ; % distance de sécurité avertissement

% x = robot.joint(8).Abs(1);
% y = robot.joint(8).Abs(2);
% z = robot.joint(8).Abs(3);
% 
% x2 = robot.joint(7).Abs(1);
% y2 = robot.joint(7).Abs(2);
% z2 = robot.joint(7).Abs(3);
% 
% x3 = robot.joint(4).Abs(1);
% y3 = robot.joint(4).Abs(2);
% z3 = robot.joint(4).Abs(3);
% 
% x4 = robot.joint(2).Abs(1);
% y4 = robot.joint(2).Abs(2);
% z4 = robot.joint(2).Abs(3);

stop = 0;
u = 0;
v = 0 ;

%%% teste le contact au sol %%%
if z  < 0
    disp( ' impact ');
    stop = 1;
elseif z + scan.s_offset < e_c
    stop = 1;
    disp(' Robot trop proche du sol => arret sécurité ' )
elseif z + scan.s_offset < e_w
    disp( 'Attention robot proche du sol');
end

%%% teste le contact a l'objet %%%
if z  < scan.hmax + scan.s_offset + 10
    disp( ' Contact imminent avec l echantillon => arret de securite');
    stop = 1;
elseif z  < e_c - scan.s_offset - scan.hmax
    stop = 0;
    disp(' Robot trop proche de echantillon => arret sécurité ' )
elseif z < e_w - scan.s_offset - scan.hmax
    disp( 'Attention robot proche de lechantilon');
end

% if z2 < 0
%     disp( ' impact (coude) ');
%     stop = 1;
% elseif z2 < e_c
%     stop = 1;
%     disp(' Robot trop proche du sol => arret sécurité (coude) ' )
% elseif z2 < e_w
%     disp( 'Attention robot proche du sol (coude) ');
% end

% % collision sur lui même : (pb z4)
% if x < e_c && y < e_c && x > -e_c && y > -e_c && z < z4 + e_s
%     stop = 1;
%     disp ( 'Arret sécurité => risques de collision sur lui même ');
% elseif x < e_w && y < e_w && x > -e_w && y > -e_w && z < z4 + e_w
%     disp ( 'Attention risques de collision sur lui même ');
% end

% if x2 < e_c && y2 < e_c && x2 > -e_c && y2 > -e_c && z2 < z4 + e_s
%     stop = 1;
%     disp ( 'Arret sécurité => risques de collision sur lui même (repli coude ) ');
% elseif x2 < e_w && y2 < e_w && x2 > -e_w && y2 > -e_w && z2 < z4 + e_w
%     disp ( 'Attention risques de collision sur lui même (repli coude)');
% end
% % if x4 > x3 
% %     xi = x4;
% %     x4 = x3;
% %     x3 = xi;
% % end
% % if y4 > y3 
% %     yi = y4;
% %     y4 = y3;
% %     y3 = yi;
% % end
% % if z4 > z3 
% %     zi = z4;
% %     z4 = z3;
% %     z3 = zi;
% % end
% % if x > x4-e_s && x < x3+e_s && y > y4-e_s && y < y3+e_s && z > z4-e_s && z < z3 + e_s
% %     stop = 1;
% %     disp( 'Arret sécurité => risques de collision sur lui même (repli coude) intermédiaire ');
% % end
% %     

% if scan.e == 0
%     %%% teste le contact avec l'objet a scanner %%%%
%     for i = 1 : 1 : length(objet.x)
%         for  j = 1 : 1 : length(objet.x)
%             if objet.x(j,i) < x + 1/(2*objet.pre) && objet.x(j,i) > x - 1/(2*objet.pre)  && objet.y(j,i) < y + 1/(2*objet.pre) && objet.y(j,i) > y - 1/(2*objet.pre)
%                 u = j;
%                 v = i ;
%             end
%         end
%     end
%     if u > 0 && v > 0
%         z_o = objet.hmax;
%         if z < e_c + z_o
%             stop = 1;
%             disp(' Robot trop proche de la surface à scanner => arret sécurité ' )
%         elseif z < e_w + z_o
%             disp( 'Attention robot proche de la surface à scanner');
%         end
%     end
% else
%     %%% teste le contact avec l'objet scanné %%%%  
%     si = size(carte.o);
%     for i = 1 : 1 : si(2)
%         for  j = 1 : 1 : si(1)
%             if carte.x_o(j,i) < x + scan.pas/(2*scan.pre) && carte.x_o(j,i) > x - scan.pas/(2*scan.pre)  && carte.y_o(j,i) < y + scan.pas/(2*scan.pre) && carte.y_o(j,i) > y - scan.pas/(2*scan.pre)
%                 u = j;
%                 v = i ;
%             end
%         end
%     end
%     if u > 0 && v > 0
%         z_o = carte.o(u,v);
%         if z < e_c + z_o
%             stop = 1;
%             disp(' Robot trop proche de l"objet => arret sécurité ' )
%         elseif z < e_w + z_o
%             disp( 'Attention robot proche de l"objet ');
%         end
%     end
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%% teste le contact avec l'objet avant scan %%%%
% % => pas possible réellement
% for i = 1 : 1 : length(objet.x)
%     for  j = 1 : 1 : length(objet.x)
%         if objet.x(j,i) < x + 1/(2*objet.pre) && objet.x(j,i) > x - 1/(2*objet.pre)  && objet.y(j,i) < y + 1/(2*objet.pre) && objet.y(j,i) > y - 1/(2*objet.pre)
%             u = j;
%             v = i ;
%         end
%     end
% end
% if u > 0 && v > 0
%     z_o = objet.z(u,v);
%     if z < 1 + z_o
%         stop = 1;
%         disp(' Robot trop proche => arret sécurité ' )
%     elseif z < 2 + z_o
%         disp( 'Attention robot proche ');
%     end
% end