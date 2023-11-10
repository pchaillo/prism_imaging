% FR : Permet d'isoler la valeur utiles entre les bornes de masses d'ionisation qui ont été fixées
% ENG : Function to select the maximal intensity between the choosen limits values

function value = peak_selection(limits,bio_line)

peak_tab = bio_line.peaks.mz;

v = 0;
l = length(peak_tab);

ind_m = find( peak_tab(:,1) <limits(2) );
ind_p = find( peak_tab(:,1) >limits(1) );

i_p = max(ind_m);
i_m = min(ind_p);

for i = i_m : i_p
    if peak_tab(i,1) > limits(1) &&  peak_tab(i,1) < limits(2)
        if peak_tab(i,2) > v
            v = peak_tab(i,2);
        end
    end
end

value = v;
