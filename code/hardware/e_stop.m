function e_stop(source, robot, arduino, sensor, imaging_mode, app)
% Completely stops the imaging process 
%   Disconnects the source and robot, then clears arduino connexions if
%   they exist.

robot.class.disconnect(app);

if imaging_mode ~= app.TopographyOnlyButton
    source.class.STOP_continuous_trigerring(app);
end

clear(arduino)
clear(sensor)

end
