classdef PeakPickingMethod < handle

    properties
           threshold_begin = 0; % put here data you need for you scan selection method !
           t_b = 0;
           min_threshold = 0;
           tolerance = 0;
           intern_trig = 'charac';
    end

    methods
        function init(method,app)
            method.threshold_begin = app.BeginThresholdEditField.Value; % put here data you need for you scan selection method !
            method.t_b = app.Timebetween2lasershotsecondEditField.Value;
            method.min_threshold = app.LoudthresholdEditField.Value;
            method.tolerance = app.FusionpercentSlider.Value;
            method.intern_trig = app.InternalTriggeringSwitch.Value;
            disp( method.intern_trig)
 
        end

        function [bio_dat ,time,g] = selection(method, mzXML_data , carte_time )
            if (method.intern_trig(1:2) == 'On')
                intern_flag = 1;
            else
                intern_flag = 0;
            end
            disp(method.threshold_begin)
            disp(method.t_b)
            disp(method.min_threshold)
            disp(method.tolerance)
            disp(method.intern_trig)

            [bio_dat ,time,g] = peak_detection_pt_par_pt_8(mzXML_data,method.threshold_begin,method.t_b,method.min_threshold,intern_flag,method.tolerance,carte_time); % take only the usefull informations


        end
    end
end