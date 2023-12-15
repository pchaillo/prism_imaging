% Permet de selectionner les valeurs à replacer sur la carte

% réalise la première moitié de la fusion des pics en deux lignes ( fusion_p1_top() )

% Meilleure vesrion => fusion des peaks proches et des données collatérales
% -> sensé fonctionner pour tous les spectres et toutes les fréquences
% d'échantillonage

% avec la detection du temps de reconstruction recommandé !

% avec mode trigerreint interne avec un flag en argument !

% avec le pourcentage de tolérance en argument !

function [pixels_scans, time] = continuous_detection(mzXMLStruct,carte_time)

path(path,'code/for_image_building/for_scan_selection/PeakPicking') % Ranger ca ou ? => Ici c'est bien non ? #TODO pour peak_fusion2 => mettre dans for_scan_slection direct ?

file_i = mzXMLStruct.scan ;

file = clean_time(file_i); % transformation du temps en une varibale numérique
file = clean_fusion_list(file);

l = length(file);

% VARIABLES  %
time_res = 0.5 ;
aspiration_time = 1.05; % remonter en argument de la fonction % 1 seconde pour recaler les referentiels + 0.35s aspiration time

TIC_list = extract_TIC(file);
scan_time_list = extract_time(file);

carte_time = carte_time + aspiration_time;

topography_time_list = time_to_list(carte_time);

% remplir ind_f_new
ind_f_new = corresponding_time(scan_time_list,topography_time_list); % Indentify intensities by temporal correlation

%% Pour fusionner le point suivant
file = add_neighbourgh_scan(file,ind_f_new);

%% Pour remettre les bonnes informations dans pixels_scans et pour afficher le chromatogramme avec les points

pixels_scans(:) = file(ind_f_new);

plot_peak_time(pixels_scans,scan_time_list,TIC_list,topography_time_list);

time = 0;

