% Réalise la suppression des valeurs nulles (qui sont totalement inutile)
% et réalise le groupement de données qu'elle renvoie dans le ligne
% bio_line_out

% Remet aussi les valeurs dans un tableau à deux colonnes

function processed_scan = preprocess(scan,win)

%avec code fusion de deux lignes
% avec fonction bining pour adaptation en C

%choix de fenêtre pour bin
%win = 0.05;

peak_tab_r = scan.peaks.mz;
l = length(peak_tab_r);

h = 0; % remise du tableau dans la bonne forme ( lx1 par (l/2)x2 )
for i = 1 : l
    if ( mod(i,2) == 0 )
        peak_tab(h,2) = peak_tab_r(i);
    else
        h = h + 1;
        peak_tab(h,1) = peak_tab_r(i);
    end
end

%fusion des lignes à fusionner

%%% Supress all the empty data // Supprimme les valeurs nulles
e_tab = find(peak_tab(:,2) == 0);
peak_tab(e_tab,:) = [];

%% Remise en place des lignes qui fusionnent
peak_tab = fusion_part_C(peak_tab);

%% bining ? #TODO
% peak_tab3 = bining(peak_tab2,win);

processed_scan = scan;
processed_scan.peaks.mz = peak_tab;

%pause()

