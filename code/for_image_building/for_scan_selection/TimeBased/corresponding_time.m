function Final_selected_indices_list = corresponding_time(scan_time_list,topography_time_list)

for i = 1 : length(topography_time_list)
    u = 0;
    time1 = topography_time_list(i);
    for j = 1 : length(scan_time_list);
        u = u+1;
        time_gap_array(u) = abs(time1 - scan_time_list(u));
    end
    [min_delta,Final_selected_indices_list(i)] = min(time_gap_array);
    clear time_gap_array
%     Final_selected_indices_list(i) = find(min_delta==time_gap_array)
end