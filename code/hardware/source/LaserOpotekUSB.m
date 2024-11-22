classdef LaserOpotekUSB

    properties
        port = "COM5"
        baudrate = 115200
        databits = 8
        stopbits = 1
        lascom
    end

    methods
        function init(self)
            self.lascom = serialport(self.port, self.baudrate, "DataBits", self.databits, "StopBits", self.stopbits, "Parity", "none");
            self.lascom.configureTerminator("LF", "CR/LF");
        end

        function temp = get_temp(self, app)
            temp_string = queryUSB(self.lascom, "CGTEMP");
        end
        
    end

end