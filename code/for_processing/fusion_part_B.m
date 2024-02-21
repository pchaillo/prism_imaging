
function scan = fusion_part_B(scan_1,scan_2,fusion_list)
 
 % Second part of the fusion_partA function
scan = scan_1; % de base je fusionne sur le 1er point

scan.peaks.mz = [ scan_1.peaks.mz ; scan_2.peaks.mz ];

scan.deisotoped = fusion_list;

scan.ionisationEnergy = scan_1.ionisationEnergy + scan_2.ionisationEnergy ;

% je place le point sur le plus gros pic temporellement :
if scan_1.totIonCurrent > scan_2.totIonCurrent
    scan.retentionTime = scan_1.retentionTime;
    scan.totIonCurrent = scan_1.totIonCurrent;
    scan.num = scan_1.num;
    scan_2.centroided = -1; % Comment faire ca de maniere propre ?
else
    scan.retentionTime = scan_2.retentionTime;
    scan.totIonCurrent = scan_2.totIonCurrent;
    scan.num = scan_2.num;
    scan_1.centroided = -1;
end

% scan.msLevel = scan_1.msLevel + 1; % Sinon c'est fait en double ? =>
% Verifier #TODO