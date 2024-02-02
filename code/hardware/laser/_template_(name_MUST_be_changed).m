classdef (Abstract) LaserBase

    properties
        Nb_shoot_per_burst = 5 % pas utilisé
    end

    methods
        function laser_co = init(laser)
            % insert laser connexion and return connection object variable
        end

        function  [state_string, state_double] = get_state(laser,laser_co)
            % insert code to read the state of the laser
            % state_double = -1 => no connexion
            % state_double = 0 => boolt fault
            % state_double = 1 => connected, lamp off
            % state_double = 2 => connected, lamp on
        end

        function  temp = get_temp(laser,laser_co)
            % insert code to get the temperature of the lamp of the laser
            % A REFAIRE POUR OPOLETTE !
        end

        function tir(laser,laser_co,nb_shot)

            %for i=1:nb_shot
            % insert code to do a laser shot
            %end
        end

        function state_string = lamp_on(laser, laser_co, ~)
            % insert code to turn the lamp on
        end


        function state_string = lamp_off(laser, laser_co, ~)
            % insert code to turn the lamp off
        end

        function  disconnect(laser, laser_co, ~)
            % insert code to turn the laser off
        end

        function set_voltage(laser, laser_co, voltage_value, app)
            % insert code to set the laser voltage
        end

        function [state_text, state_double] = choose_state_text(laser, state, ~)
            % insert code to choose the state text
        end

        function tir_continu_ON(laser, laser_co, ~)
            % insert code to open the mirror that let the laser get out
        end

        function tir_continu_OFF(laser, laser_co, ~)
            % insert code to close the mirror, to stop continue laser shooting
        end
    end
end