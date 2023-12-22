function [data_array,first_point_indice] = create_data_array_from_peak_detection(all_peaks,threshold_begin,TIC_list,Scan_time_list)

%% First peak detection -> find the 1st peak if there is no time coherency (no mass spectrometer trigger) # utiliser variable pour ne le faire que si c'est nécessaire ? #TODO
first_peak_is_finded = 0; 
i = 0; % index
while first_peak_is_finded == 0
    i = i + 1;
    if alls_scans(i).totIonCurrent > threshold_begin
        first_point_indice = i;
        first_peak_is_finded = 1;
    end
end

%% Matlab function peak detection
[selected_peaks, selected_times, w, pw] = findpeaks(TIC_list, Scan_time_list); % trouve les peaks et leurs localisation

time_gap_list = time_list_to_time_gap(selected_times);

for i = 1 : length(selected_times) % Get peaks index, relatively to time !
    selected_indices(i) = find( Scan_time_list == selected_times(i) );
end

data_array(1,:) = selected_indices; % old ind_peaks % mise des valeurs dans le tableau % utile ? rend le code moins clair ! #TODO
data_array(2,:) = selected_times; % old loc
data_array(3,:) = time_gap_list; % old tab_loc
data_array(4,:) = selected_peaks; % old pk

first_point_indice = find(data_array(1,:) == first_point_indice); % Suppress all points before the 1st one
data_array(:,1:first_point_indice-1) = [];