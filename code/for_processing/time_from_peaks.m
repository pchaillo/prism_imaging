function estimated_time = time_from_peaks(mzXMLStruct,threshold_begin,noise_threshold)

all_peaks_raw = mzXMLStruct.scan ;
all_peaks = clean_time(all_peaks_raw); % avec plot_peak2

TIC_list = extract_TIC(alls_scans);
Scan_time_list = extract_time(alls_scans);

[data_array,first_point_indice] = create_data_array_from_peak_detection(all_peaks,threshold_begin,TIC_list,Scan_time_list)

estimated_time = time_estimation(data_array,noise_threshold);
