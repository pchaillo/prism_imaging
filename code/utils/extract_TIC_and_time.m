function [TIC_list, Scan_time] = extract_TIC_and_time(scans_group)

TIC_list = extract_TIC(scans_group);
Scan_time = extract_time(scans_group);

%% More efficient if you need both, but I choose to factorize (good choice ?) #TODO
% for i = 1: length(scans_group) % récupère les datas
%     TIC_list(i) = scans_group(i).totIonCurrent; % Mettre des noms de variables inspirés du paradigme mzXMLStruct ? #TODO
%     Scan_time(i) = scans_group(i).retentionTime;
% end