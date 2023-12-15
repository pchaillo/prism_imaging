
function plot_multiple_spectra(peaks,times,h)

resolution = 10000;
figure()
% plot3(peaks(:,1),times, peaks(:,2));
[MZ,Y] = msppresample(peaks,resolution);
% subplot(1,2,1); % pour mettre a coté de la carte
 plot3(repmat(MZ,1,h),repmat(times',resolution,1),Y) % a terminer, mais fonctionne bien
% PLOT A RESOUDRE
xlabel('Mass/Charge (M/Z)')
ylabel('Retention Time')
zlabel('Relative Intensity')
%subplot(1,2,2);  % pour mettre a coté de la carte