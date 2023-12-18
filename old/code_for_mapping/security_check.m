function stop = security_check(x,y,z)

% nouveau collision_top()

 global scan;

e_s = 60 ; % distance de sécurité 
e_c = 65 ; % distance de sécurité critique
e_w = 70 ; % distance de sécurité avertissement

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
