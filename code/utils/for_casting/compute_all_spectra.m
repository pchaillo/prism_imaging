function all_peaks = compute_all_spectra(app, pixels_scans)

l = length(pixels_scans);

spectra_tab_raw = [];

for i = 1 : l
    if pixels_scans(i).num > 0
        spectra_tab_raw = [ spectra_tab_raw ; pixels_scans(i).peaks.mz ];
    end
    X = sprintf('Spectra creation : %d / %d',i,l);
    update_log(app, X)
end

% tests => bon ca marche pas pour l'instant, mais y'a moyen de faire plus
% vite c'est sur
% spectra_tab_raw2 =  [pixels_scans.peaks.mz]
% spectra_tab_raw2 = arrayfun(@(x) x.peaks.mz, pixels_scans)
% spectra_tab_raw2 = arrayfun(@(x) x.peaks.mz, pixels_scans, 'UniformOutput', false)
% spectra_tab_raw3 = arrayfun(@(x) cat(1,x,pixels_scans.peaks.mz), pixels_scans)
% T = cell2table(spectra_tab_raw3)

% Peaklist = mzxml2peaks_biodat(pixels_scans)

spectra_tab = fusion_part_C(app, spectra_tab_raw);

win = 0.1;

all_peaks = bining(spectra_tab,win); % écriture du spectre global de la carte

