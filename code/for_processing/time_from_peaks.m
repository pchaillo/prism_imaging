function estimated_time = time_from_peaks(app, mzXMLStruct,threshold_begin,noise_threshold)

all_scans_raw = mzXMLStruct.scan ;
all_scans = clean_time(all_scans_raw); % avec plot_peak2

TIC_list = extract_TIC(all_scans);
Scan_time_list = extract_time(all_scans);

[data_array,first_point_index] = create_data_array_from_peak_detection(all_scans,threshold_begin,TIC_list,Scan_time_list);
update_log(app, string([data_array, first_point_index]))

estimated_time = time_estimation(data_array,noise_threshold);
