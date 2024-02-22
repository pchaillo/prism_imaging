function time_ref = mass_spectrometer_trigerring(arduino_object)

writeDigitalPin(arduino_object,'A5',0) 
pause(0.1)
writeDigitalPin(arduino_object,'A5',1)

disp(arduino_object)
disp("Triggering done")

time_ref = tic;