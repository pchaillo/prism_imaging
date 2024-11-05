classdef RemoteControl

    properties
    end

    methods
        function laser_co = init(self, ~, ~)
            disp("OK!")
        end

        function  [state_string, state_double] = get_state(~, ~, ~)
            state_string = "Remote source control.";
            state_double = 0;
        end

        function temp = get_temp(~, ~, ~)
            temp = 404;
        end

        function trigger(~, ~, ~)
            disp("Source control is performed remotely")
        end

        function state_string = lamp_on(~, ~, ~)
            state_string = "Remote source control";
        end


        function state_string = lamp_off(~, ~, ~)
            disp("OK!")
        end

        function  disconnect(~, ~, ~)
            disp("OK!")
        end

        function set_voltage(~, ~, ~, ~)
            disp("OK!")
        end

        function continuous_trigerring(~, ~, ~)
            disp("Remote source control.")
        end

        function STOP_continuous_trigerring(~, ~, ~)
            disp("Remote source control.")
        end
    end
end