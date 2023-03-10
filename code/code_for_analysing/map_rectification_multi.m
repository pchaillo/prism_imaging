function [carte_f, nb_err ]= map_rectification_multi(carte_i,seuil_min,seuil_max,x_tab,y_tab)

% x_d et y_d coordonnées des points à déturire

% Rectifie les valeurs impossibles => elles sont remplacées par une moyenne
% des valeurs enrivonnantes. (sans prendre en compte les valeurs voisines
% impossibles

% prise en compte des voisins en croix (plus) pas en carré

si = size(carte_i);

carte_f = carte_i;

nb_err = 0;

s_n = seuil_min ;%+ scan.s_offset; % seuil négatif de valeur considérée comme fausse / negative threshold, under it, the value is consider as false

surf_max = seuil_max;% + scan.s_offset;

%%
% i = x_d;
% j = y_d;

l = length(x_tab);

for w = 1 : l
    
    i = x_tab(w);
    j = y_tab(w);
    
    %% détection des bords %%%
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
    
    %%% detection des voisins aussi cochés
    
    if w < l
        for k = w+1 : l
            if i-1 == x_tab(k) && j == y_tab(k)
                a = 0;
            end
            if i+1 == x_tab(k) && j == y_tab(k)
                b = 0;
            end
            if i == x_tab(k) && j-1 == y_tab(k)
                c = 0;
            end
            if i == x_tab(k) && j+1 == y_tab(k)
                d = 0;
            end
        end
    end
    
    somme = [ a b c d];
    
    if sum( somme ) == 0
        carte_f(i,j) = 0 ;
    else
        carte_f(i,j) = ( a*carte_f(i-i_m,j) + b*carte_f(i+i_p,j) + c*carte_f(i,j-j_m) + d*carte_f(i,j+j_p) ) / (a+b+c+d);
    end
    
end

