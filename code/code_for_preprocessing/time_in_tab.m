function B = time_in_tab(carte_time)

si = size(carte_time);

time_tab = carte_time(1,:);
for i = 2 : si(1) 
    time_tab = [time_tab carte_time(i,:)];
end

[B,I] = sort(time_tab);