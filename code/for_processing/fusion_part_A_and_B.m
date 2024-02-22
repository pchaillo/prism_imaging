function scan = fusion_part_A_and_B(scan_1,scan_2)
 
% Do part A and B of the fusion in the same time

scan = scan_1; % de base je fusionne sur le 1er point

scan.deisotoped = [scan_1.deisotoped scan_2.deisotoped];

% je place le point sur le plus gros pic temporellement :
if scan_1.ionisationEnergy > scan_2.ionisationEnergy
    scan.retentionTime = scan_1.retentionTime;
    scan.ionisationEnergy = scan_1.ionisationEnergy; 
    scan.num = scan_1.num;
    scan_2.centroided = -1;
else
    scan.retentionTime = scan_2.retentionTime;
    scan.ionisationEnergy = scan_2.ionisationEnergy;
    scan.num = scan_2.num;
    scan_1.centroided = -1;
end

scan.peaks.mz = [ scan_1.peaks.mz ; scan_2.peaks.mz ];

scan.totIonCurrent = scan_1.totIonCurrent + scan_2.totIonCurrent ;

scan.msLevel = scan_1.msLevel + 1; % msLevel = contain the number of additionated spectra in one scan
