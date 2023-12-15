% Permet de remettre les informations des pics d'ionisation dans la forme
% d'un tableau superposable aux tableau d'informations topographiques
% Pour permettre l'affichage des informations biométriques sur la carte
% topographique

% indépendant du pattern, se base sur map_time

% avec une médiane plus juste pour la normalisation (ne prend en compte que
% les totIonCurrent des peaks) + totIonCurrent additionné pour avoir une
% valeur plus juste

% ne crée pas de valeur pour les points ajoutés

function [ pixels_ind, scans_ind, pixels_mz, fusion_tab] = data_on_map(pixels_scans,map,limits,map_time,time_flag,loud_flag)
% anciennement mzXML_on_map17.m
% scans_ind (bio_num) => indices in the full mzXML file
% pixels_ind (bio_ind) => indices of the relative pixel in the image

si = size(map);

if isempty(pixels_scans(1).ionisationEnergy) % pour pouvoir utiliser les vieux mat files
    for i = 1:length(pixels_scans)
        pixels_scans(i).ionisationEnergy = pixels_scans(i).totIonCurrent;
    end
end

%Extraction des données utiles
id = 0;
for i = 1:length(pixels_scans)
   % if pixels_scans(i).num ~= 2 %to delete useless empty point
        id = id +1 ;
        ionisationEnergy(id) = pixels_scans(i).ionisationEnergy ;
        if loud_flag == 0
            if pixels_scans(i).num > 0
                value(id) = peak_selection( limits,pixels_scans(i) )/ionisationEnergy(id);
            else
                value(id) = 0;
            end
        else
            if ionisationEnergy(id) == 0
                value(id) = 0;
            else
                
                value(id) = peak_selection( limits,pixels_scans(i) )/ionisationEnergy(id);
            end
        end
  %  end
end

% med = median(totIonCurrent,'all'); %% be carefull change to median
med = get_median(pixels_scans);

% si le temps est enregistré, on l'utilise pour replacer les informations
% sur la carte
if time_flag == 1
    
    carte_ind = time_to_indice(map_time);
    
    d_ind = 0    ;
    
    for i =  1  :  si(1)
        for j = 1 : si(2)
            d_ind = d_ind + 1;
            pixels_mz(i,j)= value(carte_ind(i,j))*med;
            %             scans_ind(i,j) = pixels_scans.num(carte_ind(i,j));
            scans_ind(i,j) = pixels_scans(carte_ind(i,j)).num;
            fusion_tab(d_ind) = {pixels_scans(carte_ind(i,j)).deisotoped};
        end
    end
    
    pixels_ind = carte_ind ;
    
    % sinon on suit le pattern classique
else
    v = 0;
    k = 0;
    for i =  1  :  si(1)
        v = v + 1;
        if ( mod(v,2) ~= 0 )
            u = 0;
            for j = 1 : si(2)
                u = u +1;
                k = k+1;
                pixels_ind(v,u) = k;
                scans_ind(v,u) = pixels_scans(k).num;
                d_ind = d_ind + 1;
                fusion_tab(d_ind) = {pixels_scans(k).deisotoped};
                k
                if ionisationEnergy(k) ~= 0
                    pixels_mz(v,u)= value(k)*med;
                else
                    pixels_mz(v,u) = 0;
                end
            end
        else
            u = si(2)+1;
            for j = si(2) : -1  : 1
                u = u - 1;
                k = k+1;
                pixels_ind(v,u) = k;
                scans_ind(v,u) = pixels_scans(k).num;
                d_ind = d_ind + 1;
                fusion_tab(d_ind) = {pixels_scans(k).deisotoped};
                if ionisationEnergy(k) ~= 0
                    pixels_mz(v,u)= value(k)*med;
                else
                    pixels_mz(v,u) = 0;
                end
            end
        end
    end
    
end

