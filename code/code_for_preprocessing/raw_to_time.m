function time = raw_to_time(raw)

raw = convertStringsToChars(raw);

l = length(raw);

new_raw = raw(3:l-1);

time = str2double(new_raw);

