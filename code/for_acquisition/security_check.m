function stop = security_check(x,y,z)

global parameters

e_s = 60 ; % Stop security distance // distance de sécurité 
e_c = 65 ; % Critic security distance // distance de sécurité critique
e_w = 70 ; % Warning security distance // distance de sécurité avertissement

stop = 0;

%%% Test for ground impact %%%
if z  < 0
    disp( 'Impact');
    stop = 1;
elseif z + parameters.surface_offset < e_c
    stop = 1;
    disp('Robot too close to the ground. Stopped for safety.' )
elseif z + parameters.surface_offset < e_w
    disp( 'Warning: Robot close to the ground.');
end

%%% teste le contact a l'objet %%%
if z  < parameters.maximal_height + parameters.surface_offset + 10
    disp( 'Imminent contact with the sample. Stopped for safety.');
    stop = 1;
elseif z  < e_c - parameters.surface_offset - parameters.maximal_height
    stop = 0;
    disp('Robot too close to the sample. Stopped for safety.' )
elseif z < e_w - parameters.surface_offset - parameters.maximal_height
    disp( 'Warning: Robot close to the sample.');
end
