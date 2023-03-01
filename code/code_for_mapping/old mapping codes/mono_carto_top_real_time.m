function mono_carto_top_real_time(t,ard,new_tab,opotek,t_b,nb_shot)

% un seul passage => nvx capteur
% cartographie la zone et non l'objet

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
            h_m = mesure_7(ard,new_tab,t,k,j,delta);
            carte.i(v,u) =  h_m + delta;
            rl_time_display()
            
            delta = delta + h_m;
            
            a = [k  j  scan.dh+delta 180 0 180]; %replace le robot pour s'assurer d'etre a la distance scan.dh de la surface
            if robot.arret == 0
                [k j ] % show the current position of the robot / may be useless ( comment it )
                set_pos(a,t);
                tir_opotek(opotek,nb_shot);
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
            h_m = mesure_7(ard,new_tab,t,k,j,delta);
            carte.i(v,u) =  h_m + delta;
            rl_time_display()
            
            delta = delta + h_m;
            
            a = [k  j  scan.dh+delta 180 0 180]; %replace le robot pour s'assurer d'etre a la distance scan.dh de la surface
            if robot.arret == 0
                [k j ] % show the current position of the robot / may be useless ( comment it )
                set_pos(a,t);
                tir_opotek(opotek,nb_shot);
                pause(t_b);
            end
        end
    end
end