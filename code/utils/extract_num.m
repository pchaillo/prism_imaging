function num_list = extract_num(scans_group)

%% Récupération des informations
for i = 1: length(scans_group) % récupère les datas
    num_list(i) = scans_group(i).num; % Mettre des noms de variables inspirés du paradigme mzXMLStruct ? #TODO
end