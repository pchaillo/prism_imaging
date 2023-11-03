<<<<<<< HEAD
function scanning_2d(t,opotek,nb_shot,t_b)

%pas d'adaptation angulaire

disp('scan biométrique')

global carte
global scan
global robot
global zone

v = 0;

first_point = 1;

for k = zone.dec : scan.pas : zone.dim_x+zone.dec
    v = v + 1 ;
    if ( mod(v,2) ~= 0 )
        u = 0;
        for j = 2 : scan.pas : zone.dim_y +2
            u = u +1;
            a = [k  j  scan.dh 180 0 180];
            if robot.arret == 0
                [k j ] % show the current position of the robot / may be useless ( comment it )
                set_pos(a,t);
            end
            carte.x(v,u) = k;
            carte.y(v,u) = j;
            carte.i(v,u) =  0 ;
            %rl_time_display()            
            if first_point == 1
                first_point = 0;
                tic;
            end
            tir_opotek(opotek,nb_shot)
            pause(t_b);
            carte.time(v,u) = toc;
        end
    else
        u =  ( zone.dim_y  ) / scan.pas +2  ;
        for j = zone.dim_y+2 : -scan.pas : 2 % décalage de deux millimètres pour éviter les bloquages
            u = u - 1;
            a = [k  j  scan.dh 180 0 180];
            if robot.arret == 0
                [k j ] % show the current position of the robot / may be useless ( comment it )
                set_pos(a,t);
            end
            carte.x(v,u) = k;
            carte.y(v,u) = j;
            carte.i(v,u) =  0 ;
            %rl_time_display()
            tir_opotek(opotek,nb_shot)
            pause(t_b);
            
            carte.time(v,u) = toc;
        end
    end
end

=======
function scanning_2d(t,opotek,nb_shot,t_b)

%pas d'adaptation angulaire

disp('scan biométrique')

global carte
global scan
global robot
global zone

v = 0;

first_point = 1;

for k = zone.dec : scan.pas : zone.dim_x+zone.dec
    v = v + 1 ;
    if ( mod(v,2) ~= 0 )
        u = 0;
        for j = 2 : scan.pas : zone.dim_y +2
            u = u +1;
            a = [k  j  scan.dh 180 0 180];
            if robot.arret == 0
                [k j ] % show the current position of the robot / may be useless ( comment it )
                set_pos(a,t);
            end
            carte.x(v,u) = k;
            carte.y(v,u) = j;
            carte.i(v,u) =  0 ;
            %rl_time_display()            
            if first_point == 1
                first_point = 0;
                tic;
            end
            tir_opotek(opotek,nb_shot)
            pause(t_b);
            carte.time(v,u) = toc;
        end
    else
        u =  ( zone.dim_y  ) / scan.pas +2  ;
        for j = zone.dim_y+2 : -scan.pas : 2 % décalage de deux millimètres pour éviter les bloquages
            u = u - 1;
            a = [k  j  scan.dh 180 0 180];
            if robot.arret == 0
                [k j ] % show the current position of the robot / may be useless ( comment it )
                set_pos(a,t);
            end
            carte.x(v,u) = k;
            carte.y(v,u) = j;
            carte.i(v,u) =  0 ;
            %rl_time_display()
            tir_opotek(opotek,nb_shot)
            pause(t_b);
            
            carte.time(v,u) = toc;
        end
    end
end

>>>>>>> prism_copy_for_tests
end