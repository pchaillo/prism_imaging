function hugh_to_sleep(t)

% Met le robot en position sommeil avant de lancer sa desactivation et sa
% deconnexion

a = [ 137.7 0.1 119.5 180 0 180 ];
set_pos(a,t);

pause(1);

close_tcp_r(t);

