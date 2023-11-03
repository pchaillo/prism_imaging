function hauteur = get_rectified_data(sensor,robot,k_pos,j,delta,opo_flag)

% Pour Mass spectro, with taking in care the opotek watchdog
global opotek;

% pour le nouveau capteur (ILD1320-25 - Microepsilon) avec repositionnement
% changement hauteur pour trouver le laser
% interpolation ordre 3

% Renvoie la hauteur mesurée par le capteur

% Avec nouveau repositionnement anti-blocage

global scan;

u = 0;
k = 0;
hauteur_1 = 0;
mes_ok = 0 ;

nb_trames_id = 5; %nombre de trames identiques avant repositionnemnt

l = length(new_tab);

%min = new_tab(1,1);
max = new_tab(1,l);

compt_def = 0;

nb_boucle_mesure = 1200; % 1200
nb_boucle_repeat = 100; % 1200


nb_bcl_repos = 0;

deca = 0;
deca_hmax = 5;

premier_passage = 1;

new_tab = sensor.tab_etal;

while u == 0  || mes_ok == 0
    k = k +1;
    %    if  mod(k,100) == 0 && k> 500
    if  k >= nb_boucle_mesure && mod(k,nb_boucle_repeat) == 0
        
        d_y = sensor.class.get_data(sensor.connexion); %tension renvoyee par le capteur
        
        si = size(new_tab);
        
        for z = 1 : si(2)-3
            if abs(d_y) > abs(new_tab(2,z+1)) && abs(d_y) < abs(new_tab(2,z+2))
                %       hauteur_1 = ( new_tab(1,z) + new_tab(1,z+1) ) / 2;
                y = [ new_tab(1,z) new_tab(1,z+1)  new_tab(1,z+2) new_tab(1,z+3) ];
                x = [ new_tab(2,z) new_tab(2,z+1) new_tab(2,z+2) new_tab(2,z+3)];
                p = polyfit(x,y,3);
                hauteur_1 = p(1)*d_y^3 + p(2)*d_y^2 + p(3)*d_y + p(4);
                hauteur = scan.dh + deca - hauteur_1  +delta ;
                mes_ok = 1;
            end
        end
        
        %% nouveau repos
        if d_y < new_tab(2,1)% || d_y == 0
            if scan.fast == 0
                if premier_passage == 1
                    deca = -3;
                    premier_passage = 0;
                end
                disp('repositionnement');
                deca = deca + 1
                
                if opo_flag == 1
                    state_double = get_state(opotek);
                end
                                
                a = [k_pos j scan.dh+delta+deca 180 0 180];
                robot.class.set_position(robot.connexion,a); 
              %  set_pos(a,t);
                if deca > deca_hmax
                    deca = 0;
                    hauteur = -2;
                    disp('mesure impossible');
                    mes_ok = 1;
                end
            else
                hauteur = -2;
                mes_ok = 1;
            end
        end
        
        %% ancien repositionnement
        %             set_pos(a,t);
        %         if d_y > new_tab(2,l)
        %             disp('repositionnement')
        %             a = [k_pos j scan.dh+delta-1 180 0 180];
        %             set_pos(a,t);
        % %             hauteur = 10 ;
        % %             mes_ok = 1;
        %         elseif d_y == 0
        %             hauteur = 0.01;
        %             mes_ok = 1 ;
        %         end
        %         %     end
        %         if mes_ok == 0
        %             compt_def = compt_def + 1;
        %         end
        %         %  if k > 1000
        %         u = 1 ;
        %         % end
        %         %         if compt_def == nb_trames_id
        %         %             scan.dh = scan.dh + 1;
        %         %             if scan.dh >= max-2
        %         %                 scan.dh = scan.dh_d;
        %         %                 nb_bcl_repos = nb_bcl_repos+1;
        %         %             end
        %         %             compt_def = 0;
        %         %             disp('repositionnement')
        %         %             a = [k_pos j scan.h 180 0 180];
        %         %             set_pos(a,t);
        %         %         end
        %
        %         if nb_bcl_repos >= 2
        %             hauteur = -2;
        %             mes_ok = 1;
        %             disp('laser non detecté')
        %         end
        %%
        u = 1;
    end %
end


% if hauteur < -3 % en donnant des valeurs fixes impossibles aux points faux, cela permet de les retrouver pour les corriger par la suite
%     hauteur = 0.01;
% end

if hauteur > scan.s_offset + scan.hmax
    hauteur = 0.02;
end


