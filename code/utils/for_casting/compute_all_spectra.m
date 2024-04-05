function all_peaks = compute_all_spectra(app, pixels_scans)

l = length(pixels_scans);

spectra_array_raw = [];

for i = 1 : l
    if pixels_scans(i).num > 0
        spectra_array_raw = [ spectra_array_raw ; pixels_scans(i).peaks.mz ];
    end
    X = sprintf('Spectra creation : %d / %d',i,l);
    disp(X)
   % update_log(app, X)
end

% tests => bon ca marche pas pour l'instant, mais y'a moyen de faire plus
% vite c'est sur
% spectra_array_raw2 =  [pixels_scans.peaks.mz]
% spectra_array_raw2 = arrayfun(@(x) x.peaks.mz, pixels_scans)
% spectra_array_raw2 = arrayfun(@(x) x.peaks.mz, pixels_scans, 'UniformOutput', false)
% spectra_array_raw3 = arrayfun(@(x) cat(1,x,pixels_scans.peaks.mz), pixels_scans)
% T = cell2table(spectra_array_raw3)

% Peaklist = mzxml2peaks_biodat(pixels_scans)

spectra_array = fusion_part_C(app, spectra_array_raw);

win = 0.1;

all_peaks = bining(spectra_array,win); % écriture du spectre global de la carte

