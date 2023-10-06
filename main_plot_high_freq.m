clc
% clear all
close all

path(path,'mzXML files')
path(path,'code/code_for_preprocessing')

nom = '08_09_2023_tir_freq_max_doigt_serie2_01';
nom_mzXML = strcat(nom,'.mzXML');
mzXMLStruct = mzxmlread(nom_mzXML);
bio_info = mzXMLStruct.scan;
l = length(bio_info);
% bio_dat = bio_info;
win = [100 1500];
disp(win)
bio_info = clean_time(bio_info)
for i = 1 : 1 : l
    i
    bio_dat(i) = preprocess6(bio_info(i),win);
end

selected_ind_tab = [1:175];

plot_multiple_spectra(bio_dat,selected_ind_tab)
