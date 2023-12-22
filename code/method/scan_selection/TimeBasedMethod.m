classdef TimeBasedMethod  < handle

    properties
        aspiration_time = 1.05;

    end

    methods

        function init(method,app)

        end

        function set_aspiration_time(method,aspiration_time)
            method.aspiration_time = aspiration_time;
        end

        function [pixels_scans ,estimated_time_gap] = selection(method, mzXML_data, carte_time)
            % Insert laser connexion and return connection object variable
            disp(method.aspiration_time)
            [pixels_scans ,estimated_time_gap] = time_based_selection(mzXML_data, carte_time, method.aspiration_time); % take only the useful informations

        end
    end
end