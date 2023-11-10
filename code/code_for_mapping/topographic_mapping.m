function topographic_mapping(robot,sensor)

% with time recording
% mono_carto_topo3
% un seul passage => nvx capteur
% cartographie la zone et non l'objet

global carte
global scan
global zone
global state

disp('Creating the map');

opo_flag = 0 ; % sans message lors du repositionnement pour le watchdog

%%% tableau initial %%%
% indispensable pour l'affichage temps réel (sinon les dimensions des
% tableaux changent et cela génère des erreurs)
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

si_c = size(carte.x);
carte.i = zeros(si_c(1),si_c(2));
v = 0;
delta = 0;

% t_b = 0.5; for tests

first_point = 1;

for k = zone.dec : scan.pas : zone.dim_x+zone.dec
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
            rl_time_display()
            
            delta =  h_m;
            
            if first_point == 1
                first_point = 0;
                tic;
            end
            carte.time(v,u) = toc;
            
            %             a = [k  j  scan.dh+delta 180 0 180]; %replace le robot pour s'assurer d'etre a la distance scan.dh de la surface
            %             if robot.arret == 0
            %                 [k j ] % show the current position of the robot / may be useless ( comment it )
            %                  set_pos(a,t);
            % %                 disp('tir')
            
            % pause(t_b); % for tests
            
            %             end
            
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
            rl_time_display()
            
            delta = h_m;
            carte.time(v,u) = toc;

            %             a = [k  j  scan.dh+delta 180 0 180]; %replace le robot pour s'assurer d'etre a la distance scan.dh de la surface
            %             if robot.arret == 0
            %                 [k j ] % show the current position of the robot / may be useless ( comment it )
            %                  set_pos(a,t);
            % %                 disp('tir2')
            
            %  pause(t_b); % for tests
              
            %           end
        end
    end
end