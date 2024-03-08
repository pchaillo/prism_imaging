function display_spectra_sum(app, pixels_scans)

peaks_array = compute_all_spectra(app, pixels_scans);

plot_spectra(peaks_array)
title("Spectra Sum")
