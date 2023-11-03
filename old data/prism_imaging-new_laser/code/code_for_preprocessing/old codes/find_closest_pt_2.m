function time_ind = find_closest_pt_2(time_val_i,time_tab, t_step)

time_band = t_step*2 ; % taille de la bande de temps à balayer

ind = find( time_tab > (time_val_i - time_band) );
ind2 = find(time_tab < (time_val_i+ time_band));

m = min(ind);
m2 = max(ind2);

u = 0;
for i = m : m2
    u = u + 1;
    diff_tab(u) = abs(time_tab(i) -time_val_i);
end

min_diff = min(diff_tab);
min_ind = find(diff_tab==min_diff);

if length(min_ind > 1)
    min_ind = min_ind(1);
end

time_val = time_tab(m + min_ind-1);

time_ind = find(time_tab == time_val);