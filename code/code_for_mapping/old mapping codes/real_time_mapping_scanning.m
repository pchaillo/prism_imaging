<<<<<<< HEAD
function real_time_mapping_scanning(t,ard,new_tab,opotek,t_b,nb_shot)

% mono_carto_top_real_time3
% rajoute msg state pour watchdog opotek (avec mesure8)
% un seul passage => nvx capteur
% cartographie la zone et non l'objet
% avec enregistrement des temps

global carte
global robot
global scan
global zone

disp('Creating the map');

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
first_point = 1;

for k = zone.dec : scan.pas : zone.dim_x+zone.dec
    v = v + 1 ;
    if ( mod(v,2) ~= 0 )
        u = 0;
        for j = 2 : scan.pas : zone.dim_y +2
            u = u +1;
            a = [k  j  scan.dh+delta 180 0 180];
            if robot.arret == 0
                [k j ] % show the current position of the robot / may be useless ( comment it )
                set_pos(a,t);
            end
            carte.x(v,u) = k;
            carte.y(v,u) = j;
            % carte.r(v,u) = mesure_2(vid,new_tab,scan.h);
            h_m = mesure_8(ard,new_tab,t,k,j,delta);
            carte.i(v,u) =  h_m ;
            
           % state_double = get_state(opotek); % pour watchdog
            
            rl_time_display()
            
            delta = h_m;
            
            a = [k  j  scan.dh+delta 180 0 180]; %replace le robot pour s'assurer d'etre a la distance scan.dh de la surface
            if robot.arret == 0
                [k j ] % show the current position of the robot / may be useless ( comment it )
                set_pos(a,t);
                tir_opotek(opotek,nb_shot);
                if first_point == 1
                    first_point = 0;
                    tic;
                end
                carte.time(v,u) = toc;
                pause(t_b);
            end
            
        end
    else
        u =  ( zone.dim_y  ) / scan.pas +2  ;
        for j = zone.dim_y+2 : -scan.pas : 2 % décalage de deux millimètres pour éviter les bloquages
            u = u - 1;
            a = [k  j  scan.dh+delta 180 0 180];
            if robot.arret == 0
                [k j ] % show the current position of the robot / may be useless ( comment it )
                set_pos(a,t);
            end
            carte.x(v,u) = k;
            carte.y(v,u) = j;
            % carte.r(v,u) = mesure_2(vid,new_tab,scan.h);
            h_m = mesure_8(ard,new_tab,t,k,j,delta);
            carte.i(v,u) =  h_m ;
            
           % state_double = get_state(opotek); % pour watchdog
            
            rl_time_display()
            
            delta = h_m;
            
            a = [k  j  scan.dh+delta 180 0 180]; %replace le robot pour s'assurer d'etre a la distance scan.dh de la surface
            if robot.arret == 0
                [k j ] % show the current position of the robot / may be useless ( comment it )
                set_pos(a,t);
                tir_opotek(opotek,nb_shot);
                carte.time(v,u) = toc;
                pause(t_b);
            end
        end
    end
=======
function real_time_mapping_scanning(t,ard,new_tab,opotek,t_b,nb_shot)

% mono_carto_top_real_time3
% rajoute msg state pour watchdog opotek (avec mesure8)
% un seul passage => nvx capteur
% cartographie la zone et non l'objet
% avec enregistrement des temps

global carte
global robot
global scan
global zone

disp('Creating the map');

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
first_point = 1;

for k = zone.dec : scan.pas : zone.dim_x+zone.dec
    v = v + 1 ;
    if ( mod(v,2) ~= 0 )
        u = 0;
        for j = 2 : scan.pas : zone.dim_y +2
            u = u +1;
            a = [k  j  scan.dh+delta 180 0 180];
            if robot.arret == 0
                [k j ] % show the current position of the robot / may be useless ( comment it )
                set_pos(a,t);
            end
            carte.x(v,u) = k;
            carte.y(v,u) = j;
            % carte.r(v,u) = mesure_2(vid,new_tab,scan.h);
            h_m = mesure_8(ard,new_tab,t,k,j,delta);
            carte.i(v,u) =  h_m ;
            
           % state_double = get_state(opotek); % pour watchdog
            
            rl_time_display()
            
            delta = h_m;
            
            a = [k  j  scan.dh+delta 180 0 180]; %replace le robot pour s'assurer d'etre a la distance scan.dh de la surface
            if robot.arret == 0
                [k j ] % show the current position of the robot / may be useless ( comment it )
                set_pos(a,t);
                tir_opotek(opotek,nb_shot);
                if first_point == 1
                    first_point = 0;
                    tic;
                end
                carte.time(v,u) = toc;
                pause(t_b);
            end
            
        end
    else
        u =  ( zone.dim_y  ) / scan.pas +2  ;
        for j = zone.dim_y+2 : -scan.pas : 2 % décalage de deux millimètres pour éviter les bloquages
            u = u - 1;
            a = [k  j  scan.dh+delta 180 0 180];
            if robot.arret == 0
                [k j ] % show the current position of the robot / may be useless ( comment it )
                set_pos(a,t);
            end
            carte.x(v,u) = k;
            carte.y(v,u) = j;
            % carte.r(v,u) = mesure_2(vid,new_tab,scan.h);
            h_m = mesure_8(ard,new_tab,t,k,j,delta);
            carte.i(v,u) =  h_m ;
            
           % state_double = get_state(opotek); % pour watchdog
            
            rl_time_display()
            
            delta = h_m;
            
            a = [k  j  scan.dh+delta 180 0 180]; %replace le robot pour s'assurer d'etre a la distance scan.dh de la surface
            if robot.arret == 0
                [k j ] % show the current position of the robot / may be useless ( comment it )
                set_pos(a,t);
                tir_opotek(opotek,nb_shot);
                carte.time(v,u) = toc;
                pause(t_b);
            end
        end
    end
>>>>>>> prism_copy_for_tests
end