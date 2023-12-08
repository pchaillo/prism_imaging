function [TIC_tab, Scan_time] = extract_TIC_and_time(scans_group)

%% Récupération des informations
for i = 1: length(scans_group) % récupère les datas
    TIC_tab(i) = scans_group(i).totIonCurrent; % Mettre des noms de variables inspirés du paradigme mzXMLStruct ? #TODO
    Scan_time(i) = scans_group(i).retentionTime;
end