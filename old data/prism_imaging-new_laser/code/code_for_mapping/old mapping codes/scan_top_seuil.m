function scan_top_seuil(t,seuil,ard,t_b)

% prend en compte l'offset (le décalge entre le laser mapping et scanning)
%pas d'adaptation angulaire

disp('scan biométrique')

% ne fait pas toutes les cases pour aller + vite
freq = 1 ;% impair c'est mieux => balayage opti

%t_b = 3; % time between tzo ;easure in second

global carte
global scan
global robot

v = 0;

fact_angle = 1;

si = size(carte.o);

for i =  carte.x_o(1,1)  : scan.pas/scan.pre : carte.x_o(si(1) , 1)
    v = v + 1;
    % if mod(u,freq) == 0
    if ( mod(v,2) == 0 )
        u = 0;
        for j = carte.y_o(1,1) : scan.pas/scan.pre : carte.y_o(1,si(2))
            u = u +1;
            if mod(u,freq) == 0
                z_d = carte.o(v,u);
                d_x_l = scan.d;
                d_y = scan.dx;
                
                a = [i-d_x_l j-d_y z_d+dz 180 0 180]; % sigma =0;
                if robot.arret == 0 && carte.o(v,u) > seuil
                    set_pos(a,t);
                    click(ard);
                    %                     pause(0.01)
                    %                     click(a)
                    %                     pause(0.01)
                    %                     click(a)
                    pause(t_b);
                end
                %  pause()
                %  pos_d = [i; j+scan.d; z_d ];
            end
        end
    else
        %    u = ( objet.dim-1)/(scan.pas/scan.pre) +2;
        u = si(2)+1;
        for j = carte.y_o(1,si(2)) : -scan.pas/scan.pre  : carte.y_o(1,1)
            u = u - 1;
            if mod(v,freq) == 0
                z_d = carte.o(v,u);
                dz = scan.dh;
                d_x_l = scan.d;
                d_y = scan.dx;
                a = [i-d_x_l j-d_y z_d+dz 180 0 180]; % sigma = 0
                if robot.arret == 0 && carte.o(v,u) > seuil
                    set_pos(a,t);
                    click(ard);
                    %                     pause(0.01)
                    %                     click(a)
                    %                     pause(0.01)
                    %                     click(a)
                    pause(t_b);
                end
                % pause()
            end
        end
    end
    % end
end