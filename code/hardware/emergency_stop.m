function emergency_stop(source, robot, sensor, state,arduino_object, app)
% Completely stops the imaging process 
%   Disconnects the source and robot, then clears arduino connexions if
%   they exist.

if state.source_connected == 1
    source.class.STOP_continuous_trigerring(app);
end


if state.robot_connected == 1 
    robot.class.disconnect(app);
end

clear arduino_object
clear sensor 


end
