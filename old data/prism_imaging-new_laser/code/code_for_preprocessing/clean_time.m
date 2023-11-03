function file2 = clean_time(file)

file2 = file;

for i = 1 : length(file)
    time_raw = file(i).retentionTime;
    time = raw_to_time(time_raw);
    file2(i).retentionTime= time;
end