% Réalise la suppression des valeurs nulles (qui sont totalement inutile)
% et réalise le groupement de données qu'elle renvoie dans le ligne
% bio_line_out

% Remet aussi les valeurs dans un tableau à deux colonnes

function processed_scan = preprocess(app, scan, win)

%avec code fusion de deux lignes
% avec fonction bining pour adaptation en C

raw_peaks_array = scan.peaks.mz;

if isempty(raw_peaks_array)
    peak_array = [0,0];
else
peak_array = reshape(raw_peaks_array, 2, []).'; % Much faster and cleaner
end

%fusion des lignes à fusionner

%%% Removes empty datapoints // Supprimme les valeurs nulles
peak_array(peak_array(:,2) == 0, :) = [];

%% Putting fused lines back where they should be // Remise en place des lignes qui fusionnent
peak_array = fusion_part_C(app, peak_array);

%% binning ? #TODO
% peak_tab3 = binning(peak_tab2,win);

processed_scan = scan;
processed_scan.peaks.mz = peak_array;


