function plot_all_spectra(bio_dat)

l = length(bio_dat);

spectra_tab_raw = [];

for i = 1 : length(bio_dat)
    if bio_dat(i).num > 0
        spectra_tab_raw = [ spectra_tab_raw ; bio_dat(i).peaks.mz ];
    end
    X = sprintf('Spectra creation : %d / %d',i,length(bio_dat));
    disp(X)
end

spectra_tab = fusion_part2(spectra_tab_raw);

win = 0.1;

peaks = bining(spectra_tab,win);

figure()
plot(peaks(:,1),peaks(:,2));
xlabel('Mass/Charge (M/Z)')
ylabel('Relative Intensity')