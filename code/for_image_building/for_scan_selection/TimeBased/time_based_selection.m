% Permet de selectionner les valeurs à replacer sur la carte

% réalise la première moitié de la fusion des pics en deux lignes ( fusion_p1_top() )

% Meilleure vesrion => fusion des peaks proches et des données collatérales
% -> sensé fonctionner pour tous les spectres et toutes les fréquences
% d'échantillonage

% avec la detection du temps de reconstruction recommandé !

% avec mode trigerreint interne avec un flag en argument !

% avec le pourcentage de tolérance en argument !

function [pixels_scans, estimated_time_gap] = time_based_selection(mzXMLStruct,map_time,aspiration_time,neighbourgh_nb,aspiration_shift)

all_scans_raw = mzXMLStruct.scan ;

all_scans  = clean_time(all_scans_raw); % transformation du temps en une varibale numérique
all_scans  = clean_fusion_list(all_scans );

l = length(all_scans );

% VARIABLES  %
% time_res = 0.5 ;

TIC_list = extract_TIC(all_scans );
scan_time_list = extract_time(all_scans );

% map_time = map_time + aspiration_time;
map_time = apply_prog_aspiration(map_time,aspiration_time,aspiration_shift); % fonction experimentale

% disp(map_time)

topography_time_list = time_to_list(map_time);

% remplir ind_f_new
Final_selected_indices_list = corresponding_time(scan_time_list, topography_time_list); % Indentify intensities by temporal correlation

%% Pour fusionner le point suivant
% all_scans  = add_neighbourgh_scan(all_scans , Final_selected_indices_list);

all_scans = add_multiple_neighbourgh_scan(all_scans,Final_selected_indices_list,neighbourgh_nb);

%% Pour remettre les bonnes informations dans pixels_scans et pour afficher le chromatogramme avec les points

pixels_scans(:) = all_scans (Final_selected_indices_list);

plot_selection_on_chromatogram(pixels_scans, scan_time_list, TIC_list, topography_time_list,all_scans);

estimated_time_gap = 0;

