function num_list = extract_num(scans_group)

%% Extract scan number from mass spectrometry data
for i = 1: length(scans_group) 
    num_list(i) = scans_group(i).num; 
end