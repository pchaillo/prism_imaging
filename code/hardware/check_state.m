function check_state(state, app)

% Checks the state of the hardware, and modifies the interface accordingly

if state.robot_connected == 0 % Those properties will eventually be 
    % replaced by equivalent public properties (app.robot state etc.)
    app.StateLampRobot.Color = [1 0 0];
    app.ConnectRobotButton.Enable = "on";
    app.DisconnectRobotButton.Enable = "off";
else
    app.StateLampRobot.Color = [0 1 0];
    app.ConnectRobotButton.Enable = "off";
    app.DisconnectRobotButton.Enable = "on";
end

if state.sensor_connected == 0
    app.ConnectSensorButton.Enable = "on";
%     app.SensorCalibrationStateLamp.Color = [1 0 0]; Is there a flag for
%     calibration?
else
%     app.ConnectSensorButton.Enable = "off"; I feel like this could be an
%     issue in the case where somebody wants to switch sensors. Need to
%     investigate whether this is a concern for the remaining hardware as
%     well.
    app.LaunchSensorCalibrationButton.Enable = "off";
%     app.SensorCalibrationStateLamp.Color = [0 1 0];
end

if state.source_connected == 0
    app.ConnectSourceButton.Enable = "on";
    app.TurnLampOnButton.Enable = "off";
    app.TurnLampOffButton.Enable = "off";
    app.GetStateButton.Enable = "off";
    app.GetTempButton.Enable = "off";
    app.StateLampOpotek.Color = [1 0 0];
    app.Lamp_LampONorOFF.Color = [1 0 0];
else
    app.StateLampOpotek.Color = [0 1 0];
%     app.Lamp_LampONorOFF.Color = [0 1 0]; Which flag checks whether the
%     lamp is turned on?

end

