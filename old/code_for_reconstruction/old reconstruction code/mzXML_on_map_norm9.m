% Permet de remettre les informations des pics d'ionisation dans la forme
% d'un tableau superposable aux tableau d'informations topographiques 
% Pour permettre l'affichage des informations biométriques sur la carte
% topographique

% indépendant du pattern, se base sur carte_time

function [ bio_ind, bio_map ] = mzXML_on_map_norm9(bio_dat,map,limits,carte_time)

%fonctionne pour toutes cartes
% using median

% for main_reconstruct

si = size(map);

%Extraction des données utiles
id = 0;
for i = 1:length(bio_dat)
    if bio_dat(i).num ~= 2 %to delete useless empty point
        id = id +1 ;
        totIonCurrent(id) = bio_dat(i).totIonCurrent ;
        value(id) = set_peaks_norm4( limits,bio_dat(i) )/totIonCurrent(id);
    end
end

med = median(totIonCurrent,'all'); %% be carefull change to median

carte_ind = time_to_indice(carte_time);

for i =  1  :  si(1)
    for j = 1 : si(2)
           bio_map(i,j)= value(carte_ind(i,j))*med;
    end
end

bio_ind = carte_ind ;

