classdef PeakPickingMethod < handle

    properties
           threshold_begin = 0; % put here data you need for you scan selection method !
           t_b = 0;
           min_threshold = 0;
           fusion_percentage = 0;
           intern_trig = 'charac';
    end

    methods
        function init(method, app)
            method.threshold_begin = app.BeginThresholdEditField.Value; % update them here with data from interface !
            method.t_b = app.Timebetween2lasershotsecondEditField.Value;
            method.min_threshold = app.LoudthresholdEditField.Value;
            method.fusion_percentage = app.FusionpercentSlider.Value;
            method.intern_trig = app.InternalTriggeringSwitch.Value;
            update_log(app, method.intern_trig)
 
        end

        function [pixels_scans ,time] = selection(method, mzXML_data , carte_time, app)
            if (method.intern_trig(1:2) == 'On')
                intern_flag = 1;
            else
                intern_flag = 0;
            end
            update_log(app, method.threshold_begin)
            update_log(app, method.t_b)
            update_log(app, method.min_threshold)
            update_log(app, method.fusion_percentage)
            update_log(app, method.intern_trig)

            [pixels_scans ,time] = Peak_picking(app, mzXML_data,method.threshold_begin,method.t_b,method.min_threshold,intern_flag,method.fusion_percentage,carte_time); % take only the usefull informations

        end
    end
end