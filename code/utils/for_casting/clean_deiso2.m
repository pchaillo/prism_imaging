function file2 = clean_deiso2(file)

file2 = file;

for i = 1 : length(file)
       file2(i).deisotoped = file(i).num; % Pour connaitre les indices des scans fusionnes par la suite
       file2(i).ionisationEnergy = file(i).totIonCurrent; % Pour quoi faire ? #TODO
end