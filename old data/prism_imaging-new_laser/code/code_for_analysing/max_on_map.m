% Permet de remettre les informations des pics d'ionisation dans la forme
% d'un tableau superposable aux tableau d'informations topographiques 
% Pour permettre l'affichage des informations biométriques sur la carte
% topographique

function [ max_ind, max_map ] = max_on_map(bio_dat,map,seuil,limits)

%fonctionne pour toutes cartes
% using median

% for main_reconstruct

si = size(map);

%Extraction des données utiles
id = 0;
for i = 1:length(bio_dat)
    if bio_dat(i).num ~= 2 %to delete useless empty point
        id = id +1 ;
        value(id) = set_max( bio_dat(i),limits );
    end
end

v = 0;
k = 0;
for i =  1  :  si(1)
    v = v + 1;
    % if mod(u,freq) == 0
    if ( mod(v,2) ~= 0 ) %
        u = 0;
        for j = 1 : si(2)
            u = u +1;
            if map(v,u) > seuil
                k = k+1;
                max_ind(v,u) = k;
                %    bio_map(v,u) = bio_dat(k).totIonCurrent;
%                 if totIonCurrent(k) ~= 0
                    max_map(v,u)= value(k);
%                 else
%                     max_map(v,u) = 0;
%                 end
            else
                max_map(v,u) = 0;
            end
        end
    else
        %    u = ( objet.dim-1)/(scan.pas/scan.pre) +2;
        u = si(2)+1;
        for j = si(2) : -1  : 1
            u = u - 1;
            if map(v,u) > seuil
                k = k+1;
                max_ind(v,u) = k;
                %    max_map(v,u) = max_dat(k).totIonCurrent;
%                if totIonCurrent(k) ~= 0
                    max_map(v,u)= value(k);
%                 else
%                     max_map(v,u) = 0;
%                 end
            else
                max_map(v,u) = 0;
            end
        end
    end
    % end
end

k