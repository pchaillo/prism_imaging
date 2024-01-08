% Réalise le groupement des données
% remet le tableau dans une forme finie définie par band, la bande de
% masses qui nous interesse et binding_step, la largeur de la fenetre de bining

% forme finie => comparable entre elles
% FORME NORMALISé

function bined_peak_array = bining_fixed_size(peak_array,binding_step,band)

band_begin = band(1);
band_end = band(2);

p = 0;

fixed_size = (band_end - band_begin)/binding_step ;

bined_peak_array = zeros(fixed_size,2);

% On crée la liste de base
for mz = band_begin : binding_step : band_end - binding_step
    p = p + 1;
    bined_peak_array(p,1) = mz;
end

si=size(peak_array);

for i = 1:si(1)
   % Determiner l'indice de bined_peak_array correspondant
   ind_in_bined_array=floor(peak_array(i,1)/binding_step)+1;
   % On vérifie que l'on est bien dans la plage de données autorisées
   if ind_in_bined_array < fixed_size
       % Associer la valeur
       bined_peak_array(ind_in_bined_array,2) = bined_peak_array(ind_in_bined_array,2) + peak_array(i,2);
   end
end
end
