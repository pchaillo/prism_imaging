function tab_out2 = fusion_part_C(tab_in)

% This C step cost computing, so it's done during preprocessing, only if
% data will be used to reconstruct image

% old name : fusion_part_2

% Fusion of all the mass spectra : there were next to each other, it will be sorted again % fusionne toutes les infos de courant d'ionisation pour finir la fusion

[C,I] = sort(tab_in(:,1));

D = tab_in(I,2);

tab_out2 = [ C' ; D']';

si = size(tab_out2);

for i = 1 : si(1)-1 % verification de la fusion des spectres
    if tab_out2(i,1) > tab_out2(i+1,1)
        disp('attention pb de fusion');
    end
end