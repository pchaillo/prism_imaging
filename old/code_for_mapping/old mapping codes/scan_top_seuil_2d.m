function scan_top_seuil_2d(t,opotek,nb_shot,t_b)

%pas d'adaptation angulaire

disp('scan biométrique')

% ne fait pas toutes les cases pour aller + vite
freq = 1 ;% impair c'est mieux => balayage opti

%t_b = 3; % pause time between two laser shot, in second

global carte
global scan
global robot

v = 0;

fact_angle = 1;

si = size(carte.i);

for i =  carte.x(1,1)  : scan.pas : carte.x(si(1) , 1)
    v = v + 1;
    % if mod(u,freq) == 0
    if ( mod(v,2) == 0 )
        u = 0;
        for j = carte.y(1,1) : scan.pas : carte.y(1,si(2))
            u = u +1;
            z_d = scan.dh ; % + scan.s_offset; (deja addtionne dans le main)
            a = [i j z_d 180 0 180]; % sigma =0;
            set_pos(a,t);
            tir_opotek(opotek,nb_shot)
            pause(t_b);
        end
    else
        %    u = ( objet.dim-1)/(scan.pas/scan.pre) +2;
        u = si(2)+1;
        for j = carte.y(1,si(2)) : -scan.pas  : carte.y(1,1)
            u = u - 1;
            z_d = scan.dh; % + scan.s_offset; (deja additionne dans le main)
            a = [i j z_d 180 0 180]; % sigma = 0
            set_pos(a,t);
            tir_opotek(opotek,nb_shot)
            pause(t_b);
        end
    end
    % end
end