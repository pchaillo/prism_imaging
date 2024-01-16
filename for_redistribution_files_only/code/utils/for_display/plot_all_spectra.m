function all_peaks = plot_all_spectra(pixels_scans,compute_flag,all_peaks, valmin, valmax)

% compute_flag : booleen qui détermine s'il faut recalculer un spectre
% global

if compute_flag == 0 
    all_peaks = compute_all_spectra(pixels_scans);
    compute_flag = 1; % useful ? #TODO
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

figure()
plot(parsed_all_peaks(:,1),parsed_all_peaks(:,2));
xlabel('Mass/Charge (M/Z)')
ylabel('Relative Intensity')