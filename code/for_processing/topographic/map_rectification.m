function [map_out, nb_err ]= map_rectification(map,min_threshold,max_threshold)

% Remove automatically value out of the minimal and maximal height thresold 
% => This values are replaced by the mean of all the collateral values
% (except the other false ones)
% This functions also return the number of false that have been corrected (nb_err)

si = size(map);

map_out = map;

nb_err = 0;

s_n = min_threshold ; %+ scan.s_offset; % seuil négatif de valeur considérée comme fausse / negative threshold, under it, the value is consider as false

surf_max = max_threshold; % + scan.s_offset;

for i = 1 : si(1)
    for j = 1 : si(2)            
        if map(i,j) < s_n || map(i,j) > surf_max || map(i,j) == 0.01 || map(i,j) == 0.02
                        
            %%% Edges Detection %%%
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
            if map_out(i-i_m,j) < s_n || map_out(i-i_m,j) > surf_max || map(i,j) == 0.01 || map(i,j) == 0.02
                a = 0;
            else
                a = 1;
            end
            
            if map_out(i+i_p,j) < s_n || map_out(i+i_p,j) > surf_max || map(i,j) == 0.01 || map(i,j) == 0.02
                b = 0;
            else
                b = 1;
            end
            
            if map_out(i,j-j_m) < s_n ||  map_out(i,j-j_m) > surf_max || map(i,j) == 0.01 || map(i,j) == 0.02
                c = 0;
            else
                c = 1;
            end
            
            if map_out(i,j+j_p) < s_n || map_out(i,j+j_p) > surf_max || map(i,j) == 0.01 || map(i,j) == 0.02
                d = 0;
            else
                d = 1;
            end
            sum_tab = [ a b c d];
            if sum( sum_tab ) == 0
                map_out(i,j) = 0 ;
            else
                map_out(i,j) = ( a*map_out(i-i_m,j) + b*map_out(i+i_p,j) + c*map_out(i,j-j_m) + d*map_out(i,j+j_p) ) / (a+b+c+d);
            end
            
            nb_err = nb_err + 1;
        end
    end
end