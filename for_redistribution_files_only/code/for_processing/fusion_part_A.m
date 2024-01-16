function scan = fusion_part_A(scan_1,scan_2)
 
% Do only half of the fusion for perfomances => The spectra will be added
% only if the scan selection is good, in the fusion_part_B function


scan = scan_1; % de base je fusionne sur le 1er point

% l_out.peaks.mz = [ l1.peaks.mz ; l2.peaks.mz ]; % Etape couteuse, faite dans fusion_part_B

scan.deisotoped = [scan_1.deisotoped scan_2.deisotoped];

% je place le point sur le plus gros pic temporellement :
if scan_1.totIonCurrent > scan_2.totIonCurrent
    scan.retentionTime = scan_1.retentionTime;
    scan.totIonCurrent = scan_1.totIonCurrent; 
    scan.num = scan_1.num;
else
    scan.retentionTime = scan_2.retentionTime;
    scan.totIonCurrent = scan_2.totIonCurrent;
    scan.num = scan_2.num;
end

scan.msLevel = scan_1.msLevel + 1; % msLevel = contain the number of additionated spectra in one scan