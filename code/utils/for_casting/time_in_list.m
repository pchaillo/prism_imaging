function B = time_in_list(carte_time)

% this function modify the shape of the variable mapping time
% from tab(x*y) => tab(nb_pt)
% to put all the time in line (croisant)

si = size(carte_time);

time_tab = carte_time(1,:);
for i = 2 : si(1) 
    time_tab = [time_tab carte_time(i,:)];
end

[B,I] = sort(time_tab);