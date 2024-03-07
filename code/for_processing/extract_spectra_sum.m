function extract_spectra_sum(app, pixels_scans,name_mat)

peaks_array = compute_all_spectra(app, pixels_scans);
%peaks_array = pixels_scans(selected_ind).peaks.mz;
% times = pixels_scans(ind_bio).retentionTime;
csv_filename = "files/csv files/"+name_mat(1:end-4)+"_spectra_sum.csv";

export_spectra_to_csv(peaks_array,csv_filename);
disp(csv_filename)

figure();
plot(peaks_array(:,1),peaks_array(:,2));
xlabel('Mass/Charge (M/Z)');
ylabel('Relative Intensity');
