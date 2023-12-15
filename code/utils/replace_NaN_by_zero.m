function pixels_mz = replace_NaN_by_zero(pixels_mz)
shape=size(pixels_mz);
for i = 1 : shape(1)
    for j = 1 : shape(2) 
        if isnan(pixels_mz(i, j))
            pixels_mz(i, j)=0;
        end
    end
end