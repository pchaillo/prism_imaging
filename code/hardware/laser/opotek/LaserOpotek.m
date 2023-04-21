classdef LaserOpotek < LaserBase
    
    properties
        IP_address = '192.168.0.59'
        Port = 10001
        Temp_limit = 38
    end
    
    methods
        function laser_co = init(laser)
            laser_co = tcpclient(LaserOpotek.IP_address,LaserOpotek.Port);
            
            %% Ces commandes servent a verifier que la communication fonctionne bien
            flush(laser_co)
            writeline(laser_co, "ECHO 0") % ECHO 1 active le retour commande
            echo = readline(laser_co)
            %pvers_ok = readline(opotek)
            
            % flush(opotek)
            writeline(laser_co, "PSVERS")
            pvers = readline(laser_co)
            pvers_ok = readline(laser_co)
            
            % flush(opotek)
            writeline(laser_co, "LVERS")
            lvers = readline(laser_co)
            lvers_ok = readline(laser_co)
            % flush(opotek)
            writeline(laser_co, "STATE")
            state = readline(laser_co)
            state_ok = readline(laser_co)
            % 2 - ready for the RUN command
            
            %% parameters
            flush(laser_co)
            writeline(laser_co, "TRIG II") % set internal triggering
            % pause(0.1)
            trig = readline(laser_co);
        end
        
        function state = get_state(laser_co)
            opotek = laser_co
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
        end
        
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
                    disp(X)
                    % pause()
                    %is_hot = 1; % pour stopper la boucle => app
                else
                    X = sprintf('Temperature de %d C : OK',temp);
                    disp(X)
                    %is_hot = 1;
                end
            else
                disp('no temperature, connexion or buffer problem')
            end
            str_temp_ok = readline(opotek);
        end
        
        function tir(opotek,nb_shot)
            
            % Déclenche un "tir" pour la désorbtion de la surface à analyser
            % Equivalent au "burst mode" du logiciel Opotek
            
            time_stop = nb_shot*0.1;
            
            writeline(opotek, "QSW 1")  % ouvre le laser
            tab_qsw_1 = readline(opotek)
            
            pause(time_stop);
            
            writeline(opotek, "QSW 0") % ferme le laser
            tab_qsw_0 = readline(opotek)
            
            
            disp('tir');
        end
        
        function lamp_on(opotek)
            
            %% ALLUME LA LAMPE
            
            writeline(opotek, "STATE")
            state = readline(opotek)
            state_ok = readline(opotek);
            
            pause(1)
            
            %flush(opotek)
            writeline(opotek, "RUN \r")
            %writeline(opotek, "RUN")
            run = readline(opotek)
            
            pause(10)
            
            if run == "ERROR"
                disp('the lamp cannot be turned on');
                is_ok = 0;
            end
        end
        
        function state_double = opotek_lamp_off(opotek)
            
            writeline(opotek, "STOP")
            pause(0.1)
            stop = readline(opotek)
                       
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
        end
    end
end