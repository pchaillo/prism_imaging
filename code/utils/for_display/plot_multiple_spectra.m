function plot_multiple_spectra(peaks,times,h)

resolution = 10000;
figure()
[MZ,Y] = msppresample(peaks,resolution);
 plot3(repmat(MZ,1,h),repmat(times',resolution,1),Y) 
xlabel('Mass/Charge (M/Z)')
ylabel('Retention Time')
zlabel('Relative Intensity')
