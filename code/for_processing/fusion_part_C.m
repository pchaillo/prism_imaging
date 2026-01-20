function fusioned_array = fusion_part_C(app, raw_array)

% This C step is compute-intensive, so it is performed during preprocessing only if
% the data will be used to reconstruct an image

% old name : fusion_part_2

% Fusion of all mass spectra: they were next to each other, it will be sorted again % fusionne toutes les infos de courant d'ionisation pour finir la fusion

[C,I] = sort(raw_array(:,1));

D = raw_array(I,2);

fusioned_array = [C(:), D(:)];

if any(diff(fusioned_array(:,1)) < 0) % Checking spectra fusion
    update_log(app, 'Warning: Peak fusion abnormality.');
end

end