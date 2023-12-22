function [carte_f, nb_err ]= recti(carte_i)

% Rectifie les valeurs impossibles => elles sont remplacées par une moyenne
% des valeurs enrivonnantes. (sans prendre en compte les valeurs voisines
% impossibles

global scan

si = size(carte_i);

carte_f = carte_i;

nb_err = 0;

s_n = - 1 ;%+ scan.s_offset; % seuil négatif de valeur considérée comme fausse / negative threshold, under it, the value is consider as false

surf_max = scan.hmax;% + scan.s_offset;

for i = 1 : si(1)
    for j = 1 : si(2)
    %    if carte_i(i,j) > scna.hmax;
            
        if carte_i(i,j) < s_n || carte_i(i,j) > surf_max || carte_i(i,j) == 0.01 || carte_i(i,j) == 0.02
                        
            %%% détection des bords %%%
            if i == 1
                i_m = -1;
            else
                i_m = 1;
            end
            
            if i == si(1)
                i_p = -1;
            else
                i_p = 1;
            end
            
            if j == 1
                j_m = -1;
            else
                j_m = 1;
            end
            
            if j == si(2)
                j_p = -1;
            else
                j_p = 1;
            end
            
            %%% détection des voisins faux eux aussi %%%
            if carte_f(i-i_m,j) < s_n || carte_f(i-i_m,j) > surf_max || carte_i(i,j) == 0.01 || carte_i(i,j) == 0.02
                a = 0;
            else
                a = 1;
            end
            
            if carte_f(i+i_p,j) < s_n || carte_f(i+i_p,j) > surf_max || carte_i(i,j) == 0.01 || carte_i(i,j) == 0.02
                b = 0;
            else
                b = 1;
            end
            
            if carte_f(i,j-j_m) < s_n ||  carte_f(i,j-j_m) > surf_max || carte_i(i,j) == 0.01 || carte_i(i,j) == 0.02
                c = 0;
            else
                c = 1;
            end
            
            if carte_f(i,j+j_p) < s_n || carte_f(i,j+j_p) > surf_max || carte_i(i,j) == 0.01 || carte_i(i,j) == 0.02
                d = 0;
            else
                d = 1;
            end
            somme = [ a b c d];
            if sum( somme ) == 0
                carte_f(i,j) = 0 ;
            else
                carte_f(i,j) = ( a*carte_f(i-i_m,j) + b*carte_f(i+i_p,j) + c*carte_f(i,j-j_m) + d*carte_f(i,j+j_p) ) / (a+b+c+d);
            end
            
            nb_err = nb_err+1;
        end
    end
end
