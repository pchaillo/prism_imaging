function state_double = opotek_lamp_off(opotek)

writeline(opotek, "STOP")
pause(0.1)
stop = readline(opotek)

% %% ERROR
%
% % flush(t)
% writeline(t, "QSW 1")
% qsw = readline(t)


writeline(opotek, "STATE")
state = readline(opotek)
state_ok = readline(opotek);

char_state = char(state);
if char_state(1:5) == 'STATE'
    char_state_num = char_state(9);
    state_double = str2double(char_state_num);
else
    disp('no state, connexion or buffer problem')
end

disp('the state should be at 2');