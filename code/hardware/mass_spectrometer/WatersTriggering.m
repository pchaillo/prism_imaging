classdef WatersTriggering

    properties
        % Contain all the properties that are same for each robot
        % Nb_shoot_per_burst = 5
    end

    methods

        function time_ref = trigger(self)

            global arduino_object

            writeDigitalPin(arduino_object,'A5',0)
            pause(0.1)
            writeDigitalPin(arduino_object,'A5',1)

            disp(arduino_object)
            disp("Triggering done")

            time_ref = tic;
        end
    end
end