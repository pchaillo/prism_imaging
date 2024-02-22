function [scan_1, scan_2] = fusion_part_A_and_B_output(scan_1,scan_2)
 
% Do part A and B of the fusion in the same time

scan_1.deisotoped = [scan_1.deisotoped scan_2.deisotoped];

scan_2.centroided = -1;

scan_1.peaks.mz = [ scan_1.peaks.mz ; scan_2.peaks.mz ];

scan_1.totIonCurrent = scan_1.totIonCurrent + scan_2.totIonCurrent ;

scan_1.msLevel = scan_1.msLevel + 1; % msLevel = contain the number of additionated spectra in one scan