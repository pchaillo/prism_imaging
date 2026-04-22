% Réalise le groupement des données
% remet le tableau dans une forme finie définie par band, la bande de
% masses qui nous interesse et bining_step, la largeur de la fenetre de bining

% forme finie => comparable entre elles
% Normalizes the shape of the array

function binned_peak_array = binning_fixed_size(peak_array, binning_step, band)

band_begin = band(1);
band_end = band(2);

p = 0;

% Start the array from 0, as this helps with a later step. Values outside
% the target range will be culled later.
fixed_size = band_end/binning_step ;

binned_peak_array = zeros(fixed_size,2);

% Creates the base list
for mz = 0 : binning_step : band_end - binning_step
    p = p + 1;
    binned_peak_array(p,1) = mz;
end

% Remove values outside of the mass range
low_pass_delete = peak_array(:,1)<band_begin;
peak_array(low_pass_delete,:) = [];
high_pass_delete = peak_array(:,1)>band_end;
peak_array(high_pass_delete,:) = [];
si = size(peak_array);

for i = 1:si(1)
   % Determines the corresponding binned_peak_array index
   ind_in_binned_array=floor(peak_array(i,1)/binning_step)+1;
   
   % Assigns the value
   binned_peak_array(ind_in_binned_array,2) = binned_peak_array(ind_in_binned_array,2) + peak_array(i,2);
end

% Cull mz out of the target mass range
low_mz_delete = binned_peak_array(:,1)<band_begin;
binned_peak_array(low_mz_delete,:) = [];
end
