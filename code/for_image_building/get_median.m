function median_value = get_median(pixels_scans)

% Will peak the good median value for normalization based on totIonCurrent values

for i = 1 : length(pixels_scans)
    num_tab(i) = pixels_scans(i).num;
    ionisationEnergy_tab(i) = pixels_scans(i).ionisationEnergy;
end

ind_peaks = find(num_tab > 0);

ionisationEnergy_peaks = ionisationEnergy_tab(ind_peaks);

old_med = median(ionisationEnergy_tab,'all'); % old median that we use for the 1st version of the software
median_value = median(ionisationEnergy_peaks,'all');