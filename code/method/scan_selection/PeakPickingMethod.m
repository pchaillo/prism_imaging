classdef PeakPickingMethod < handle

    properties
           threshold_begin = 0; % put here data you need for you scan selection method !
           t_b = 0;
           min_threshold = 0;
           fusion_percentage = 0;
           intern_trig = 'charac';
    end

    methods
        function init(method,app)
            method.threshold_begin = app.BeginThresholdEditField.Value; % update them here with data from interface !
            method.t_b = app.Timebetween2lasershotsecondEditField.Value;
            method.min_threshold = app.LoudthresholdEditField.Value;
            method.fusion_percentage = app.FusionpercentSlider.Value;
            method.intern_trig = app.InternalTriggeringSwitch.Value;
            disp( method.intern_trig)
 
        end

        function [bio_dat ,time] = selection(method, mzXML_data , carte_time )
            if (method.intern_trig(1:2) == 'On')
                intern_flag = 1;
            else
                intern_flag = 0;
            end
            disp(method.threshold_begin)
            disp(method.t_b)
            disp(method.min_threshold)
            disp(method.fusion_percentage)
            disp(method.intern_trig)

            path(path,'code/for_image_building/for_scan_selection/PeakPicking') % Ranger ca ou ? => Ici c'est bien non ? #TODO

            [bio_dat ,time] = Peak_picking(mzXML_data,method.threshold_begin,method.t_b,method.min_threshold,intern_flag,method.fusion_percentage,carte_time); % take only the usefull informations


        end
    end
end