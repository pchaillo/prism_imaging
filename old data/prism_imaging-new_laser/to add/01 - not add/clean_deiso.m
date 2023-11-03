function file2 = clean_deiso(file)

file2 = file;

for i = 1 : length(file)
       file2(i).deisotoped = file(i).num;
end