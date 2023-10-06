% Permet de remettre les informations des pics d'ionisation dans la forme
% d'un tableau superposable aux tableau d'informations topographiques
% Pour permettre l'affichage des informations biométriques sur la carte
% topographique

% indépendant du pattern, se base sur carte_time

% avec une médiane pkus juste pour la normalisation (ne prend en compte que
% les totIonCurrent des peaks) + totIonCurrent additionné pour avoir une
% valeur plus juste

% ne crée pas de valeur pour les points ajoutés

function [ bio_ind, bio_num, bio_map, deiso_tab] = mzXML_on_map_norm17(bio_dat,map,limits,carte_time,time_flag,loud_flag)


%fonctionne pour toutes cartes
% using median

% for main_reconstruct

si = size(map);

if isempty(bio_dat(1).ionisationEnergy) % pour pouvoir utiliser les vieux mat files
    for i = 1:length(bio_dat)
        bio_dat(i).ionisationEnergy = bio_dat(i).totIonCurrent;
    end
end

%Extraction des données utiles
id = 0;
for i = 1:length(bio_dat)
      if bio_dat(i).num ~= 2 %to delete useless empty point
         id = id +1 ;
         ionisationEnergy(id) = bio_dat(i).ionisationEnergy ;
        if loud_flag == 0
            if bio_dat(i).num > 0
                value(id) = set_peaks_norm4( limits,bio_dat(i) )/ionisationEnergy(id);
            else
                value(id) = 0;
            end
        else
            if ionisationEnergy(id) == 0
                value(id) = 0;
            else
                
                value(id) = set_peaks_norm4( limits,bio_dat(i) )/ionisationEnergy(id);
            end
        end
    end
end

%med = median(totIonCurrent,'all'); %% be carefull change to median
med = good_med_for_norm2(bio_dat);

% si le temps est enregistré, on l'utilise pour replacer les informations
% sur la carte
if time_flag == 1
    
    carte_ind = time_to_indice_3(carte_time);
    
    d_ind = 0    ;
    
    for i =  1  :  si(1)
        for j = 1 : si(2)
            d_ind = d_ind + 1;
            bio_map(i,j)= value(carte_ind(i,j))*med;
            %             bio_num(i,j) = bio_dat.num(carte_ind(i,j));
            bio_num(i,j) = bio_dat(carte_ind(i,j)).num;
            deiso_tab(d_ind) = {bio_dat(carte_ind(i,j)).deisotoped};
        end
    end
    
    bio_ind = carte_ind ;
    
    % sinon on suit le pattern classique
else
    v = 0;
    k = 0;
    for i =  1  :  si(1)
        v = v + 1;
        % if mod(u,freq) == 0
        if ( mod(v,2) ~= 0 ) % [ == ?]
            u = 0;
            for j = 1 : si(2)
                u = u +1;
                %     if map(v,u) > seuil
                k = k+1;
                bio_ind(v,u) = k;
                bio_num(v,u) = bio_dat(k).num;
                %    bio_map(v,u) = bio_dat(k).totIonCurrent;
                
                d_ind = d_ind + 1;% pareil que k ici ?
                deiso_tab(d_ind) = {bio_dat(k).deisotoped};
                
                k
                if ionisationEnergy(k) ~= 0
                    bio_map(v,u)= value(k)*med;
                else
                    bio_map(v,u) = 0;
                end
                %                 else
                %                     bio_map(v,u) = 0;
                %                 end
            end
        else
            %    u = ( objet.dim-1)/(scan.pas/scan.pre) +2;
            u = si(2)+1;
            for j = si(2) : -1  : 1
                u = u - 1;
                %                 if map(v,u) > seuil % à garder ????
                k = k+1;
                bio_ind(v,u) = k;
                bio_num(v,u) = bio_dat(k).num;
                
                d_ind = d_ind + 1; % pareil que k ici ?
                deiso_tab(d_ind) = {bio_dat(k).deisotoped};

                %    bio_map(v,u) = bio_dat(k).totIonCurrent;
                if ionisationEnergy(k) ~= 0
                    bio_map(v,u)= value(k)*med;
                else
                    bio_map(v,u) = 0;
                end
                %                 else
                %                     bio_map(v,u) = 0;
                %                 end
            end
        end
        % end
    end
    
end

