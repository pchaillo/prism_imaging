classdef RobotBase
   
    properties
       % Contain all the properties that are same for each robot
       % Nb_shoot_per_burst = 5
    end

    methods

        function robot_co = connect(robot) 
           % insert code to init connexion with the robot % init_tcp for MECA500
        end

        function disconnect(robot, robot_co, ~) 
           % insert code to stop connexion with the robot % close_tcp_r.m for MECA500
        end
        
        function reset_error(robot, robot_co) % utile ?
           % insert code to remove error state of the robot % reset_error.m for MECA500
        end
        
        function set_position(robot, robot_co,pos)
            % pos is a list that contain 6 value : 3 positions and 3 orientations
           % insert code to set the robot position by sensing a frame % set_pos.m for MECA500

            global state
            state.stop_flag = security_check(a(1),a(2),a(3));
        end

        function go_to_rest_position(robot, robot_co) % utile ?
           % insert code to put the error in rest position % hugh_to_sleep.m for MECA500
        end
        
   end
end