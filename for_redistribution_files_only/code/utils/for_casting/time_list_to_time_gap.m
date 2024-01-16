function time_gap_list = time_list_to_time_gap(times_list)

for i = 2 : length(times_list) 
    time_gap_list(i) = times_list(i) - times_list(i-1) ;
end