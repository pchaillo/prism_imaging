function export_spectra_to_csv(peaks_array,csv_name)
cell = num2cell(peaks_array);
cell{1,1} = "m/z";
cell{1,2} = "intensity";
T = cell2table(cell);
writetable(T,csv_name)