function display_spectra_zone(app, pixels_scans,map,limits,loud_flag,nom_mat)


[selected_ind_list,map_color,min_max_list] = extract_spectra_zone(app, pixels_scans,map,limits,loud_flag,nom_mat);

%% Plot multiple spectra
if isfield(map,'time') % ligne en double avec extract_spectra_zone = to clean #TODO
    time_flag = 1;
else
    time_flag = 0;
end
[ pixels_ind, ~, pixels_mz, ~] = data_on_map(app, pixels_scans,map,limits,map.time,time_flag,loud_flag);
[ map.x,map.y,map.z,pixels_mz ] = fix_border(map.x,map.y,map.z,pixels_mz,pixels_ind);
pixels_scans = fix_ms_data(pixels_scans);
pixels_mz = replace_NaN_by_zero(pixels_mz);

ind_peaks = 0;
for n = 1 : length(selected_ind_list) % récupère les temps et les spectres associés aux indices
    ind_peaks = ind_peaks + 1 ;
    peaks(ind_peaks) = {pixels_scans(selected_ind_list(n)).peaks.mz};
    times(ind_peaks) = pixels_scans(selected_ind_list(n)).retentionTime;
end
peaks = peaks';
times = times';

plot_multiple_spectra(peaks,times,length(selected_ind_list))

title_str = 'Selected area in yellow';
display_mz_map(map,map_color,title_str)

si_p = size(peaks);

win = 0.1;
band = [200 1500];

%f irst line % 1ere ligne
raw_peak_array = peaks{1, 1}  ;
fix_peak_array = bining_fixed_size(raw_peak_array,win,band);
all_selected_spectra_struct(1) = {fix_peak_array};
peak_sum_array = fix_peak_array;

for i = 2 : si_p(1)
    raw_peak_array = peaks{i, 1}  ;
    fix_peak_array = bining_fixed_size(raw_peak_array,win,band);
    all_selected_spectra_struct(i) = {fix_peak_array};
    peak_sum_array(:,2) = peak_sum_array(:,2) + fix_peak_array(:,2);
end

plot_spectra(peak_sum_array)
title('Sum of all the spectra of the zone');