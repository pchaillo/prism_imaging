function export_spectra_to_csv(peak_tab,csv_name)
cell = num2cell(peak_tab);
cell{1,1} = "m/z";
cell{1,2} = "intensity";
T = cell2table(cell);
writetable(T,csv_name)