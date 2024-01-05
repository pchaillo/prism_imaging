% Réalise le groupement des données
% remet le tableau dans une forme finie définie par band, la bande de
% masses qui nous interesse et bining_step, la largeur de la fenetre de bining

% forme finie => comparable entre elles
% FORME NORMALISé

% Copie de bining_2 (anciennment bining_norm)

function bined_peak_array = bining_fixed_size(peak_array,bining_step,band)

band_begin = band(1);
band_end = band(2);

l = length(peak_array);

ind_in_bined_array = 0;

bined_peak_array = zeros(1,2); % for c

ind_p = 0;

for mz = band_begin : bining_step : band_end - bining_step
    
    all_peaks_over_mass_array = find ( peak_array(:,1) > mz );%&& peak_array(:,1) < mz +bining_step);
    all_peaks_under_max_mass_array = find( peak_array(:,1) < mz + bining_step);
    max_ind = max(all_peaks_under_max_mass_array);
    min_ind = min(all_peaks_over_mass_array);
    
    ind_in_bined_array = ind_in_bined_array + 1;
    
    if min_ind < max_ind
        bined_peak_array(ind_in_bined_array,2) = sum(peak_array(min_ind:max_ind,2));
        bined_peak_array(ind_in_bined_array,1) = mz;
    elseif min_ind == max_ind % if there is only one m/z that fit to the bining_step in peak_aray
        bined_peak_array(ind_in_bined_array,2) = peak_array(min_ind,2);
        bined_peak_array(ind_in_bined_array,1) = mz;
    else
        bined_peak_array(ind_in_bined_array,2) = 0;
        bined_peak_array(ind_in_bined_array,1) = mz;
    end 
end
