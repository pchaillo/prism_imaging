function clean_time_file = clean_time(file)
% Function that convert all the time value in retentionTime variable from char to double 

clean_time_file = file; % #performance ? #TODO + meilleur nom de variable

for i = 1 : length(file)
    time_raw = file(i).retentionTime;
    time = raw_to_time(time_raw);
    clean_time_file(i).retentionTime= time;
end