function all_peaks = plot_all_spectra(bio_dat,compute_flag,all_peaks)

% compute_flag : booleen qui détermine s'il faut recalculer un spectre
% global

if compute_flag == 0 
    all_peaks = compute_all_spectra(bio_dat);
    compute_flag = 1;
end

figure()
plot(all_peaks(:,1),all_peaks(:,2));
xlabel('Mass/Charge (M/Z)')
ylabel('Relative Intensity')