% Réalise la suppression des valeurs nulles (qui sont totalement inutile)
% et réalise le groupement de données qu'elle renvoie dans le ligne
% bio_line_out

% Remet aussi les valeurs dans un tableau à deux colonnes

function processed_scan = preprocess(app, scan, win)

%avec code fusion de deux lignes
% avec fonction bining pour adaptation en C

%choix de fenêtre pour bin
%win = 0.05;

raw_peaks_array = scan.peaks.mz;
l = length(raw_peaks_array);

h = 0; % remise du tableau dans la bonne forme ( lx1 par (l/2)x2 )
for i = 1 : l
    if ( mod(i,2) == 0 )
        peak_array(h,2) = raw_peaks_array(i);
    else
        h = h + 1;
        peak_array(h,1) = raw_peaks_array(i);
    end
end

%fusion des lignes à fusionner

%%% Supress all the empty data // Supprimme les valeurs nulles
ind_to_supp = find(peak_array(:,2) == 0);
peak_array(ind_to_supp,:) = [];

%% Remise en place des lignes qui fusionnent
peak_array = fusion_part_C(app, peak_array);

%% bining ? #TODO
% peak_tab3 = bining(peak_tab2,win);

processed_scan = scan;
processed_scan.peaks.mz = peak_array;


