classdef TimeBasedMethod  < handle

    properties
        aspiration_time = 1.05; % I think this should no longer be here
        aspiration_shift = 0;
    end

    methods

        function init(method, app)
            method.aspiration_time = app.AspirationTimesEditField.Value;
            method.aspiration_shift = app.AspirationShiftsEditField.Value;
            update_log(app, method.aspiration_time)
        end

        function [pixels_scans ,estimated_time_gap] = selection( method, mzXML_data, map_time,app)
            neighbourgh_nb = app.NeighbourNumberEditField.Value;
            [pixels_scans ,estimated_time_gap] = time_based_selection(mzXML_data, map_time, method.aspiration_time,neighbourgh_nb,method.aspiration_shift); % take only the useful informations

        end
    end
end