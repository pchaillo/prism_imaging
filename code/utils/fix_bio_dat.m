function bio_dat = fix_bio_dat(bio_dat)
shape=size(bio_dat);
for i = 1 : shape(2)
    if isempty(bio_dat(i).peaks.mz)
        bio_dat(i).peaks.mz = [0. , 0];
    end 
end