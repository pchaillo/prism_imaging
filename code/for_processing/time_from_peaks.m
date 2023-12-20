function estimated_time = time_from_peaks(mzXMLStruct,threshold_begin,noise_threshold)

all_peaks_raw = mzXMLStruct.scan ;
all_peaks = clean_time(all_peaks_raw); % avec plot_peak2

ok = 0; %% trouve le 1er point pour supprimer les valuers nulles qui sont avant
i = 0;
while ok == 0
    i = i + 1;
    if all_peaks(i).totIonCurrent > threshold_begin
        ind_debut = i;
        ok = 1;
    end
end

TIC_list = extract_TIC(all_peaks);
time_list = extract_time(all_peaks);

[pk loc w pw] = findpeaks( TIC_list, time_list); %trouve les peaks et leurs localisation

for i = 2 : length(loc) % crée un tableau des ecarts temporels
    tab_loc(i) = loc(i) - loc(i-1) ;
end

for i = 1 : length(loc) % récupère les indices des peaks
    ind_peaks(i) = find( time_list == loc(i) );
end

tab(1,:) = ind_peaks; % mise des valeurs dans le tableau
tab(2,:) = loc;
tab(3,:) = tab_loc;
tab(4,:) = pk;

deb_sup = find(tab(1,:) == ind_debut); % supprime les points intuiles
tab(:,1:deb_sup-1) = [];

estimated_time = time_estimation(tab,noise_threshold);
