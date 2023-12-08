
function l_out = fusion_part_B(l1,l2,deiso_tab)
 
 % Second part of the fusion_partA function


l_out = l1; % de base je fusionne sur le 1er point

l_out.peaks.mz = [ l1.peaks.mz ; l2.peaks.mz ];

l_out.deisotoped = deiso_tab;

l_out.ionisationEnergy = l1.ionisationEnergy + l2.ionisationEnergy ;

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