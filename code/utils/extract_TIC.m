function TIC_list = extract_TIC(scans_group)

%% Récupération des informations
for i = 1: length(scans_group) % récupère les datas
    TIC_list(i) = scans_group(i).totIonCurrent; % Mettre des noms de variables inspirés du paradigme mzXMLStruct ? #TODO
end