function time_list = time_to_list(map_time)

% this function modify the shape of the variable mapping time
% from tab(x*y) => tab(nb_pt)
% to put all the time in a list (croisant)

si = size(map_time);

time_tab = map_time(1,:);
for i = 2 : si(1) 
    time_tab = [time_tab map_time(i,:)];
end

[time_list,I] = sort(time_tab);