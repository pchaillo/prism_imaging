function opotekusbtest()
clear lascom

addpath("code\hardware\source\")

lascom = serialport("COM5", 115200, "DataBits", 8, "StopBits", 1, "Parity", "none");
lascom.configureTerminator("LF", "CR/LF");

queryUSB(lascom, "STATE")

queryUSB(lascom, "CGTEMP")

queryUSB(lascom, "RUN")

end