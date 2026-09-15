classdef PiCamera
   % Uses an external targetting laser and a Raspberry Pi camera. Ethernet
   % is used to connect the Pi. Data is sent through a TCP server built in
   % the measurement script. NOTEE: In this implementation, the user
   % session on the Pi must NOT have a password
    properties
        need_calibration = 1; % bool, 0 = no // 1 = yes   % if you set it to 0, no need to fill sensor_calibration funtcion (will not be called)
        host = "prism@192.168.0.5"; % Be sure to change this to the raspberry pi's name, and to assign it a static IP adress on the same subnet as the main computer's 
        filepath = "~/Documents/Depth_Sensor/camera_py.py"; % Location of the measurement script

        tcp_host = "192.168.0.5";
        tcp_port = 5000;
    end

    methods
        function  init(self) % Creates a communication instance 
            % Establish SSH connection between the main computer and the
            % Pi, the latter parts of the command are used to redirect all
            % input and output of the script to avoid hangups
            initial_command = sprintf('ssh -T %s "nohup setsid python3 -u %s > /dev/null 2>&1 < /dev/null &"', self.host, self.filepath);
            % Execute the initial command to establish the connection
            if system(initial_command) ~= 0
                error('Failed to connect to the Raspberry Pi. Check the host, credentials and filepath.');
            end
            system(initial_command)
           
            % Wait for the Python script to initialize and start sending data
            pause(1);
            fprintf('Measurement starting...\n');
            
            self.tcp_client = tcpclient(self.tcp_host, self.tcp_port);
            
        end

        function disconnect(self) % Closes communication down and reboots the Pi
            system("reboot");
            system("exit"); % Probably not needed as the reboot will kill the connection anyway

        function height = get_data(self, robot) % Robot as input : could be useful to change th height of the robot in case the sensor that is in a impossible configuration (could be useful for triangulation software for exemple).
            raw = read(self.tcp_client, 55, "string"); % This forces us to always have a full measurement at least, which is guaranteed to be in the middle of the text
            split_data = strsplit(raw, "\n");
            data = split_data(2);       

            clear raw  split_data
            
            data = strrep(data, "[", "");
            data = strrep(data, "]", "");
            data = strrep(data, " ", "");
            data = strsplit(data, ",");

            spot_size = data(1);
            roundness = data(2);
            pos_x = data(3);
            pos_y = data(4);


        
        function calibration_array = calibration(sensor,robot)
            calibration_array = default_sensor_calibration(robot, self, parameters, app);
            self.calibration_array = calibration_array;

        end

        end
   end
end