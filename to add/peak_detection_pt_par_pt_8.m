% Permet de selectionner les valeurs à replacer sur la carte

% réalise la première moitié de la fusion des pics en deux lignes ( fusion_p1_top() )

% Meilleure vesrion => fusion des peaks proches et des données collatérales
% -> sensé fonctionner pour tous les spectres et toutes les fréquences
% d'échantillonage

% avec la detection du temps de reconstruction recommandé !

% avec mode trigerreint interne avec un flag en argument !

% avec le pourcentage de tolérance en argument !

function [bio_dat, time, g] = peak_detection_pt_par_pt_8(mzXMLStruct,threshold_begin,t_step,min_threshold,intern_flag,tolerance,carte_time)

file_i = mzXMLStruct.scan ;

file = clean_time(file_i); % transformation du temps en une varibale numérique
file = clean_deiso2(file);

l = length(file);

% VARIABLES  %
time_res = 0.5 ;
aspiration_time = 0.35;

%            %

%% Détection du premier pic

ok = 0; %% trouve le 1er point pour supprimer les valuers nulles qui sont avant
i = 0;
while ok == 0
    i = i + 1;
    if file(i).totIonCurrent > threshold_begin
        ind_debut = i;
        ok = 1;
    end
end

%% Récupération des informations

for i = 1: length(file) % récupère les datas
    ion(i) = file(i).totIonCurrent;
    t_i(i) = file(i).retentionTime;
end

%% Détection de peaks matlab
[pk loc w pw] = findpeaks(ion,t_i); %trouve les peaks et leurs localisation

for i = 2 : length(loc) % crée un tableau des ecarts temporels
    tab_loc(i) = loc(i) - loc(i-1) ;
end

for i = 1 : length(loc) % récupère les indices des peaks
    ind_peaks(i) = find( t_i == loc(i) );
end

tab(1,:) = ind_peaks; % mise des valeurs dans le tableau
tab(2,:) = loc;
tab(3,:) = tab_loc;
tab(4,:) = pk;

deb_sup = find(tab(1,:) == ind_debut); % supprime les points intuiles
tab(:,1:deb_sup-1) = [];

% tab_i = tab; % on enregistre le tableau initial avant suppression/ajout de points/retrait du bruit

time = time_from_peaks_fcn(tab,min_threshold);
%time = time_estimation;

%% Application du filtrage min par threshold de bruit

ind_bruit =  find(tab(4,:) < min_threshold );
ind_no_bruit =  find(tab(4,:) > min_threshold );
tab_bruit = tab(:,ind_bruit);
tab_no_bruit = tab(:,ind_no_bruit);
% tab_bruit(3,:) = tab_loc_2(ind_bruit);
% nb_diff_bruit = length(tab_bruit) - sum(tab_bruit(3,:) == tab(3,ind_bruit));
tab_peaks = tab_no_bruit;
ind_peaks2 = tab_peaks(1,:); % indices des peaks detectés

psi = size(tab_peaks);
if psi(2) == 0
    disp('----- Attention to high minimum threshold, no peaks detected -------');
    %quit(1)
    return
end

for i = 2 : length(tab_peaks) % crée un 3e tableau des ecarts temporels après toutes les correction qui ont été appliquées !
    tab_loc_3(i) = tab_peaks(2,i) - tab_peaks(2,i-1) ;
end
% nb_diff = length(tab) - sum(tab_loc_3 == tab(3,:));
tab_peaks(3,:) = tab_loc_3; % pour remettre les bons écarts dans tab

%% FUsion

[file, tab_peaks, ind_peaks2, ind_fusion, ind_peaks_supp] = peak_fusion2(tab_peaks,tolerance,file,t_step);

for i = 1 : length(file)
    file_time_tab(i) = file(i).retentionTime;
    file_peak_tab(i) = file(i).totIonCurrent;
end

%% Detection de la pente comme un peaks
% ajouter dans la dernière version
% ajouter une condition pour savoir si il y a bien une pente
if intern_flag == 1
    ind_peaks2 = [ 1 ind_peaks2];
end

%% Ajout des points dans les espaces
new_point_tab =  pt_add(t_step,tab_peaks,intern_flag,file,time_res,file_time_tab,ind_debut);


%% Génération des bon indices
if exist('new_point_tab')
    for i = 1 : length(new_point_tab)
        file(new_point_tab(i)) = to_add_pt(file(new_point_tab(i)));
    end
    ind_p3 = new_point_tab; % indices des points rajoutés pour combler les trous
    ind_final_raw= [ ind_peaks2 ind_p3];
else
    ind_final_raw = ind_peaks2;
end

[ind_final, ordre ]= sort(ind_final_raw) ;% indices finaux des points à mettre dans bio_dat
[uv,a,b] = unique(ind_final);
if length(uv) ~= length(ind_final)
    disp('Attention : points superposition, look at the biodat variable or at the mat file')
end

tab_final(1,:) = ind_final; % pour informations
tab_final(2,:) =    file_time_tab(ind_final) ;
for i = 2 : length(ind_final) % crée un tableau des ecarts temporels
    tab_loc_final(i) = tab_final(2,i) - tab_final(2,i-1) ;
end
tab_final(3,:) = tab_loc_final;
tab_final(4,:) =   file_peak_tab(ind_final) ;
trop_court = find(tab_final(3,:) < t_step - t_step/3);
trop_long = find(tab_final(3,:) > t_step + t_step/5);

%% pour trouver les lignes vectrices d'informations non prises en compte et les fusionner au peak le plus proche
%ind_deb = tab(1,1); % existe dejà, ind_debut
ind_fin = tab_peaks(1,end);

file = collateral_fusion2(file,ind_debut,ind_fin,min_threshold,ind_peaks2,ind_fusion,t_step,ind_peaks_supp);

%% Pour comparer le temps des points finaux avec les temps enregistrés lors de la cartographie

ind_f_new = ind_final;

% if carte_time ~= 0
si_time = size(carte_time);
if si_time(1) ~= 1
    
    map_time = time_in_tab(carte_time);
    time_tab_map = map_time + aspiration_time ;
    
    for i = 1 : length(ind_final)
        time_tab_final(i) = file(ind_final(i)).retentionTime;
    end
    
    if length( time_tab_final) < length( time_tab_map)
        disp('ATTENTION, coefficient de fusion trop important, moins des peaks detectés que de points sur la carte');
    end
    
    for i = 1 : length( time_tab_map)
        time_tab_diff(i) = time_tab_final(i) - time_tab_map(i);
    end
    
    for i = 1 : length(time_tab_diff)-1
        time_tab_espace(i) = time_tab_diff(i+1) - time_tab_diff(i);
    end
    
    ind_a = 0;
    for i = length(time_tab_espace) : -1 : 1 % suppression des points en trop
        if time_tab_espace(i) < - t_step*0.7
            if file(ind_f_new(i+1)).num < 0 % pour ne pas supprimer les lignes des peaks
                ind_f_new(i+1) = [];
            end
        elseif time_tab_espace(i) > t_step*0.7 % REMPLACER 0.7 PAR FUSION COEFF ???
            % i
            time01 = file(ind_f_new(i)).retentionTime;
            time02 = file(ind_f_new(i+1)).retentionTime;
            time_val_i = (time01 + time02)/2 ;
            time_ind = find_closest_pt_4(time_val_i,file_time_tab, t_step);
            ind_f_new = [ind_f_new time_ind];
            ind_f_new = sort(ind_f_new);
            
            ind_a = ind_a + 1 ;
            ind_add_tab(ind_a) = time_ind;
        end
    end
    
    % ind_f_new = reccur_time_recti(ind_f_new,file,time_tab_map,t_step);
    [ind_f_new, ind_add_tab_2] = reccur_time_recti_3(ind_f_new,file,time_tab_map,t_step,file_time_tab);
    
    if ind_a > 0 && length(ind_add_tab_2) > 1
        ind_add_tab_2(1) = []; % suppression du 0 ajouté pour pas que la variable soit cide si aucun point n'est ajouté
        ind_add_tab_final = unique([ind_add_tab ind_add_tab_2]);
        for i = 1 : length(ind_add_tab_final)
            file(ind_add_tab_final(i)) = to_add_pt(file(ind_add_tab_final(i)));
        end
    end
    
    for i = 1 : length(ind_f_new)
        time_tab_final_2(i) = file(ind_f_new(i)).retentionTime;
    end
    
    for i = 1 : length( time_tab_map)
        time_tab_diff_2(i) = time_tab_final_2(i) - time_tab_map(i);
    end
    
    debug = 0;
    
    ind_f_new = unique(ind_f_new);
    
    % Prendre le bon nombre de point pile pour la carte
    len = length(map_time);
    ind_f_new = ind_f_new(1:len);
else 
    time_tab_map = 0;
    
end

%% Pour remettre les bonnes informations dans bio_dat et pour afficher le chromatogramme avec les points

%bio_dat(:) = file(ind_final);
bio_dat(:) = file(ind_f_new);

plot_peak_time_2(bio_dat,t_i,ion,time_tab_map);

g = 0;

