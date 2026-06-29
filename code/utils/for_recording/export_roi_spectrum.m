function export_roi_spectrum(mat_path, roi_file)

load(mat_path);
total_scans = {pixels_scans(:).deisotoped};
disp("Mat file loaded")

roi = readmatrix(roi_file);
indices = roi(2:end,1);
disp("ROI file loaded")

scans = total_scans(indices);
scans = horzcat(scans{:});
writematrix(scans', strrep(roi_file, "_loc.", "_scans."));

disp("Done!")
end