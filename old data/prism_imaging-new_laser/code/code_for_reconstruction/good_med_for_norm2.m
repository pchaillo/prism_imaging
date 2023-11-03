% détermine une médiane plus juste pour la normalisation (ne prend en compte que
% les totIonCurrent des peaks)

function good_med = good_med_for_norm2(bio_dat)

for i = 1 : length(bio_dat)
    num_tab(i) = bio_dat(i).num;
    ionisationEnergy_tab(i) = bio_dat(i).ionisationEnergy;
end

ind_peaks = find(num_tab>0);

% num_reel = num_tab(ind_peaks);

ionisationEnergy_peaks = ionisationEnergy_tab(ind_peaks);

old_med = median(ionisationEnergy_tab,'all');
good_med = median(ionisationEnergy_peaks,'all');