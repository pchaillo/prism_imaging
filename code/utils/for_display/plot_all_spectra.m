function all_peaks = plot_all_spectra(app, pixels_scans, compute_flag, all_peaks, valmin, valmax)

% ENG : compute_flag is a boolean to check if there is a need to recompute a spectral sum

if compute_flag == 0 
    all_peaks = compute_all_spectra(app, pixels_scans);
    % compute_flag = 1; % Useless since we use the fact that the name is
    % identical several times in a row
end

parsed_all_peaks = zeros(length(all_peaks), 2);
for i = 1:length(all_peaks)
    if all_peaks(i) >= valmin && all_peaks(i) <= valmax
        parsed_all_peaks(i, :) = all_peaks(i, :);
    end
end

for i = length(parsed_all_peaks):-1:1
    if parsed_all_peaks(i) == 0
        parsed_all_peaks(i, :) = [];
    end
end

plot_spectra(parsed_all_peaks)
