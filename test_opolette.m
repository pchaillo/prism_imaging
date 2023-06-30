USB_port = "COM7" % for windows
Baudrate = 9600
Temp_limit = 38

laser_co = serialport(USB_port,Baudrate);
laser_co.configureTerminator("CR/LF");

writeline(laser_co, "ST")
state_string = read(laser_co,15,'string')
disp("test")
disp(state_string)
if state_string > 0
    [state_text, state_double] = laser.choose_state_text(state_string)
else
    state_text = 'Aremplir'
    state_double = 2
end