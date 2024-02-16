function time_list = time_to_list(map_time)

% this function modify the shape of the variable mapping time
% from tab(x*y) => tab(nb_pt)
% to put all the time in a list (croisant)

si = size(map_time);

raw_time_list = map_time(1,:);
for i = 2 : si(1) 
    raw_time_list = [raw_time_list map_time(i,:)];
end

[time_list,I] = sort(raw_time_list);