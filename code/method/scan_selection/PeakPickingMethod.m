classdef PeakPickingMethod < handle

    properties
           threshold_begin = 0; % put here data you need for you scan selection method !
           t_b = 0;
           min_threshold = 0;
           fusion_percentage = 0;
           intern_trig = 'charac';
    end

    methods
        function init(self, app) % Liable to break if the corresponding names are every changed in the GUI
            self.threshold_begin = app.BeginThresholdEditField.Value; 
            self.t_b = app.TimebetweentwolaserburstssEditField.Value;
            self.min_threshold = app.LoudThresholdEditField.Value;
            self.fusion_percentage = app.FusionpercentSlider.Value;
            self.intern_trig = app.InternalTriggeringSwitch.Value;

            update_log(app, self.intern_trig)

        end

        function [pixels_scans ,time] = selection(self, mzXML_data , map_time, app)
            if (self.intern_trig(1:2) == 'On')
                intern_flag = 1;
            else
                intern_flag = 0;
            end
            update_log(app, self.threshold_begin)
            update_log(app, self.t_b)
            update_log(app, self.min_threshold)
            update_log(app, self.fusion_percentage)
            update_log(app, self.intern_trig)

            [pixels_scans ,time] = Peak_picking(app, mzXML_data, self.threshold_begin, self.t_b, self.min_threshold, intern_flag, self.fusion_percentage, map_time); % take only the useful informations

        end
    end
end