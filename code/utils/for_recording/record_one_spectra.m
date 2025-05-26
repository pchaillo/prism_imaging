function record_one_spectra(app, pixels_scans,map,name_map,limits,loud_flag)

[peaks_array,ind_x,ind_y] = extract_one_spectra(app, pixels_scans,map,limits,loud_flag);

csv_out_path = strrep(app.mat_path, "mat_files", "csv_files");

csv_filename = csv_out_path+name_map(1:end-4)+"_x_"+ind_x+"_y_"+ind_y+".csv";
export_spectra_to_csv(peaks_array,csv_filename);
disp(csv_filename)