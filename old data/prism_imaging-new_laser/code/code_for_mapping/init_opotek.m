function  opotek = init_opotek()

%figure()

% Initialise la connexion au laser pour la desorbtion (Q-SMART / OPOTEK
% Radiant)
% A COMPLETER A l'INSERM

opotek = tcpclient('192.168.0.59',10001); 

%voltage_value = 677; % voltage of the flash lamp / should be 3 number
% choose the good voltage to have 4 mJ for desorption

%% Ces commandes servent a verifier que la communication fonctionne bien
flush(opotek)
writeline(opotek, "ECHO 0") % ECHO 1 active le retour commande
echo = readline(opotek)
%pvers_ok = readline(opotek)

% flush(opotek)
writeline(opotek, "PSVERS")
pvers = readline(opotek)
pvers_ok = readline(opotek)

% flush(opotek)
writeline(opotek, "LVERS")
lvers = readline(opotek)
lvers_ok = readline(opotek)
% flush(opotek)
writeline(opotek, "STATE")
state = readline(opotek)
state_ok = readline(opotek)
% 2 - ready for the RUN command

%% parameters
flush(opotek)
writeline(opotek, "TRIG II") % set internal triggering
% pause(0.1)
trig = readline(opotek);
% 
% writeline(opotek, "QSPAR1 2") % QSPAR1 # defines the number of cycles for burst/scan mode
% qspar1 = readline(opotek)
% %qspar1_ok = readline(t)
% 
% writeline(opotek, "QSPAR2 400") % QSPAR2 # defines the number of passive pulse per cycle for burst/scan mode
% qspar2 = readline(opotek)
% %qspar2_ok = readline(t)
% 
% writeline(opotek, "QSPAR3 400") % QSPAR3 # defines the number of active Q-Switch pulse per cycle for burst/scan mode
% qspar3 = readline(opotek)
% %qspar3_ok = readline(t)
% 
% writeline(opotek, "QDLY 120") % QDLY # set the FL-Q-Switch delay in ns, range 0 to 255
% %qdly = readline(t)
% qdly_ok = readline(opotek)

 %% set the voltage

%set_voltage(opotek,voltage_value);

% writeline(opotek, "CAPVSET") % CAPVSET ### program the flashlamp voltage
% capvset = readline(opotek)
% capvset_ok = readline(opotek)
% 
% str_volt = num2str(voltage_value);
% to_set_temp = strcat("CAPVSET ",str_volt);
% 
% writeline(opotek, to_set_temp) % CAPVSET ### program the flashlamp voltage
% %capvset2 = readline(opotek)
% capvset_ok2 = readline(opotek)
% 
% writeline(opotek, "CAPVSET") % CAPVSET ### program the flashlamp voltage
% capvset3 = readline(opotek)
% capvset_ok3 = readline(opotek)
% 
% real_volt_char = convertStringsToChars(capvset3);
% l = length(real_volt_char);
% real_voltage_str = real_volt_char(l-2:l);
% real_voltage = str2double(real_voltage_str);
% 
% if real_voltage ~= voltage_value
%     disp('voltage setting problem');
%     return
% end