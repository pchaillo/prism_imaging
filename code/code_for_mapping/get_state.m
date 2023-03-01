
function state_double = get_state(opotek)

writeline(opotek, "STATE")
state = readline(opotek)
state_ok = readline(opotek);

char_state = char(state);
if char_state(1:5) == 'STATE'
    char_state_num = char_state(9);
    state_double = str2double(char_state_num);
else
    disp('no state, connexion or buffer problem')
    state_double = -1;

end