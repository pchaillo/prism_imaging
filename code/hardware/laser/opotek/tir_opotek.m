function tir_opotek(opotek,nb_shot)

% Déclenche un "tir" pour la désorbtion de la surface à analyser
% Equivalent au "burst mode" du logiciel Opotek

time_stop = nb_shot*0.1;

writeline(opotek, "QSW 1")  % Opens the laser
tab_qsw_1 = readline(opotek);
update_log(app, tab_qsw_1)

pause(time_stop);

writeline(opotek, "QSW 0") % Shuts the laser down
tab_qsw_0 = readline(opotek);
update_log(app, tab_qsw_0)

% % for i = 1 : nb_shot
% %
% %     writeline(opotek, "QSW 1")  % ouvre le laser
% %     tab_qsw_1 = readline(opotek)
% %
% %     pause(0.05)
% %
% %     writeline(opotek, "QSW 0") % ferme le laser
% %     tab_qsw_0 = readline(opotek)
% %
% %     pause(0.05)
% %
% % end

% err_1 = find(tab_qsw_1 == 'ERROR');
% err_0 = find(tab_qsw_0 == 'ERROR');

update_log(app, 'Firing...')

