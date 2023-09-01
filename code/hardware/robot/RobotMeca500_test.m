classdef RobotMeca500
   
    properties
        % Nb_shoot_per_burst = 0
        IP_adress = '192.168.0.100';
        rest_position = [ 137.7 0.1 119.5 180 0 180 ]; 
    end

    methods

        function robot_co = connect(robot)   % init_tcp for MECA500
           % Connexion
            t = tcpip(robot.IP_adress,10000,'NetworkRole','client');
            fopen(t);
            pause(0.1);

            ok = 1;

            while t.BytesAvailable == 0 % && h < 100 % wait robot message
                % h = h + 1;
            end
            data = fread(t, t.BytesAvailable);
            m = char(data);
            m1 = convertCharsToStrings(m);
            m2 = convertContainedStringsToChars(m1);
            m3 = m2(2 : 5 );
            %u = str2double(m3);
            if m3 == '3000'
                disp('Robot Connected')
            end

            %Activation
            %disp('Activation of the robot')
            data = ['ActivateRobot' char(0)];
            fwrite(t,data)
            pause(0.1);
            %pause(5);
            while t.BytesAvailable == 0 % && h < 100 % wait robot message
                % h = h + 1;
            end
            data = fread(t, t.BytesAvailable);
            m = char(data);
            m1 = convertCharsToStrings(m);
            m2 = convertContainedStringsToChars(m1);
            m3 = m2(2 : 5 );
            if m3 == '2000'
                disp('Robot Activated')
            elseif m3 == '1011'
                disp('Robot is in error')
                ok = 0;
            end

            % Home
            data = ['Home' char(0)];
            fwrite(t,data)
            %pause(8); % 10
            pause(0.1);
            while t.BytesAvailable == 0 % && h < 100 % wait robot message
                % h = h + 1;
            end
            data = fread(t, t.BytesAvailable);
            m = char(data);
            m1 = convertCharsToStrings(m);
            m2 = convertContainedStringsToChars(m1);
            m3 = m2(2 : 5 );
            if m3 == '2002'
                disp('Robot Homed')
            end

            data = ['SetJointVel(15)' char(0)]; % set the percentage of maximum velocity, at 25% by default.
            fwrite(t,data)

            data = ['SetBlending(90)' char(0)]; % deactivate trajectory optimisation
            fwrite(t,data)

             %%% Vide le buffer %%%
            if t.BytesAvailable ~= 0 % && h < 100 % wait robot message
                data_r = fread(t, t.BytesAvailable); %vide le buffer
            end

            if ok == 0
                t = 0;
            end

            robot_co = t;
        end

        function disconnect(robot, robot_co)  % close_tcp_r.m for MECA500
           % Pour desactiver le MECA500 et fermer sa connecion TCP/IP

               if robot_co.BytesAvailable ~= 0 % && h < 100 % wait robot message
                   data_r = fread(robot_co, robot_co.BytesAvailable); %vide le buffer
               end

               data = ['DeactivateRobot' char(0)];
               fwrite(robot_co,data)
               pause(0.1)

               while robot_co.BytesAvailable == 0 % && h < 100 % wait robot message
                   % h = h + 1;
               end
               data = fread(robot_co, robot_co.BytesAvailable);
               m = char(data);
               m1 = convertCharsToStrings(m);
               m2 = convertContainedStringsToChars(m1);
               m3 = m2(2 : 5 );
               u = str2double(m3);
               if m3 == '2004'
                   disp('Robot Desactivated')
               end

               pause(0.01)
               fclose(robot_co);

        end
        
        function reset_error(robot, robot_co) % utile ?
           % insert code to remove error state of the robot % reset_error.m for MECA500
        end
        
        function set_position(robot, robot_co,pos)
           % pos is a list that contain 6 value : 3 position and 3
           % orientation

           % insert code to set the robot position by sensing a frame % set_pos.m for MECA500
           global state

           t = robot_co;

            %a(6) = 180 % we should not do that !!
            %disp('dirty fix here')
            a = pos ;
            data = "MovePose("+a(1)+","+a(2)+","+a(3)+","+a(4)+","+a(5)+","+a(6)+")"+char(0);
            data = char(data);

            state.arret = security_check(a(1),a(2),a(3));

        %    if state.arret == 0
                fwrite(t,data);
              %  pause(0.01); % ?
               % h = 0;
                while t.BytesAvailable == 0 % && h < 100 % wait robot message
                   % h = h + 1;
                end
                
                % read robot message
                data = fread(t, t.BytesAvailable);
                m = char(data);
                m1 = convertCharsToStrings(m);
                m2 = convertContainedStringsToChars(m1);
                m3 = m2(2 : 5 );
                u = str2double(m3);
                
                if u ~= 3012 && length(m) == 22
                    robot.arret = 1;
                end
%             else
%                 disp('robot arrêté par sécurité');
%             end
        end

        function go_to_rest_position(robot, robot_co) % utile ?
           % insert code to put the error in rest position % hugh_to_sleep.m for MECA500
           robot.set_position(robot_co,robot.rest_position);
           pause(3);
           robot.disconnect(robot_co);
        end
        
   end
end