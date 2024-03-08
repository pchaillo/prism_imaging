function display_one_spectra(app, pixels_scans,map,name_map,limits,loud_flag)

[peaks_array,ind_x,ind_y] = extract_one_spectra(app, pixels_scans,map,limits,loud_flag);

plot_spectra(peaks_array)
title(name_map(1:end-4)+" : x = "+ind_x+" ; y = "+ind_y);