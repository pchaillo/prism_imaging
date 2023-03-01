
 function l_out = fusion_p1(l1,l2)
 
 % fusion part 1
 % met à la suite les infos pour permettre la fusion dans le preprocess

l_out = l2;

%l_out.centroided = max(l1.totIonCurrent,l2.totIonCurrent) ;
l_out.centroided = l2.totIonCurrent;
l_out.totIonCurrent = (l1.totIonCurrent + l2.totIonCurrent) ;
%l_out.totIonCurrent = [ l1.totIonCurrent ; l2.totIonCurrent ] ;
l_out.num = (l1.num + l2.num) / 2 + 0.1;
l_out.peaks.mz = [ l1.peaks.mz ; l2.peaks.mz ];
