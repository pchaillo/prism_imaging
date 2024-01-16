% Permet de selectionner les valeurs à replacer sur la carte

% réalise la première moitié de la fusion des pics en deux lignes ( fusion_p1_top() )

% Meilleure vesrion => fusion des peaks proches et des données collatérales
% -> sensé fonctionner pour tous les spectres et toutes les fréquences
% d'échantillonage

% avec la detection du temps de reconstruction recommandé !

% avec mode trigerreint interne avec un flag en argument !

% avec le pourcentage de tolérance en argument !

function [pixels_scans, estimated_time_gap] = time_based_selection(mzXMLStruct,carte_time,aspiration_time)

all_scans_raw = mzXMLStruct.scan ;

alls_scans = clean_time(all_scans_raw); % transformation du temps en une varibale numérique
alls_scans = clean_fusion_list(alls_scans);

l = length(alls_scans);

% VARIABLES  %
% time_res = 0.5 ;

TIC_list = extract_TIC(alls_scans);
scan_time_list = extract_time(alls_scans);

carte_time = carte_time + aspiration_time;

topography_time_list = time_to_list(carte_time);

% remplir ind_f_new
Final_selected_indices_list = corresponding_time(scan_time_list, topography_time_list); % Indentify intensities by temporal correlation

%% Pour fusionner le point suivant
alls_scans = add_neighbourgh_scan(alls_scans, Final_selected_indices_list);

%% Pour remettre les bonnes informations dans pixels_scans et pour afficher le chromatogramme avec les points

pixels_scans(:) = alls_scans(Final_selected_indices_list);

plot_peak_time(pixels_scans, scan_time_list, TIC_list, topography_time_list);

estimated_time_gap = 0;

