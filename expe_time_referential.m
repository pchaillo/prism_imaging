
% %% Reading code 
% 
%  data = mzxmlread_2019("time_ref_test_LF.mzXML");

 
%% Expe code :

 arduino_object = arduino();
 
 pin = 'A5';
 
 writeDigitalPin(arduino_object,pin,0)
 pause(0.1)
 writeDigitalPin(arduino_object,pin,1)
 
 disp(arduino_object)
 disp("Triggering done")
 
 time_ref = tic;
 
 format long
 
 while 1
     pause(0.001)
     time = toc(time_ref);
     disp(time)
 end
