function biologic_3D_acquisition(robot,sensor,laser,t_b,nb_shot,time_ref)

% with spectro time_ref

% mono_carto_top_real_time3
% rajoute msg state pour watchdog opotek (avec mesure8)
% un seul passage => nvx capteur
% cartographie la zone et non l'objet
% avec enregistrement des temps

global carte % essayer de reduire ses dependances non explicites
global scan
global zone
global state

disp('Creating the map');

opo_flag = 0 ; % avec message lors du repositionnement pour le watchdog

%% Creation of the empty map variable (useful for real_display of the topographic map)
v = 0;
for k = zone.dec : scan.pas : zone.dim_x+zone.dec
    v = v + 1 ;
    u = 0;
    for j = 2 : scan.pas : zone.dim_y +2
        u = u + 1 ;
        carte.x(v,u) = k;
        carte.y(v,u) = j;
    end
end

if laser.continuous_flag == 1
    laser.class.tir_continu_ON(laser.connexion)
end

si_c = size(carte.x);
carte.i = zeros(si_c(1),si_c(2));
v = 0;
delta = 0;
%first_point = 1;

for k = zone.dec : scan.pas : zone.dim_x + zone.dec
    v = v + 1 ;
    if ( mod(v,2) ~= 0 )
        u = 0;
        for j = 2 : scan.pas : zone.dim_y +2
            u = u +1;
            a = [k  j  scan.dh+delta 180 0 180];
            if state.arret == 0
                [k j ] % show the current position of the robot / may be useless ( comment it )
                robot.class.set_position(robot.connexion,a);
            end
            carte.x(v,u) = k;
            carte.y(v,u) = j;
            % carte.r(v,u) = mesure_2(vid,new_tab,scan.h);
            h_m = get_rectified_data(sensor,robot,k,j,delta,opo_flag);
            carte.i(v,u) =  h_m ;

            % state_double = get_state(opotek); % pour watchdog

            rl_time_display()

            delta = h_m;

            a = [k  j  scan.dh+delta 180 0 180]; %replace le robot pour s'assurer d'etre a la distance scan.dh de la surface
            if state.arret == 0
                [k j ] % show the current position of the robot / may be useless ( comment it )
                robot.class.set_position(robot.connexion,a);
                %                 tir_opotek(opotek,nb_shot);
                if laser.continuous_flag == 0
                    laser.class.tir(laser.connexion,nb_shot)
                end%                 if first_point == 1
                %                     first_point = 0;
                %                     tic;
                %                 end
                carte.time(v,u) = toc(time_ref);
                pause(t_b);
            end

        end
    else
        u =  ( zone.dim_y  ) / scan.pas +2  ;
        for j = zone.dim_y+2 : -scan.pas : 2 % décalage de deux millimètres pour éviter les bloquages
            u = u - 1;
            a = [k  j  scan.dh+delta 180 0 180];
            if state.arret == 0
                [k j ] % show the current position of the robot / may be useless ( comment it )
                robot.class.set_position(robot.connexion,a);
            end
            carte.x(v,u) = k;
            carte.y(v,u) = j;
            % carte.r(v,u) = mesure_2(vid,new_tab,scan.h);
            h_m = get_rectified_data(sensor,robot,k,j,delta,opo_flag);
            carte.i(v,u) =  h_m ;

            % state_double = get_state(opotek); % pour watchdog

            rl_time_display()

            delta = h_m;

            a = [k  j  scan.dh+delta 180 0 180]; %replace le robot pour s'assurer d'etre a la distance scan.dh de la surface
            if state.arret == 0
                [k j ] % show the current position of the robot / may be useless ( comment it )
                robot.class.set_position(robot.connexion,a);
                %                 tir_opotek(opotek,nb_shot);
                if laser.continuous_flag == 0
                    laser.class.tir(laser.connexion,nb_shot)
                end                
                carte.time(v,u) = toc(time_ref);
                pause(t_b);
            end
        end
    end

end

if laser.continuous_flag == 1
    laser.class.tir_continu_OFF(laser.connexion)
end

end