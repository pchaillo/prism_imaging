function stop_flag = emergency_check(app)

if app.EMERGENCYSTOPButton.Value
    stop_flag = 0;
    disp("Emegency Stop!")
else 
    stop_flag = 1;
end