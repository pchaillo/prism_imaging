function time_ref = trigger_spectro_time(a)

writeDigitalPin(a,'A5',0) 
pause(0.1)
writeDigitalPin(a,'A5',1)

time_ref = tic;