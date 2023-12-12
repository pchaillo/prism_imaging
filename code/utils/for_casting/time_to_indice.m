function map_ind = time_to_indice(map_time)

si = size(map_time);

% min_val = min(min(carte_time));
% [rows,cols,vals] = find(carte_time == min_val)

time_tab = map_time(1,:);
for i = 2 : si(1) 
    time_tab = [time_tab map_time(i,:)];
end

[B,I] = sort(time_tab);

B2 = unique(B); % Donner un nom avec du sens à B2 ? #TODO

for  i = 1 : length(B2)
    [rows,cols,vals] = find( map_time == B2(i) );
    map_ind(rows,cols) = i ;
end