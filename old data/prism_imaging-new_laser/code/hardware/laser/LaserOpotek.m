classdef LaserOpotek < LaserBase
    
    properties
        IP_address = '192.168.0.59'
        Port = 10001
        Temp_limit = 38
    end
    
    methods %(Static)
        function laser_co = init(laser)
            laser_co = tcpclient(laser.IP_address,laser.Port);
            
            %% Ces commandes servent a verifier que la communication fonctionne bien
%             flush(laser_co)
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
        
        function [state_string, state_double] = get_state(laser,laser_co)
            opotek = laser_co;
            writeline(opotek, "STATE")
            state_raw = readline(opotek)
            state_ok = readline(opotek);
            
            char_state = char(state_raw);
            if char_state(1:5) == 'STATE'
                char_state_num = char_state(9);
                state_double = str2double(char_state_num);
            else
                disp('no state, connexion or buffer problem')
                state_double = -1;
            end

            state_string = laser.choose_state_text(state_double);
        end
        
        function temp = get_temp(laser,laser_co)
            opotek = laser_co;
            
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
        
        function tir(laser,laser_co,nb_shot)
            opotek = laser_co;
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
        
        function state_string = lamp_on(laser,laser_co)
            opotek = laser_co;
            %% ALLUME LA LAMPE
            
            writeline(opotek, "STATE")
            state_string = readline(opotek)
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
        
        function state_string = lamp_off(laser,laser_co)
            opotek = laser_co;
            
            writeline(opotek, "STOP")
            pause(0.1)
            stop = readline(opotek)
                       
            writeline(opotek, "STATE")
            state_string = readline(opotek)
            state_ok = readline(opotek);
            
            char_state = char(state_string);
            if char_state(1:5) == 'STATE'
                char_state_num = char_state(9);
                state_double = str2double(char_state_num);
            else
                disp('no state, connexion or buffer problem')
            end
            
            disp('the state should be at 2');
        end

        function disconnect(laser,laser_co)
            % insert code to turn the laser off
        end

        function set_voltage(laser,laser_co,voltage_value)
            opotek = laser_co;
            %% set the voltage
            writeline(opotek, "CAPVSET"); % CAPVSET ### program the flashlamp voltage
            capvset = readline(opotek)
            capvset_ok = readline(opotek)
            
            str_volt = num2str(voltage_value);
            to_set_temp = strcat("CAPVSET ",str_volt);
            
            writeline(opotek, to_set_temp) % CAPVSET ### program the flashlamp voltage
            %capvset2 = readline(opotek)
            capvset_ok2 = readline(opotek)
            
            writeline(opotek, "CAPVSET") % CAPVSET ### program the flashlamp voltage
            capvset3 = readline(opotek)
            capvset_ok3 = readline(opotek)
            
            real_volt_char = convertStringsToChars(capvset3);
            l = length(real_volt_char);
            real_voltage_str = real_volt_char(l-2:l);
            real_voltage = str2double(real_voltage_str);
            
            if real_voltage ~= voltage_value
                disp('voltage setting problem');
                return
                
            end
        end

        function [state_text, state_double] = choose_state_text(laser,state) % fonction propre et unique a LaserOpotek ?
            n = state;

            if n == 0
                state_text = 'Boot Fault';
                state_double = 0;
            elseif n == 1
                state_text = 'Warm up';
                state_double = 1;
            elseif n == 2
                state_text = 'Laser Ready for a RUN command';
                state_double = 1;
            elseif n == 3
                state_text = 'Flashing - Lamp disabled';
                state_double = 1;
            elseif n == 4
                state_text = 'Flashing awaiting shutter to be opened';
                state_double = 2;
            elseif n == 5
                state_text = 'Flashing - Pulse enabled';
                state_double = 2;
            elseif n == 6
                state_text = 'Pulsed Laser ON/NLO Warm up';
                state_double = 2;
            elseif n == 7
                state_text = 'Harmonic generator thermally stabilized';
                state_double = 1;
            elseif n == 8
                state_text = 'NLO Optimization';
                state_double = 1;
            elseif n == 9
                state_text = 'APM ok : NLO ready';
                state_double = 1;
            elseif n == -1
                state_text = 'No connexion, Laser off or buffer problem';
                state_double = -1;
            else
                state_text = 'No connexion, Laser off or buffer problem';
                state_double = -1;
            end

            state_text = strcat('State : ',state_text);
        end


    end
end