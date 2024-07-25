
function time_gap_median = record_map(map, name)
% Records the .map in its designated folder

size_time = size(map.time);
u = 0;

for i = 1 : size_time(1)
    for j = 1 : size_time(2)
        u = u + 1;
        time_lists_raw(u) = map.time(i,j);
    end
end
times_list = sort(time_lists_raw);
time_gap_list = time_list_to_time_gap(times_list);
time_gap_median = median(time_gap_list);
time_gap_mean = mean(time_gap_list);

figure()
mesh(map.x,map.y,map.z)
axis equal

folder_name = 'files\map files';

path = path_editor(folder_name, name);

punto = fopen(path,'w');

% On rentre les dimensions pour la reconstruction %%%
si = size(map.z);
fprintf(punto,'%f %f %f %f \n', si(1), si(2), time_gap_median, 0);

%%% On rentre les données dans le document %%%
for x_ind = 1 : si(1)
    for y_ind = 1 : si(2)
        fprintf(punto,'%f %f %f %f \n',map.x(x_ind,y_ind), map.y(x_ind,y_ind), map.z(x_ind,y_ind),map.time(x_ind,y_ind) );
    end
end
fclose(punto);

fprintf('Recommended time gap for peak detection %f \n', time_gap_median);