function csv_spectra_recorder(peak_tab,csv_name)

si = size(peak_tab);

cell = num2cell(peak_tab');
cell{1,1} = "m/z";
cell{2,1} = "intensity";
T = cell2table(cell);
writetable(T,csv_name)