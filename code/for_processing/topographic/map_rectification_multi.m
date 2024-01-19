function [map_out, nb_err ]= map_rectification_multi(map,min_threshold,max_threshold,x_tab,y_tab)

% x_d et y_d coordonnées des points à déturire

% Rectifie les valeurs impossibles => elles sont remplacées par une moyenne
% des valeurs enrivonnantes. (sans prendre en compte les valeurs voisines
% impossibles

% prise en compte des voisins en croix (plus) pas en carré
% Only takes vertical and horizontal neighbours into account. Diagonals are
% disregarded. 

dim_map = size(map);

map_out = map;

nb_err = 0;

l = length(x_tab);

for ind = 1 : l
    
    i = x_tab(ind);
    j = y_tab(ind);
    
    edge_flags = edge_detection(i,j,dim_map);

    neighbor_flag = false_neighbor_detection(i,j,edge_flags,min_threshold,max_threshold,map,map_out);
    
    neighbor_flag = add_selected_neighbor(i,j,neighbor_flag,ind,x_tab,y_tab,l);
    
    map_out(i,j) = compute_new_height(i,j,edge_flags,neighbor_flag,map_out);
    
end

