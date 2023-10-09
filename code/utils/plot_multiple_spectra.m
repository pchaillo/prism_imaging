function plot_multiple_spectra(bio_dat,selected_ind_tab)
% works well

ind_peaks = 0;
for n = 1 : length(selected_ind_tab) % récupère les temps et les spectres associés aux indices
    ind_peaks = ind_peaks + 1 ;
    peaks(ind_peaks) = {bio_dat(selected_ind_tab(n)).peaks.mz};
    times(ind_peaks) = bio_dat(selected_ind_tab(n)).retentionTime;
end
peaks = peaks';
times = times';
resolution = 10000;
figure()
% plot3(peaks(:,1),times, peaks(:,2));
[MZ,Y] = msppresample(peaks,resolution);
h = length(selected_ind_tab);
% subplot(1,2,1); % pour mettre a coté de la carte
 plot3(repmat(MZ,1,h),repmat(times',resolution,1),Y) % a terminer, mais fonctionne bien
% PLOT A RESOUDRE
xlabel('Mass/Charge (M/Z)')
ylabel('Retention Time')
zlabel('Relative Intensity')
%subplot(1,2,2);  % pour mettre a coté de la carte