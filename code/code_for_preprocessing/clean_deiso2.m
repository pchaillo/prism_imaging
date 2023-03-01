function file2 = clean_deiso2(file)

file2 = file;

for i = 1 : length(file)
       file2(i).deisotoped = file(i).num;
       file2(i).ionisationEnergy = file(i).totIonCurrent;
end