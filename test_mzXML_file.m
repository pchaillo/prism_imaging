nom = '2021_15_09_m_b';
nom_mzXML = strcat(nom,'.mzXML');
mzXMLStruct = mzxmlread(nom_mzXML);
figure()

% plot_chromatogram(mzXML.Struct)

file = mzXMLStruct.scan ;

file2 = file;

for i = 1 : length(file)
    time_raw = file(i).retentionTime
    time = raw_to_time(time_raw);
    file2(i).retentionTime= time;
end

for i = 1: length(file) % récupère les datas
    ion(i) = file2(i).totIonCurrent;
    %     t_i_r = file(i).retentionTime;
    %     t_i(i) = raw_to_time(t_i_r);
    t_i(i) = file2(i).retentionTime;
end

plot(t_i,ion)