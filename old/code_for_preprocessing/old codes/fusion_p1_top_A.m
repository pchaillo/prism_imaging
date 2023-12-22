
 function l_out = fusion_part_A(l1,l2)
 
% Do only half of the fusion for perfomances => The spectra will be added
% only if the scan selection is good


l_out = l1; % de base je fusionne sur le 1er point

%l_out.peaks.mz = [ l1.peaks.mz ; l2.peaks.mz ];

l_out.deisotoped = [l1.deisotoped l2.deisotoped];

% je place le point sur le plus gros pic temporellement :
if l1.totIonCurrent > l2.totIonCurrent
    l_out.retentionTime = l1.retentionTime;
    l_out.totIonCurrent = l1.totIonCurrent;
    l_out.num = l1.num;
else
    l_out.retentionTime = l2.retentionTime;
    l_out.totIonCurrent = l2.totIonCurrent;
    l_out.num = l2.num;
end

l_out.msLevel = l1.msLevel + 1;