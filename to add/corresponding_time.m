function corr_tab = corresponding_time(time_tab_ms,time_tab_robot)

% time_tab_ms
% time_tab_robot

for i = 1 : length(time_tab_robot)
    u = 0;
    time1 = time_tab_robot(i);
    for j = 1 : length(time_tab_ms);
        u = u+1;
        time_delta_tab(u) = abs(time1 - time_tab_ms(u));
    end
    [min_delta,corr_tab(i)] = min(time_delta_tab);
    clear time_delta_tab
%     corr_tab(i) = find(min_delta==time_delta_tab)
end