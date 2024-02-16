% Move to peak_selection function => intensity_selection

% FR : Permet d'isoler la valeur utiles entre les bornes de masses d'ionisation qui ont été fixées
% ENG : Allows you to isolate the useful value between the choosen ionization mass band

% system('set username');

function value = set_peaks_norm(app, limits,scan) % pick peak

update_log(app, "Obsolete_function: Use intensity_selection instead! (for_image_building) ")
% Why is this not a comment? #TODO

peak_tab = scan.peaks.mz;

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
