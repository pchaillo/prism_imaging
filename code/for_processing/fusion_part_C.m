function fusioned_array = fusion_part_C(app, raw_array)

% This C step cost computing, so it's done during preprocessing, only if
% data will be used to reconstruct image

% old name : fusion_part_2

% Fusion of all the mass spectra : there were next to each other, it will be sorted again % fusionne toutes les infos de courant d'ionisation pour finir la fusion

[C,I] = sort(raw_array(:,1));

D = raw_array(I,2);

fusioned_array = [ C' ; D']';

si = size(fusioned_array);

for i = 1 : si(1)-1 % verification de la fusion des spectres
    if fusioned_array(i,1) > fusioned_array(i+1,1)
        update_log(app, 'Warning: Peak fusion abnormality.');
    end
end