function temp = get_temp(opotek)

temp_limit = 38; % limit celsius temperature under that you canot shot


%% TEST TEMPERATURE
flush(opotek)
is_hot = 0;
%while is_hot == 0
    writeline(opotek, "CGTEMP") % au moins 38 avant de trigger le laser
    str_temp = readline(opotek);
    char_temp = char(str_temp);
    if char_temp(1:6) == 'CGTEMP'
        char_t_num = char_temp(10:14);
        temp = str2double(char_t_num);
        if temp < temp_limit
            % print('attendre %d C : trop froid \n Appuyer sur une touche pour restester la temperature, ou CTRL+C pour arreter le script',temp)
            X = sprintf('Temperature de %d C : trop froid \n Appuyer sur une touche pour restester la temperature, ou CTRL+C pour arreter le script',temp);
            update_log(app, log, X)
             % pause()
            %is_hot = 1; % pour stopper la boucle => app
        else
            X = sprintf('Temperature de %d C : OK',temp);
            update_log(app, log, X)
            %is_hot = 1;
        end
    else
        update_log(app, log, 'No temperature found. Check the laser connexion and investigate the buffer.')
    end
    str_temp_ok = readline(opotek);
