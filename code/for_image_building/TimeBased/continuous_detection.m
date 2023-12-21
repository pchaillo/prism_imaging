% Permet de selectionner les valeurs à replacer sur la carte

% réalise la première moitié de la fusion des pics en deux lignes ( fusion_p1_top() )

% Meilleure vesrion => fusion des peaks proches et des données collatérales
% -> sensé fonctionner pour tous les spectres et toutes les fréquences
% d'échantillonage

% avec la detection du temps de reconstruction recommandé !

% avec mode trigerreint interne avec un flag en argument !

% avec le pourcentage de tolérance en argument !

function [bio_dat, time, g] = continuous_detection(mzXMLStruct, carte_time, aspiration_time)

file_i = mzXMLStruct.scan ;

file = clean_time(file_i); % transformation du temps en une varibale numérique
file = clean_deiso2(file);

l = length(file);

% VARIABLES  %
time_res = 0.5 ;
% aspiration_time = 1.05; % remonter en argument de la fonction % 1 seconde pour recaler les referentiels + 0.35s aspiration time

%% Récupération des informations

for i = 1: length(file) % récupère les datas
    ion(i) = file(i).totIonCurrent;
    t_i(i) = file(i).retentionTime;
end

carte_time = carte_time + aspiration_time;

time_tab_map = time_in_tab(carte_time);

% remplir ind_f_new
ind_f_new = corresponding_time(t_i,time_tab_map);

%% Pour remettre les bonnes informations dans bio_dat et pour afficher le chromatogramme avec les points

%bio_dat(:) = file(ind_final);
bio_dat(:) = file(ind_f_new);

plot_peak_time(bio_dat,t_i,ion,time_tab_map);

g = 0;
time = 0;

