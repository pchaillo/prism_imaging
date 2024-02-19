classdef LaserOpolette % < LaserBase
    
    properties
%         USB_port = "/dev/ttyUSB0" % for linux
        USB_port = "COM5" % Set accordingly by verifying with serialportslist
        Baudrate = 9600
        Temp_limit = 38
        laser_communication = [] 
    end
    
    methods
        function init(self, ~) % app ici ? #TODO
           self.laser_communication = serialport(self.USB_port, self.Baudrate);
           self.laser_communication.configureTerminator("CR/LF");
        end
        
        function [state_text, state_double] = get_state(self, app)
            flush(self.laser_communication);
            writeline(self.laser_communication, "QI");
            state_string = read(self.laser_communication, 15, 'string');
            flush(self.laser_communication);
            writeline(self.laser_communication, "ST");
            state_string = read(self.laser_communication, 15, 'string');
%             disp(state_string);
            if length(state_string) > 0 
%           if isempty(state_string) == 0 is supposedly faster      
                [state_text, state_double] = self.choose_state_text(state_string, app);
            else
                state_text = 'Empty State String - No communication';
                state_double = 2;
            end
%             state_text = state_string;
        end
        
        function  temp = get_temp(self, app)
            temp = 404;
            update_log(app, "Warning: Cannot obtain the temperature trough the serial port with Opolette laser")
        end
        
        function trigger(self, nb_shot, app)  % Should be translated to 'fire'
%             disp("Firing...") % for tests 
            for i=1:nb_shot
                flush(self.laser_communication)
%                 writeline(self.laser_communication, "QSP")
                writeline(self.laser_communication, "OP");
                state_string = read(self.laser_communication,15,'string');
                update_log(app, "LASER SHOT")
                pause(0.1)
            end
        end
        
        function state_string = lamp_on(self, ~)
            flush(self.laser_communication);
            writeline(self.laser_communication, "A");
            state_string = read(self.laser_communication,15,'string');
        end
        
        function state_string = lamp_off(self, ~)
            flush(self.laser_communication);
            writeline(self.laser_communication, "S");
            state_string = read(self.laser_communication,15,'string');
        end

        function disconnect(self, app)
            % insert code to turn the laser off
            delete(self.laser_communication);
            clear self;
            update_log(app, "Opolette Laser disconnected")
        end
        
        function set_voltage(self, voltage_value, app)
            % insert code to set the laser voltage
            update_log(app, 'Warning: Cannot chose voltage with the Opolette laser.')
        end

        function [state_text, state_double] = choose_state_text(self, state, app)
            s = state;
            n = strtrim(s);

            c = char(n); % For a particular case, with an additional 'T' at the beginning of the serial frame
            if c(1) == 'T'
                n = strtrim( convertCharsToStrings( c(3:end) ) );
            end
         
            if n == "standby"
                state_text = ' Standby - The laser is not firing and not simmering - You may turn the lamp on';
                state_double = 1;
            elseif n == "simmer"
                state_text = 'The laser is only simmering';
                state_double = 1;
            elseif n == "fire auto"
                state_text = 'Laser Ready for a RUN command';
                state_double = 2;
            elseif n == "fire_ext"
                state_text = 'The flashlamp is firing in Internal sync mode';
                state_double = 2;
            elseif n == "fire auto qs"
                state_text = 'The flashlamp is firing in Internal sync and the Q-Switch is operating in Internal sync. ';
                state_double = 2;
            elseif n == "fire ext qs" % emergency p-b
                state_text = 'The flashlamp is firing in External sync and the Q-Switch is operating in Internal sync.';
                state_double = 2;
            elseif n == "emergency p-b"
                state_text = 'Emergency button pushed on remote';
                state_double = -1;
            else
                state_text = 'No connexion, Laser off or communication problem';
                state_double = -1;
%                 state_double = 2; % ONLY FOR TEST !!!!
            end

            state_text = strcat('State : ', state_text);
%             disp("Debug process : ")
            update_log(app, state_text);
%             disp("Debug end /")

        end

        function continuous_trigerring(self, app) % This name should get translated (tir_continu_ON)
            % insert code to open the mirror that let the laser get out
            
            writeline(self.laser_communication, "CC");
            state_string = read(self.laser_communication,15,'string');
            update_log(app, 'Warning: The mirror is open. The laser is now continuously firing!');
        end

        function STOP_continuous_trigerring(self, app) % This name should get translated % tir_continu_OFF
            % insert code to close the mirror, to stop continue laser
            % firing
            
            writeline(self.laser_communication, "CS"); % Shuts the laser down
            msg_qsw_0 = readline(self.laser_communication); % #TODO renommer cette variable
%           is "laser_msg" a better name? 
            update_log(app, 'Warning: Mirror closed. End of continuous laser firing.');
        
        end
        
    end
end