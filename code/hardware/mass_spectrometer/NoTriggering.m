classdef NoTriggering

    properties
        % Contain all the properties that are same for each robot
        % Nb_shoot_per_burst = 5
    end

    methods

        function time_ref = trigger(self)
            time_ref = tic;
        end

    end
end