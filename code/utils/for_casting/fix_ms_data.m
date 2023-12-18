function scans_group = fix_ms_data(scans_group)
shape=size(scans_group);
for i = 1 : shape(2)
    if isempty(scans_group(i).peaks.mz)
        scans_group(i).peaks.mz = [0. , 0];
    end 
end