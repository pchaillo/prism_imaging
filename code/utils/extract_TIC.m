function TIC_list = extract_TIC(scans_group)

%% Extract TIC (Total Ion Current) from mass spectrometry data
for i = 1: length(scans_group) 
    TIC_list(i) = scans_group(i).totIonCurrent; 
end