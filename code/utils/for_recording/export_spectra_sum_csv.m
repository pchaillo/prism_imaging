function export_spectra_sum_csv(app, pixels_scans,name_mat)

peaks_array = compute_all_spectra(app, pixels_scans);

csv_filename = "files/csv files/" + name_mat(1:end-4) + "_spectra_sum.csv";

export_spectra_to_csv(peaks_array,csv_filename);
disp(csv_filename)
