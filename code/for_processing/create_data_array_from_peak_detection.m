function [data_array,first_point_index] = create_data_array_from_peak_detection(all_scans,threshold_begin,TIC_list,scan_time_list)

%% First peak detection -> find the 1st peak if there is no time coherency (no mass spectrometer trigger) # utiliser variable pour ne le faire que si c'est nécessaire ? #TODO
first_peak_found = 0; 
i = 0; % index
while first_peak_found == 0
    i = i + 1;
    if all_scans(i).totIonCurrent > threshold_begin
        first_point_index = i;
        first_peak_found = 1;
%         disp("First point index") % useful for debug
%         disp(first_point_index)
        if first_point_index == 1
            disp("Warning: Start threshold too low. First scan detected as a peak on the chromatogram.")
        end
    end
end

%% Matlab function peak detection
[selected_peaks, selected_times, ~, ~] = findpeaks(TIC_list, scan_time_list); % Finds peaks and provides their location

time_gap_list = time_list_to_time_gap(selected_times);

for i = 1 : length(selected_times) % Finds times corresponding to given peak indices 
    selected_indices(i) = find( scan_time_list == selected_times(i) );
end

data_array(1,:) = selected_indices; % old ind_peaks % mise des valeurs dans le tableau % utile ? rend le code moins clair ! #TODO
data_array(2,:) = selected_times; % old loc
data_array(3,:) = time_gap_list; % old tab_loc
data_array(4,:) = selected_peaks; % old pk

first_point_index = find(data_array(1,:) == first_point_index); % Suppress all points before the first one
data_array(:,1:first_point_index-1) = [];
