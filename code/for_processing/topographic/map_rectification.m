function [map_out, nb_err ]= map_rectification(map,min_threshold,max_threshold)

% Remove automatically value out of the minimal and maximal height thresold 
% => This values are replaced by the mean of all the collateral values
% (except the other false ones)
% This functions also return the number of false that have been corrected (nb_err)

map_dim = size(map);

map_out = map;

nb_err = 0;

for i = 1 : map_dim(1)
    for j = 1 : map_dim(2)            
        if map(i,j) < min_threshold || map(i,j) > max_threshold || map(i,j) == 0.01 || map(i,j) == 0.02
                        
            %%% Edges Detection %%%
            edge_flags = edge_detection(i,j,map_dim);
            
            neighbor_flag = false_neighbor_detection(i,j,edge_flags,min_threshold,max_threshold,map,map_out);
                
            map_out(i,j) = compute_new_height(i,j,edge_flags,neighbor_flag,map_out);

            nb_err = nb_err + 1;
        end
    end
end
