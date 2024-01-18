function  opotek = init_opotek()

%figure()

% Initialise la connexion au laser pour la desorbtion (Q-SMART / OPOTEK
% Radiant)
% A COMPLETER A l'INSERM
% Not implementing update_log here since this code is not put in a
% function. I might deal with it later.

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
