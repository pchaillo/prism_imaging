function time_ref = trigger_spectro_time(a)

writeDigitalPin(a,'A5',0) 
pause(0.1)
writeDigitalPin(a,'A5',1)

disp(a)
disp("Triggering done")

time_ref = tic;