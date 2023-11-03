function time = time_from_peaks3(mzXMLStruct,threshold_begin,min_threshold)

file_i = mzXMLStruct.scan ;

file = clean_time(file_i); % avec plot_peak2

ok = 0; %% trouve le 1er point pour supprimer les valuers nulles qui sont avant
i = 0;
while ok == 0
    i = i + 1;
    if file(i).totIonCurrent > threshold_begin
        ind_debut = i;
        ok = 1;
    end
end

for i = 1: length(file) % récupère les datas
    ion(i) = file(i).totIonCurrent;
    %     t_i_r = file(i).retentionTime;
    %     t_i(i) = raw_to_time(t_i_r);
    t_i(i) = file(i).retentionTime;
end

[pk loc w pw] = findpeaks(ion,t_i); %trouve les peaks et leurs localisation

for i = 2 : length(loc) % crée un tableau des ecarts temporels
    tab_loc(i) = loc(i) - loc(i-1) ;
end

for i = 1 : length(loc) % récupère les indices des peaks
    ind_peaks(i) = find( t_i == loc(i) );
end

tab(1,:) = ind_peaks; % mise des valeurs dans le tableau
tab(2,:) = loc;
tab(3,:) = tab_loc;
tab(4,:) = pk;

deb_sup = find(tab(1,:) == ind_debut); % supprime les points intuiles
tab(:,1:deb_sup-1) = [];

time = time_from_peaks_fcn(tab,min_threshold);
