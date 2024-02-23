function stop_flag = emergency_check(app)

if app.EMERGENCYSTOPACQUISITIONButton.Value
    stop_flag = 0;
    disp("Emegency stop")
else 
    stop_flag = 1;
end