function plot_chromatogram(mzXMLStruct)

all_scans = mzXMLStruct.scan ;
all_scans = clean_time(all_scans);

TIC_list = extract_TIC(all_scans);
Scan_time = extract_time(all_scans);

plot(Scan_time,TIC_list)
xlabel('Time (s)')
ylabel('TIC intensity')
title('Scan selection on chromatogram')
