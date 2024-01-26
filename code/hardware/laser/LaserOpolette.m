classdef LaserOpolette < LaserBase
    
    properties
%         USB_port = "/dev/ttyUSB0" % for linux
        USB_port = "COM10" % for windows
        Baudrate = 9600
        Temp_limit = 38
    end
    
    methods
        function laser_co = init(~, laser)
           laser_co = serialport(laser.USB_port,laser.Baudrate);
           laser_co.configureTerminator("CR/LF");
        end
        
        function [state_text, state_double] = get_state(~, laser,laser_co)
            flush(laser_co);
            writeline(laser_co, "QI");
            state_string = read(laser_co,15,'string');
            flush(laser_co);
            writeline(laser_co, "ST");
            state_string = read(laser_co,15,'string');
%             disp(state_string);
            if length(state_string) > 0 
                [state_text, state_double] = laser.choose_state_text(state_string, app);
            else
                state_text = 'Empty State String - No communication';
                state_double = 2;
            end
%             state_text = state_string;
        end
        
        function  temp = get_temp(laser, laser_co, app)
            temp = 404;
            update_log(app, "Warning: Cannot obtain the temperature trough the serial port with Opolette laser")
        end
        
        function tir(laser, laser_co, nb_shot, app)
%             disp("tir") % for tests 
            for i=1:nb_shot
                
                flush(laser_co)
%                 writeline(laser_co, "QSP")
                writeline(laser_co, "OP");
                state_string = read(laser_co,15,'string');
                update_log(app, "LASER SHOT")
                pause(0.1)
            end
        end
        
        function state_string = lamp_on(~, laser,laser_co)
            flush(laser_co);
            writeline(laser_co, "A");
            state_string = read(laser_co,15,'string');
        end
        
        function state_string = lamp_off(~, laser, laser_co)
            flush(laser_co);
            writeline(laser_co, "S");
            state_string = read(laser_co,15,'string');
        end

        function disconnect(laser, laser_co, app)
            % insert code to turn the laser off
            delete(laser_co);
            clear laser;
            update_log(app, "Opolette Laser disconnected")
        end
        
        function set_voltage(laser, laser_co, voltage_value, app)
            % insert code to set the laser voltage
            update_log(app, 'Warning: Cannot chose voltage with the Opolette laser.')
        end

        function [state_text, state_double] = choose_state_text(laser, state, app)
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

            state_text = strcat('State : ',state_text);
%             disp("Debug process : ")
            update_log(app, state_text);
%             disp("Debug end /")

        end

        function tir_continu_ON(laser, laser_co, app) % This name should get translated
            % insert code to open the mirror that let the laser get out
            
            writeline(laser_co, "CC");
            state_string = read(laser_co,15,'string');
            update_log(app, 'Warning: The mirror is open. The laser is now continuously firing!');
        end

        function tir_continu_OFF(laser, laser_co, app) % This name should get translated
            % insert code to close the mirror, to stop continue laser shooting
            
            writeline(laser_co, "CS"); % ferme le laser
            tab_qsw_0 = readline(laser_co);
            update_log(app, 'Warning: Mirror closed. End of continuous laser firing.');
        
        end
        
    end
end