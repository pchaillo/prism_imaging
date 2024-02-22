function file_out = clean_fusion_list(file)
% anciennement clean_deiso2

file_out = file;

for i = 1 : length(file)
       file_out(i).deisotoped = file(i).num; % Pour connaitre les indices des scans fusionnes par la suite
       file_out(i).ionisationEnergy = file(i).totIonCurrent; 
end