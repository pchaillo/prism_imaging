classdef RobotMeca500 < handle
   ...

    properties (SetAccess = public)
        % Nb_shoot_per_burst = 0
        IP_adress = '192.168.0.100';
        rest_position = [ 137.7 0.1 119.5 180 0 180 ];
        current_x = 0;
        current_y = 0;
        current_z = 0;
        robot_communication = "default" % Needed to avoid error on L18
        % #TODO Add current_x, y and z for sensor usage ?
    end

    methods

        function connect(self, app)   % init_tcp for MECA500
            % Connexion
            self.robot_communication = tcpip(self.IP_adress, 10000, 'NetworkRole', 'client');
            fopen(self.robot_communication);
            pause(0.1);

            ok = 1;

            while self.robot_communication.BytesAvailable == 0 % && h < 100 % Wait for robot message
                % h = h + 1;
            end
            data = fread(self.robot_communication, self.robot_communication.BytesAvailable);
            m = char(data);
            m1 = convertCharsToStrings(m);
            m2 = convertContainedStringsToChars(m1);
            m3 = m2(2 : 5 );
            %u = str2double(m3);
            if m3 == '3000'
                update_log(app, 'Robot Connected')
            end

            %Activation
            %disp('Activation of the robot')
            data = ['ActivateRobot' char(0)];
            fwrite(self.robot_communication, data)
            pause(0.1);
            %pause(5);
            while self.robot_communication.BytesAvailable == 0 % && h < 100 % Wait for robot message
                % h = h + 1;
            end
            data = fread(self.robot_communication, self.robot_communication.BytesAvailable);
            m = char(data);
            m1 = convertCharsToStrings(m);
            m2 = convertContainedStringsToChars(m1);
            m3 = m2(2 : 5 );
            if m3 == '2000'
                update_log(app, 'Robot activated')
            elseif m3 == '1011'
                update_log(app, 'Robot in error state')
                ok = 0;
            end

            % Home
            data = ['Home' char(0)];
            fwrite(self.robot_communication, data)
            %pause(8); % 10
            pause(0.1);
            while self.robot_communication.BytesAvailable == 0 % && h < 100 % Wait for robot message
                % h = h + 1;
            end
            data = fread(self.robot_communication, self.robot_communication.BytesAvailable);
            m = char(data);
            m1 = convertCharsToStrings(m);
            m2 = convertContainedStringsToChars(m1);
            m3 = m2(2 : 5 );
            if m3 == '2002'
                update_log(app, 'Robot Homed')
            end

            data = ['SetJointVel(15)' char(0)]; % Set the percentage of maximum velocity, at 25% by default.
            fwrite(self.robot_communication, data)

            data = ['SetBlending(90)' char(0)]; % Disable trajectory optimisation
            fwrite(self.robot_communication, data)

            %%% Empty the buffer %%%
            if self.robot_communication.BytesAvailable ~= 0 % && h < 100 % Wait for robot message
                data_r = fread(self.robot_communication, self.robot_communication.BytesAvailable); % Empty the buffer
            end

            if ok == 0
                self.robot_communication = 0;
            end

            disp("RObot object :")
            disp(self.robot_communication)

        end

        function disconnect(self, app)  % close_tcp_r.m for MECA500
            % Pour desactiver le MECA500 et fermer sa connecion TCP/IP

            if self.robot_communication.BytesAvailable ~= 0 % && h < 100 % wait robot message
                data_r = fread(self.robot_communication, self.robot_communication.BytesAvailable); %vide le buffer
            end

            data = ['DeactivateRobot' char(0)];
            fwrite(self.robot_communication,data)
            pause(0.1)

            while self.robot_communication.BytesAvailable == 0 % && h < 100 % wait robot message
                % h = h + 1;
            end
            data = fread(self.robot_communication, self.robot_communication.BytesAvailable);
            m = char(data);
            m1 = convertCharsToStrings(m);
            m2 = convertContainedStringsToChars(m1);
            m3 = m2(2 : 5 );
            u = str2double(m3);
            if m3 == '2004'
                update_log(app, 'Robot Deactivated')
            end

            pause(0.01)
            fclose(self.robot_communication);

        end

        function reset_error(self) % utile ?
            % insert code to remove error state of the robot % reset_error.m for MECA500
        end

        function set_position(self, pos)
            % pos is a list that contain 6 value : 3 position and 3
            % orientation

            % insert code to set the robot position by sensing a frame % set_pos.m for MECA500
            global state

            %a(6) = 180 % we should not do that !!
            %disp('dirty fix here')
            a = pos ;
            data = "MovePose("+a(1)+","+a(2)+","+a(3)+","+a(4)+","+a(5)+","+a(6)+")"+char(0);
            data = char(data);

            state.stop_flag = security_check(a(1),a(2),a(3));

            %    if state.arret == 0
            disp("RObot object :")
            disp(self.robot_communication)
            fwrite(self.robot_communication,data);
            %  pause(0.01); % ?
            % h = 0;
            while self.robot_communication.BytesAvailable == 0 % && h < 100 % wait robot message
                % h = h + 1;
            end

            % read robot message
            data = fread(self.robot_communication, self.robot_communication.BytesAvailable);
            m = char(data);
            m1 = convertCharsToStrings(m);
            m2 = convertContainedStringsToChars(m1);
            m3 = m2(2 : 5 );
            u = str2double(m3);

            if u ~= 3012 && length(m) == 22
                state.stop_flag = 1;
            end
            %             else
            %                 disp('robot arrêté par sécurité');
            %             end

            robot.current_x = a(1);
            robot.current_y = a(2);
            robot.current_z = a(3);
        end

        function go_to_rest_position(self) % utile ?
            % insert code to put the error in rest position % hugh_to_sleep.m for MECA500
            self.set_position(self.robot_communication, self.rest_position);
            pause(3);
            self.disconnect(self.robot_communication, app);
        end

    end
end
