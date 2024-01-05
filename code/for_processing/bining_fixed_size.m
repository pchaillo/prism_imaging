% Réalise le groupement des données
% remet le tableau dans une forme finie définie par band, la bande de
% masses qui nous interesse et window, la largeur de la fenetre de bining

% forme finie => comparable entre elles
% FORME NORMALISé

% Copie de bining_2 (anciennment bining_norm)

function binned_peak_array = bining_fixed_size(peak_array,window,band)
tic
band_begin = band(1);
band_end = band(2);

l = length(peak_array);

ind_in_binned_array = 0;

binned_peak_array = zeros(1,2); % for c

ind_p = 0;

for mz = band_begin : window : band_end - window
    
    all_peaks_over_mass_array = find(peak_array(:,1) > mz);%&& peak_array(:,1) < mz +window);
    all_peaks_under_max_mass_array = find(peak_array(:,1) < mz + window);
    max_ind = max(all_peaks_under_max_mass_array);
    min_ind = min(all_peaks_over_mass_array);
    
    ind_in_binned_array = ind_in_binned_array + 1;
    
    if min_ind < max_ind
        binned_peak_array(ind_in_binned_array,2) = sum(peak_array(min_ind:max_ind,2));
        binned_peak_array(ind_in_binned_array,1) = mz;
    elseif min_ind == max_ind % if there is only one m/z that fit to the window in peak_array
        binned_peak_array(ind_in_binned_array,2) = peak_array(min_ind,2);
        binned_peak_array(ind_in_binned_array,1) = mz;
    else
        binned_peak_array(ind_in_binned_array,2) = 0;
        binned_peak_array(ind_in_binned_array,1) = mz;
    end 
toc
end
