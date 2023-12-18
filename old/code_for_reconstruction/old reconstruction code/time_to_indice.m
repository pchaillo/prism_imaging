function carte_ind = time_to_indice(carte_time)

si = size(carte_time);

% min_val = min(min(carte_time));
% [rows,cols,vals] = find(carte_time == min_val)

time_tab = carte_time(1,:);
for i = 2 : si(1) 
    time_tab = [time_tab carte_time(i,:)];
end

[B,I] = sort(time_tab);

for  i = 1 : length(B)
    [rows,cols,vals] = find( carte_time == B(i) );
    carte_ind(rows,cols) = i ;
end