classdef ScanSelectionMethodBase

    properties
        threshold_begin = app.BeginThresholdEditField.Value; % put here data you need for you scan selection method !
        t_b = app.Timebetween2lasershotsecondEditField.Value;
        min_threshold = app.LoudthresholdEditField.Value;
        tolerance = app.FusionpercentSlider.Value;
        intern_trig = app.InternalTriggeringSwitch.Value;
    end

    methods
        function [bio_dat ,time,g] = selection(mzXML.Struct , carte_time )
            % insert laser connexion and return connection object variable
        end
    end
end