classdef TimeBasedMethod  < handle

    properties
        aspiration_time = 1.05; % I think this should no longer be here

    end

    methods

        function init(method, app)
            method.aspiration_time = app.AspirationTimesEditField.Value;
            update_log(app, method.aspiration_time)
        end

%         function set_aspiration_time(method,aspiration_time)
%             method.aspiration_time = aspiration_time;
%             disp(method.aspiration_time)
%         end

        function [pixels_scans ,estimated_time_gap] = selection( method, mzXML_data, map_time,app)
            neighbourgh_nb = app.NeighbourNumberEditField.Value;
            [pixels_scans ,estimated_time_gap] = time_based_selection(mzXML_data, map_time, method.aspiration_time,neighbourgh_nb); % take only the useful informations

        end
    end
end