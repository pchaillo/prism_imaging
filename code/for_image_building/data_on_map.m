% Permet de remettre les informations des pics d'ionisation dans la forme
% d'un tableau superposable aux tableau d'informations topographiques
% Pour permettre l'affichage des informations biométriques sur la carte
% topographique

% indépendant du pattern, se base sur map_time

% avec une médiane plus juste pour la normalisation (ne prend en compte que
% les totIonCurrent des peaks) + totIonCurrent additionné pour avoir une
% valeur plus juste

% ne crée pas de valeur pour les points ajoutés

function [ pixels_ind, scans_ind, pixels_mz, fusion_list] = data_on_map(pixels_scans,map,limits,map_time,time_flag,loud_flag)
% anciennement mzXML_on_map17.m
% scans_ind (bio_num) => indices in the full mzXML file
% pixels_ind (bio_ind) => indices of the relative pixel in the image

map_dimension = size(map.x);

if isempty(pixels_scans(1).ionisationEnergy) % pour pouvoir utiliser les vieux mat files
    for i = 1:length(pixels_scans)
        pixels_scans(i).ionisationEnergy = pixels_scans(i).totIonCurrent;
    end
end

%Extraction des données utiles
id = 0;
for i = 1:length(pixels_scans)
   % if pixels_scans(i).num ~= 2 %to delete useless empty point
        id = id +1 ; % id equal to i ? #TODO
        ionisationEnergy(id) = pixels_scans(i).ionisationEnergy ;
        if loud_flag == 0
            if pixels_scans(i).num > 0
                intensity_list(id) = intensity_selection( limits,pixels_scans(i) )/ionisationEnergy(id);
            else
                intensity_list(id) = 0;
            end
        else
            if ionisationEnergy(id) == 0
                intensity_list(id) = 0;
            else
                
                intensity_list(id) = intensity_selection( limits,pixels_scans(i) )/ionisationEnergy(id);
            end
        end
  %  end
end

% med = median(totIonCurrent,'all'); %% be carefull change to median
med = get_median(pixels_scans);

% si le temps est enregistré, on l'utilise pour replacer les informations
% sur la carte
if time_flag == 1
    
    map_indices_array = time_to_indice(map_time);
    
    fusion_list_ind = 0    ;
    
    for x_ind =  1  :  map_dimension(1)
        for y_ind = 1 : map_dimension(2)
            fusion_list_ind = fusion_list_ind + 1;
            pixels_mz(x_ind,y_ind)= intensity_list(map_indices_array(x_ind,y_ind))*med;
            %             scans_ind(i,j) = pixels_scans.num(map_indices_array(i,j));
            scans_ind(x_ind,y_ind) = pixels_scans(map_indices_array(x_ind,y_ind)).num;
            fusion_list(fusion_list_ind) = {pixels_scans(map_indices_array(x_ind,y_ind)).deisotoped};
        end
    end
    
    pixels_ind = map_indices_array ;
    
    % sinon on suit le pattern classique
else
    x_ind = 0;
    scan_ind = 0;
    for i =  1  :  map_dimension(1)
        x_ind = x_ind + 1;
        if ( mod(x_ind,2) ~= 0 )
            y_ind = 0;
            for j = 1 : map_dimension(2)
                y_ind = y_ind +1;
                scan_ind = scan_ind+1;
                pixels_ind(x_ind,y_ind) = scan_ind;
                scans_ind(x_ind,y_ind) = pixels_scans(scan_ind).num;
                fusion_list_ind = fusion_list_ind + 1;
                fusion_list(fusion_list_ind) = {pixels_scans(scan_ind).deisotoped};
                update_log(app, app.info_log, scan_ind)
                if ionisationEnergy(scan_ind) ~= 0
                    pixels_mz(x_ind,y_ind)= intensity_list(scan_ind)*med;
                else
                    pixels_mz(x_ind,y_ind) = 0;
                end
            end
        else
            y_ind = map_dimension(2)+1;
            for j = map_dimension(2) : -1  : 1
                y_ind = y_ind - 1;
                scan_ind = scan_ind+1;
                pixels_ind(x_ind,y_ind) = scan_ind;
                scans_ind(x_ind,y_ind) = pixels_scans(scan_ind).num;
                fusion_list_ind = fusion_list_ind + 1;
                fusion_list(fusion_list_ind) = {pixels_scans(scan_ind).deisotoped};
                if ionisationEnergy(scan_ind) ~= 0
                    pixels_mz(x_ind,y_ind)= intensity_list(scan_ind)*med;
                else
                    pixels_mz(x_ind,y_ind) = 0;
                end
            end
        end
    end
    
end

