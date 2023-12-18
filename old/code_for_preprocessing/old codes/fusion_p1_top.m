
function l_out = fusion_p1_top(l1,l2)

% fusion part 1
% met à la suite les infos pour permettre la fusion dans le preprocess

l_out = l1; % de base je fusionne sur le 1er point

%l_out.centroided = max(l1.totIonCurrent,l2.totIonCurrent) ;
%l_out.centroided = l2.totIonCurrent;
% l_out.totIonCurrent = (l1.totIonCurrent + l2.totIonCurrent) ;
%l_out.totIonCurrent = [ l1.totIonCurrent ; l2.totIonCurrent ] ;
%l_out.num = (l1.num + l2.num) / 2 + 0.1;
l_out.peaks.mz = [ l1.peaks.mz ; l2.peaks.mz ];

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