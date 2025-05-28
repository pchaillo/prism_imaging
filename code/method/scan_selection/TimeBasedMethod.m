classdef TimeBasedMethod  < handle

    properties
        
    end

    methods

        function init(method, app)
            method.aspiration_time = app.AspirationTimesEditField.Value;
            method.aspiration_shift = app.AspirationShiftsEditField.Value;
            update_log(app, method.aspiration_time)
            update_log(app, method.aspiration_shift)
        end

        function [pixels_scans ,estimated_time_gap] = selection(method, mzXML_data, map_time, app)
            neighbourgh_nb = app.NeighbourNumberEditField.Value;
            [pixels_scans ,estimated_time_gap] = time_based_selection(mzXML_data, map_time, method.aspiration_time,neighbourgh_nb,method.aspiration_shift); % take only the useful informations

        end
    end
end