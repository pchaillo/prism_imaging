% Pas tres bien foutue mais utile pour tests

% function one_point_synchro()

% a = arduino();

% path(path,'code/hardware/laser')

% laser.class = LaserOpolette;
% laser.connexion = laser.class.init();
% 
% state_string = laser.class.lamp_on(laser.connexion)

pause(1); % pour attendre l'allumage de la lamp

time_ref = trigger_spectro_time(a);

pause(2); % pause d'une demi seconde pour etre sur

laser.class.tir(laser.connexion,1)