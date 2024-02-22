function map_ind = time_to_indice(map_time)

% this function replace the time in the map_time variable by indices (with the same shape),
% deduct by the time (croissant)

time_list = time_to_list(map_time);

corrected_time_list = unique(time_list); 

for  i = 1 : length(corrected_time_list)
    [rows,cols,vals] = find( map_time == corrected_time_list(i) );
    map_ind(rows,cols) = i ;
end