function plot_chromatogram(mzXMLStruct)

file = mzXMLStruct.scan ;

file2 = clean_time(file);

for i = 1: length(file) % récupère les datas
    i
    ion(i) = file2(i).totIonCurrent;
    %     t_i_r = file(i).retentionTime;
    %     t_i(i) = raw_to_time(t_i_r);
    t_i(i) = file2(i).retentionTime;
end

plot(t_i,ion)

