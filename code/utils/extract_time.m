function Scan_time = extract_time(scans_group)

%% Extract time of each scan from mass spectrometry data
for i = 1: length(scans_group) 
    Scan_time(i) = scans_group(i).retentionTime;
end