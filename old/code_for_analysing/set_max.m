% Permet d'isoler la valeur utiles entre les bornes de masses d'ionisation
% qui ont été fixées

% system('set username');
function value = set_max(bio_line,limits)


peak_tab = bio_line.peaks.mz;

l1 = limits(1);
l2 = limits(2);

ind_1 = find(peak_tab(:,1) > l1);
ind_2 = find(peak_tab(:,1) < l2);

min_i = min(ind_1);
max_i = max(ind_2);

peak_tab2 = peak_tab(min_i:max_i,:);

v_max = max(peak_tab2(:,2));
ind_max = find(peak_tab2(:,2) == v_max) ;

if length(ind_max) ~= 1
    ind_max = max(ind_max);
end
v = peak_tab2(ind_max,1);

value = v;

