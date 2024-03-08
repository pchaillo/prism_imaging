function plot_spectra(peaks_array)

figure();
plot(peaks_array(:,1),peaks_array(:,2));
xlabel('Mass/Charge (M/Z)');
ylabel('Relative Intensity');