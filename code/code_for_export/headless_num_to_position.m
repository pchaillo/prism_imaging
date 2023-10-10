function num_order_table = num_to_position()

pixels_number = length(bio_dat);

dimX = dim(2);

num_order = zeros(1, pixels_number);
countdown = dimX;
for position = 1:pixels_number
    quotient = round(floor(position-1/dimX));
    if mod(quotient, 2) == 0
        num_order(position) = bio_dat(position).num;
    else
        disp(countdown)
        num_order(position) = bio_dat(position + countdown - 1).num;
        countdown = countdown - 2;
        if countdown == -dimX
            countdown = dimX;
        end
    end
end

num_rank = 1:pixels_number;
num_order_table = [num_rank; num_order];

end