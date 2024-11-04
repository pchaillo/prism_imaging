classdef LaserOpotek % < LaserBase
    
    properties
        IP_address = '192.168.0.59'
        Port = 10001
        Temp_limit = 38
        voltage_value
    end
    
    methods %(Static)
        function init(self, app)
            self.laser_communication = tcpclient(self.IP_address,self.Port);
            
            %% Ces commandes servent a verifier que la communication fonctionne bien
%             flush(self.laser_communication)
            writeline(self.laser_communication, "ECHO 0") % ECHO 1 active le retour commande
            echo = readline(self.laser_communication);
            update_log(app, echo)
            %pvers_ok = readline(opotek)
            
            % flush(opotek)
            writeline(self.laser_communication, "PSVERS")
            pvers = readline(self.laser_communication);
            update_log(app, pvers)
            pvers_ok = readline(self.laser_communication);
            update_log(app, pvers_ok)
            
            % flush(opotek)
            writeline(self.laser_communication, "LVERS")
            lvers = readline(self.laser_communication);
            update_log(app, lvers)
            lvers_ok = readline(self.laser_communication);
            update_log(app, lvers_ok)
            % flush(opotek)
            writeline(self.laser_communication, "STATE")
            state = readline(self.laser_communication);
            update_log(app, state)
            state_ok = readline(self.laser_communication);
            update_log(app, state_ok)
            % 2 - ready for the RUN command
            
            %% parameters
            flush(self.laser_communication)
            writeline(self.laser_communication, "TRIG II") % Sets internal triggering
            % pause(0.1)
            trig = readline(self.laser_communication);
        end
        
        function [state_string, state_double] = get_state(self, app)
            opotek = self.laser_communication;
            writeline(opotek, "STATE")
            state_raw = readline(opotek);
            update_log(app, state_raw)
            state_ok = readline(opotek);
            
            char_state = char(state_raw);
            if char_state(1:5) == 'STATE'
                char_state_num = char_state(9);
                state_double = str2double(char_state_num);
            else
                update_log(app, 'No state found. Please check the connexion to the laser and investigate the buffer.')
                state_double = -1;
            end

            state_string = self.choose_state_text(state_double);
        end
        
        function temp = get_temp(self, app)
            opotek = self.laser_communication;
            
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
                    update_log(app, X)
                    % pause()
                    %is_hot = 1; % pour stopper la boucle => app
                else
                    X = sprintf('Temperature de %d C : OK',temp);
                    update_log(app, X)
                    %is_hot = 1;
                end
            else
                update_log(app, 'No temperature found. Please check the connexion to the laser and investigate the buffer.')
            end
            str_temp_ok = readline(opotek);
        end
        
        function trigger(self, nb_shot, app) % Translate this name
            opotek = self.laser_communication;
            % Déclenche un "tir" pour la désorbtion de la surface à analyser
            % Equivalent au "burst mode" du logiciel Opotek
            
            time_stop = nb_shot*0.1;
            
            writeline(opotek, "QSW 1")  % ouvre le laser
            msg_qsw_1 = readline(opotek);
            update_log(app, msg_qsw_1)
            
            pause(time_stop);
            
            writeline(opotek, "QSW 0") % ferme le laser
            msg_qsw_0 = readline(opotek);
            update_log(app, msg_qsw_0)
            
            
            update_log(app, 'Firing...');
        end
        
        function state_string = lamp_on(self, app)
            opotek = self.laser_communication;
            %% Turning the lamp on
            
            writeline(opotek, "STATE")
            state_string = readline(opotek);
            update_log(app, state_string)
            state_ok = readline(opotek);
            
            pause(1)
            
            %flush(opotek)
            writeline(opotek, "RUN \r")
            %writeline(opotek, "RUN")
            run = readline(opotek);
            update_log(app, run)
            
            pause(10)
            
            if run == "ERROR"
                update_log(app, 'Error: The lamp cannot be turned on.');
                is_ok = 0;
            end
        end
        
        function state_string = lamp_off(self, app)
            opotek = self.laser_communication;
            
            writeline(opotek, "STOP")
            pause(0.1)
            stop = readline(opotek);
            update_log(app, stop)
                       
            writeline(opotek, "STATE")
            state_string = readline(opotek);
            update_log(app, state_string)
            state_ok = readline(opotek);
            
            char_state = char(state_string);
            if char_state(1:5) == 'STATE'
                char_state_num = char_state(9);
                state_double = str2double(char_state_num);
            else
                update_log(app, 'No state found. Please check the laser connexion and investigate the buffer.')
            end
            
            update_log(app, 'The state ID shoud be 2.');
        end

        function disconnect(self, app)
            % insert code to turn the laser off
            delete(self.laser_communication);
            clear self;
            update_log(app, "Opotek Laser Disconnected")
        end

        function set_voltage(self, voltage_value, app)
            opotek = self.laser_communication;
            %% set the voltage
            writeline(opotek, "CAPVSET"); % CAPVSET ### program the flashlamp voltage
            capvset = readline(opotek);
            update_log(app, capvset)
            capvset_ok = readline(opotek);
            update_log(app, capvset_ok)
            
            str_volt = num2str(voltage_value);
            to_set_temp = strcat("CAPVSET ",str_volt);
            
            writeline(opotek, to_set_temp) % CAPVSET ### program the flashlamp voltage
            %capvset2 = readline(opotek)
            capvset_ok2 = readline(opotek);
            update_log(app, capvset_ok2)
            
            writeline(opotek, "CAPVSET") % CAPVSET ### program the flashlamp voltage
            capvset3 = readline(opotek);
            update_log(app, capvset_3)
            capvset_ok3 = readline(opotek);
            update_log(app, capvset_ok3)
            
            real_volt_char = convertStringsToChars(capvset3);
            l = length(real_volt_char);
            real_voltage_str = real_volt_char(l-2:l);
            real_voltage = str2double(real_voltage_str);
            
            if real_voltage ~= voltage_value
                update_log(app, 'Warning: Voltage setting problem');
                return
                
            end
        end

        function [state_text, state] = choose_state_text(self, state) % Bespoke LaserOpotek function
			% This approach only works in MatLab 2022b and later, as dictionnaries are somehow new in MatLab
			states_number = -1:9
			states_text = ['Boot Fault', 'Warm up', 'Laser Ready for a RUN command', 'Flashing - Lamp disabled', 'Flashing awaiting shutter to be opened', 'Flashing - Pulse enabled', 'Pulsed Laser ON/NLO Warm up', 'Harmonic generator thermally stabilized', 'NLO Optimization', 'APM ok : NLO ready', 'No connexion, Laser off or buffer problem' 
            states_dict = dictionnary(states_number, states_text)
			
            state_text = strcat('State : ', states_dict(state));
        end

        function continuous_trigerring(self, app)
            % insert code to open the mirror that let the laser get out
            opotek = self.laser_communication;
            
            writeline(opotek, "QSW 1")  % Opens the laser
            msg_qsw_1 = readline(opotek);
            update_log(app, msg_qsw_1)
            update_log(app, 'Warning: The mirror is open. The laser is now continuosuly firing!');
        end

        function STOP_continuous_trigerring(self, app)
            % insert code to close the mirror, to stop continue laser shooting
            
            writeline(self.laser_communication, "QSW 0") % ferme le laser
            msg_qsw_0 = readline(self.laser_communication);
            update_log(app, msg_qsw_0)
            update_log(app, 'Warning: Closing the mirror. End of continuous firing.')
        end
    end
end