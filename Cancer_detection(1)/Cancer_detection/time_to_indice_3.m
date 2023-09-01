function carte_ind = time_to_indice_3(carte_time)

si = size(carte_time);

% min_val = min(min(carte_time));
% [rows,cols,vals] = find(carte_time == min_val)

time_tab = carte_time(1,:);
for i = 2 : si(1) 
    time_tab = [time_tab carte_time(i,:)];
end

[B,I] = sort(time_tab);

B2 = unique(B);

for  i = 1 : length(B2)
    [rows,cols,vals] = find( carte_time == B2(i) );
    carte_ind(rows,cols) = i ;
end