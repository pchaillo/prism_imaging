% For the ILD1750-20
function dist = get_measure(com) 
    flush(com);
    raw = read(com, 5, "uint8"); % Reads 5 bytes to ensure that a full measurement (Three bytes) will always be contained
    bin_raw = dec2bin(raw);
    idx = find(strcmp(bin_raw(:,1:2), "00"), 1, "first");

    bin = bin_raw(idx:idx+2, 3:8); % Removes the two flag bits for each byte
    bin_final = strcat(bin(3,:), bin(2,:), bin(1,:));
    
    if bin_final == "111111111110111100"
        dist = "Error: Out of range";
        return
    end

    dist_out = bin2dec(bin_final);

    meas_range = 20; % in mm
    meas_start = 40; % in mm
    
    dist = (((dist_out - 98232) / 65536) * meas_range) + meas_start; % In mm
end
