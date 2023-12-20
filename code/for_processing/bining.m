% Réalise le groupement des données

function bined_peak_array = bining(peak_array,window_width)

if length(peak_array) ~= 0 &&  length(peak_array) ~= 1
    window_left_value = peak_array(1,1);
    si = size(peak_array);
    peak_array_length = si(1);
    
    ind_in_final_array = 0;
    ind_in_all_peaks = 0;
    
    all_peaks_in_window = zeros(1,2); % for c
    bined_peak_array = zeros(1,2); % for c
    
    for i = 1 : peak_array_length
        if peak_array(i,1) >= window_left_value && peak_array(i,1) < window_left_value + window_width
            ind_in_all_peaks = ind_in_all_peaks + 1;
            all_peaks_in_window(ind_in_all_peaks,:) = peak_array(i,:);
        else
            ind_in_final_array = ind_in_final_array + 1;
            %bined_peak_array(k,:) = mean(all_peaks_in_window);
            bined_peak_array(ind_in_final_array,2) = sum(all_peaks_in_window(:,2));
            bined_peak_array(ind_in_final_array,1) = mean(all_peaks_in_window(:,1));
            window_left_value = peak_array(i,1);
            %clearvars all_peaks_in_window
            all_peaks_in_window = zeros(1,2); % for c
            ind_in_all_peaks = 1 ;
            all_peaks_in_window(ind_in_all_peaks,:) = peak_array(i,:);
        end
    end
else
    bined_peak_array = zeros(1,2);
end
