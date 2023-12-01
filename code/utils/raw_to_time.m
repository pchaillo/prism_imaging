function time_double = raw_to_time(raw_string)
% function to convert the string in retentionTime variable to double

raw_char = convertStringsToChars(raw_string);

l = length(raw_char);

cropped_raw_char = raw_char(3:l-1);

time_double = str2double(cropped_raw_char);

