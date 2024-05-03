classdef WatersTriggering

    properties
        % Contain all the properties that are similar for each spectrometer
        % trigerring
    end

    methods

        function time_ref = trigger(self)

            global arduino_object

            pin = 'A5';

            writeDigitalPin(arduino_object,pin,0)
            pause(0.1)
            writeDigitalPin(arduino_object,pin,1)

            disp(arduino_object)
            disp("Triggering done")

            time_ref = tic;
        end

    end
end