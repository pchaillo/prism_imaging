classdef LaserOpolette < LaserBase
    
    properties
%         USB_port = "/dev/ttyUSB0" % for linux
        USB_port = "COM10" % for windows
        Baudrate = 9600
        Temp_limit = 38
    end
    
    methods
        function laser_co = init(laser)
           laser_co = serialport(laser.USB_port,laser.Baudrate);
           laser_co.configureTerminator("CR/LF");
        end
        
        function [state_text, state_double] = get_state(laser,laser_co)
            flush(laser_co)
            writeline(laser_co, "QI")
            state_string = read(laser_co,15,'string')
            flush(laser_co)
            writeline(laser_co, "ST")
            state_string = read(laser_co,15,'string')
            disp("test")
            disp(state_string)
            if length(state_string) > 0 
                [state_text, state_double] = laser.choose_state_text(state_string)
            else
                state_text = 'Aremplir'
                state_double = 2
            end
            state_text = state_string;
        end
        
        function  temp = get_temp(laser,laser_co)
            temp = 100;
      % A REFAIRE POUR OPOLETTE !
        end
        
        function tir(laser,laser_co,nb_shot)
%             disp("tir") % for tests 
            for i=1:nb_shot
                
                flush(laser_co)
%                 writeline(laser_co, "QSP")
                writeline(laser_co, "OP")
                state_string = read(laser_co,15,'string')
                disp("tir")
                pause(0.1)
            end
        end
        
        function state_string = lamp_on(laser,laser_co)
            
            flush(laser_co)
            writeline(laser_co, "A")
            state_string = read(laser_co,15,'string');
        end
        
        function state_string = lamp_off(laser,laser_co)
            
            flush(laser_co)
            writeline(laser_co, "S")
            state_string = read(laser_co,15,'string');
        end

        function disconnect(laser,laser_co)
            % insert code to turn the laser off
        end
        
        function set_voltage(laser,laser_co,voltage_value)
            % insert code to set the laser voltage
            disp('Choix de la tension impossible avec Opolette')
        end

        function [state_text, state_double] = choose_state_text(laser,state)
            n = state;

            if n == "standby      "
                state_text = 'The laser is not firing and not simmering';
                state_double = 1;
            elseif n == "simmer"
                state_text = 'The laser is only simmering';
                state_double = 1;
            elseif n == "fire auto     "
                state_text = 'Laser Ready for a RUN command';
                state_double = 1;
            elseif n == "fire_ext"
                state_text = 'The flashlamp is firing in Internal sync mode';
                state_double = 2;
            elseif n == "fire auto qs"
                state_text = 'The flashlamp is firing in Internal sync and the Q-Switch is operating in Internal sync. ';
                state_double = 2;
            elseif n == "fire ext qs" emergency p-b
                state_text = 'The flashlamp is firing in External sync and the Q-Switch is operating in Internal sync.';
                state_double = 2;
            elseif n == "emergency p-b"
                state_text = 'Emergency button pushed on remote';
                state_double = -1;
            else
                state_text = 'No connexion, Laser off or communication problem';
                state_double = -1;
                state_double = 2; % ONLY FOR TEST !!!!
            end

            state_text = strcat('State : ',state_text);
        end
        
    end
end