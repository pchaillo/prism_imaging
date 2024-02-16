function [map_out, nb_err ]= map_rectification_multi(map,min_threshold,max_threshold,x_list,y_list)

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

l = length(x_list);

for ind = 1 : l
    
    x = x_list(ind);
    y = y_list(ind);
    
    edge_flags = edge_detection(x,y,dim_map);

    neighbor_flag = false_neighbor_detection(x,y,edge_flags,min_threshold,max_threshold,map,map_out);
    
    neighbor_flag = add_selected_neighbor(x,y,neighbor_flag,ind,x_list,y_list,l);
    
    map_out(x,y) = compute_new_height(x,y,edge_flags,neighbor_flag,map_out);
    
end

