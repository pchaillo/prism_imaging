% Réalise le groupement des données
% remet le tableau dans une forme finie définie par band, la bande de
% masses qui nous interesse et bining_step, la largeur de la fenetre de bining

% forme finie => comparable entre elles
% Normalizes the shape of the array

function binned_peak_array = bining_fixed_size(peak_array, binning_step, band)

band_begin = band(1);
band_end = band(2);

p = 0;

fixed_size = (band_end - band_begin)/binning_step ;

binned_peak_array = zeros(fixed_size,2);

% Creates the base list
for mz = band_begin : binning_step : band_end - binning_step
    p = p + 1;
    binned_peak_array(p,1) = mz;
end

si=size(peak_array);

for i = 1:si(1)
   % Determines the corresponding binned_peak_array index
   ind_in_bined_array=floor(peak_array(i,1)/binning_step)+1;
   % Checks whether we are in the allowed data range
   if ind_in_bined_array < fixed_size
       % Assigns the value
       binned_peak_array(ind_in_bined_array,2) = binned_peak_array(ind_in_bined_array,2) + peak_array(i,2);
   end
end
end
