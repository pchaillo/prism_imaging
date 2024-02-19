function stop = security_check(x,y,z)

global parameters

e_s = 60 ; % Stop security distance // distance de sécurité 
e_c = 65 ; % Critic security distance // distance de sécurité critique
e_w = 70 ; % Warning security distance // distance de sécurité avertissement

stop = 0;

%%% teste le contact au sol %%%
if z  < 0
    disp( ' impact ');
    stop = 1;
elseif z + parameters.surface_offset < e_c
    stop = 1;
    disp(' Robot trop proche du sol => arret sécurité ' )
elseif z + parameters.surface_offset < e_w
    disp( 'Attention robot proche du sol');
end

%%% teste le contact a l'objet %%%
if z  < parameters.maximal_height + parameters.surface_offset + 10
    disp( ' Contact imminent avec l echantillon => arret de securite');
    stop = 1;
elseif z  < e_c - parameters.surface_offset - parameters.maximal_height
    stop = 0;
    disp(' Robot trop proche de echantillon => arret sécurité ' )
elseif z < e_w - parameters.surface_offset - parameters.maximal_height
    disp( 'Attention robot proche de lechantilon');
end
