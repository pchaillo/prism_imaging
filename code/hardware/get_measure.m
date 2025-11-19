% For the ILD1750-20
function dist = get_measure(com) 
    flush(com);
    raw = read(com, 3, "uint8");
    bin = dec2bin(raw);
    bin = bin(:, 3:8); % Removes the two flag bits for each byte
    bin_final = strcat(bin(3,:), bin(2,:), bin(1,:));
    dist_out = bin2dec(bin_final);

    meas_range = 20; % in mm
    meas_start = 40; % in mm
    
    dist = (((dist_out - 98232) / 65536) * meas_range) + meas_start; % in mm
end
