function Scan_time = extract_time(scans_group)

%% Récupération des informations
for i = 1: length(scans_group) % récupère les datas
    Scan_time(i) = scans_group(i).retentionTime;
end