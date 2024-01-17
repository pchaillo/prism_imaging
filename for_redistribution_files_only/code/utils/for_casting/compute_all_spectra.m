function all_peaks = compute_all_spectra(bio_dat)

l = length(bio_dat);

spectra_tab_raw = [];

for i = 1 : l
    if bio_dat(i).num > 0
        spectra_tab_raw = [ spectra_tab_raw ; bio_dat(i).peaks.mz ];
    end
    X = sprintf('Spectra creation : %d / %d',i,l);
    update_log(app, log, X)
end

% tests => bon ca marche pas pour l'instant, mais y'a moyen de faire plus
% vite c'est sur
% spectra_tab_raw2 =  [bio_dat.peaks.mz]
% spectra_tab_raw2 = arrayfun(@(x) x.peaks.mz, bio_dat)
% spectra_tab_raw2 = arrayfun(@(x) x.peaks.mz, bio_dat, 'UniformOutput', false)
% spectra_tab_raw3 = arrayfun(@(x) cat(1,x,bio_dat.peaks.mz), bio_dat)
% T = cell2table(spectra_tab_raw3)

% Peaklist = mzxml2peaks_biodat(bio_dat)

spectra_tab = fusion_part_C(spectra_tab_raw);

win = 0.1;

all_peaks = bining(spectra_tab,win); % écriture du spectre global de la carte
