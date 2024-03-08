function export_spectra_zone_csv(app, pixels_scans,map,limits,loud_flag,nom_mat)

[selected_ind_list,map_color,min_max_list] = extract_spectra_zone(app, pixels_scans,map,limits,loud_flag,nom_mat);

%% CSV Recording
min_x = min_max_list(1) ;
max_x = min_max_list(2) ;
min_y = min_max_list(3) ;
max_y = min_max_list(4) ;
csv_filename = "files/csv files/"+nom_mat+"_Xzone_"+min_x + "_" + max_x+"_Yzone_"+min_y+"_"+max_y+".csv";

ind_peaks = 0; % Refactor to do with display_spectra_zone % #TODO
for n = 1 : length(selected_ind_list) % récupère les temps et les spectres associés aux indices
    ind_peaks = ind_peaks + 1 ;
    peaks(ind_peaks) = {pixels_scans(selected_ind_list(n)).peaks.mz};
    times(ind_peaks) = pixels_scans(selected_ind_list(n)).retentionTime;
end
peaks = peaks';
times = times';
si_p = size(peaks);
win = 0.1;
band = [200 1500];
raw_peak_array = peaks{1, 1}  ;
fix_peak_array = bining_fixed_size(raw_peak_array,win,band);
peak_sum_array = fix_peak_array;

for i = 2 : si_p(1)
    raw_peak_array = peaks{i, 1}  ;
    fix_peak_array = bining_fixed_size(raw_peak_array,win,band);
    all_selected_spectra_struct(i) = {fix_peak_array};
    peak_sum_array(:,2) = peak_sum_array(:,2) + fix_peak_array(:,2);
end

export_spectra_to_csv(peak_sum_array,csv_filename);
disp(csv_filename)

ind_peaks = 0;
for n = 1 : length(selected_ind_list) % récupère les temps et les spectres associés aux indices
    ind_peaks = ind_peaks + 1 ;
    csv_name = "files/csv files/"+nom_mat+"_Xzone_"+min_x + "_" + max_x+"_Yzone_"+min_y+"_"+max_y+"_scan_"+ind_peaks+".csv" ;
    peaks_array = {pixels_scans(selected_ind_list(n)).peaks.mz};
    export_spectra_to_csv(peaks_array,csv_name);
end

% csv_spectra_recorder(peak_sum_array,"Test_sauv_somme.csv") % fonction qui n'existe pas, appeler plutot csv_extractor #TODO
% #TODO : sauver tous les spectres dans un unique .csv et la somme dans un autre ?
