function estimated_time = time_from_peaks(app, mzXMLStruct,threshold_begin,noise_threshold)

all_scans_raw = mzXMLStruct.scan ;
alls_scans = clean_time(all_scans_raw); % avec plot_peak2

TIC_list = extract_TIC(alls_scans);
Scan_time_list = extract_time(alls_scans);

[data_array,first_point_index] = create_data_array_from_peak_detection(alls_scans,threshold_begin,TIC_list,Scan_time_list);
update_log(app, string([data_array, first_point_index]))

estimated_time = time_estimation(data_array,noise_threshold);
