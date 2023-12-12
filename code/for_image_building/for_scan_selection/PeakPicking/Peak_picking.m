% Permet de selectionner les valeurs à replacer sur la carte

% réalise la première moitié de la fusion des pics en deux lignes ( fusion_p1_top() )

% Meilleure vesrion => fusion des peaks proches et des données collatérales
% -> sensé fonctionner pour tous les spectres et toutes les fréquences
% d'échantillonage

% avec la detection du temps de reconstruction recommandé !

% avec mode trigerreint interne avec un flag en argument !

% avec le pourcentage de tolérance en argument !

function [pixels_scans, estimated_time_gap] = Peak_picking(mzXMLStruct,threshold_begin,t_step,noise_threshold,intern_flag,fusion_percentage,carte_time)

% Function that peak the good scan in all_scan to create all_selected_scan #TODO : keep this name / paradigm ? 

all_scans_raw = mzXMLStruct.scan ;

alls_scans = clean_time(all_scans_raw); % Function that convert all the time value in retentionTime variable from char to double 
alls_scans = clean_deiso2(alls_scans);
% l = length(alls_scans);

% VARIABLES  %
time_res = 0.5 ; % Faire remonter en argument de la fonction ?
aspiration_time = 0.35;

%% First peak detection -> find the 1st peak if there is no time coherency (no mass spectrometer trigger) # utiliser variable pour ne le faire que si c'est nécessaire ? #TODO
first_peak_is_finded = 0; 
i = 0; % index
while first_peak_is_finded == 0
    i = i + 1;
    if alls_scans(i).totIonCurrent > threshold_begin
        first_point_indice = i;
        first_peak_is_finded = 1;
    end
end

[TIC_tab, Scan_time] = extract_TIC_and_time(alls_scans);

%% Matlab function peak detection
[selected_peaks, selected_times, w, pw] = findpeaks(TIC_tab,Scan_time); % trouve les peaks et leurs localisation

for i = 2 : length(selected_times) 
    time_gap_tab(i) = selected_times(i) - selected_times(i-1) ;
end

for i = 1 : length(selected_times) % Get peaks index, relatively to time !
    selected_indices(i) = find( Scan_time == selected_times(i) );
end

data_tab(1,:) = selected_indices; % old ind_peaks % mise des valeurs dans le tableau % utile ? rend le code moins clair ! #TODO
data_tab(2,:) = selected_times; % old loc
data_tab(3,:) = time_gap_tab; % old tab_loc
data_tab(4,:) = selected_peaks; % old pk

first_point_indice = find(data_tab(1,:) == first_point_indice); % Suppress all points before the 1st one
data_tab(:,1:first_point_indice-1) = [];

estimated_time_gap = time_from_peaks_fcn(data_tab,noise_threshold);

%% Apply filtering using noise_threshold %% Application du filtrage min par threshold de bruit
noise_indices =  find(data_tab(4,:) < noise_threshold ); % Supprimer ? #TODO
data_indices  =  find(data_tab(4,:) > noise_threshold );
filtered_data_tab =  data_tab(:,data_indices); 

psi = size(filtered_data_tab);
if psi(2) == 0
    disp('----- Attention : too high minimum threshold, no peaks detected -------');
    %quit(1) #TODO => Que faire ici ? Bloquer programme, envoyer erreur ?? 
    return
end

for i = 2 : length(filtered_data_tab) % Create a second time gap tab after filtering % crée un 3e tableau des ecarts temporels après toutes les correction qui ont été appliquées !
    filtered_time_gap_tab(i) = filtered_data_tab(2,i) - filtered_data_tab(2,i-1) ;
end
filtered_data_tab(3,:) = filtered_time_gap_tab;

%% Fusion of selected peaks that are too close to each other
[alls_scans, filtered_data_tab, filtered_selected_indices, fusionned_indices, deleted_indices] = peak_fusion(filtered_data_tab,fusion_percentage,alls_scans,t_step);

[fusionned_TIC_tab, fusionned_Scan_time] = extract_TIC_and_time(alls_scans);

%% Detection de la pente comme un peaks % #TODO
% ajouter dans la dernière version
% ajouter une condition pour savoir si il y a bien une pente
if intern_flag == 1
    filtered_selected_indices = [ 1 filtered_selected_indices];
end

%% Add points in empty space (like shooting on glass = no data) %% Ajout des points dans les espaces
point_to_add_indices =  fill_empty_parts(t_step,filtered_data_tab,intern_flag,alls_scans,time_res,fusionned_Scan_time,first_point_indice);

%% Generation of the good indices %% Génération des bon indices
if exist('point_to_add_indices')
    for i = 1 : length(point_to_add_indices)
        alls_scans(point_to_add_indices(i)) = Set_scan_as_empty(alls_scans(point_to_add_indices(i)));
    end
    filtered_selected_indices = [ filtered_selected_indices point_to_add_indices];
end

[ind_final, ordre ]= sort(filtered_selected_indices) ;% indices finaux des points à mettre dans pixels_scans
[uv,a,b] = unique(ind_final);
if length(uv) ~= length(ind_final)
    disp('Attention : points superposition, look at the biodat variable or at the mat file')
end

tab_final(1,:) = ind_final; % pour informations
tab_final(2,:) =  fusionned_Scan_time(ind_final) ;
for i = 2 : length(ind_final) % crée un tableau des ecarts temporels
    tab_loc_final(i) = tab_final(2,i) - tab_final(2,i-1) ;
end
tab_final(3,:) = tab_loc_final;
tab_final(4,:) = TIC_tab(ind_final) ;

% trop_court = find(tab_final(3,:) < t_step - t_step/3); % pas utilisé ailleurs => Supprimer #TODO ? Utile pour debug ?
% trop_long = find(tab_final(3,:) > t_step + t_step/5);

%% pour trouver les lignes vectrices d'informations non prises en compte et les fusionner au peak le plus proche
ind_fin = filtered_data_tab(1,end);
alls_scans = collateral_fusion2(alls_scans,first_point_indice,ind_fin,noise_threshold,filtered_selected_indices,fusionned_indices,t_step,deleted_indices);

%% Pour comparer le temps des points finaux avec les temps enregistrés lors de la cartographie
ind_f_new = ind_final;

% if carte_time ~= 0
si_time = size(carte_time);
if si_time(1) ~= 1
    
    map_time = time_to_indice(carte_time);
    time_tab_map = map_time + aspiration_time ;
    
    for i = 1 : length(ind_final)
        time_tab_final(i) = alls_scans(ind_final(i)).retentionTime;
    end
    
    if length( time_tab_final) < length( time_tab_map)
        disp('-------------------------------------------------------------------------------------------------e');
        disp('-------------------------------------------------------------------------------------------------e');
        disp('-------------------------------------------------------------------------------------------------e');
        disp('ATTENTION, coefficient de fusion trop important, moins des peaks detectés que de points sur la carte');
        disp('=> ajout de pt faux pour compenser');
        disp('ATTENTION, fusion coefficient too high, less detected peaks thans points/pixels on the image');
        disp('=> add empty points to compensate');
        disp('-------------------------------------------------------------------------------------------------e');
        disp('-------------------------------------------------------------------------------------------------e');
        disp('-------------------------------------------------------------------------------------------------e');
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
            if alls_scans(ind_f_new(i+1)).num < 0 % pour ne pas supprimer les lignes des peaks
                ind_f_new(i+1) = [];
            end
        elseif time_tab_espace(i) > t_step*0.7 % REMPLACER 0.7 PAR FUSION COEFF ???
            % i
            time01 = alls_scans(ind_f_new(i)).retentionTime;
            time02 = alls_scans(ind_f_new(i+1)).retentionTime;
            time_val_i = (time01 + time02)/2 ;
            time_ind = find_closest_point(time_val_i,fusionned_Scan_time, t_step);
            ind_f_new = [ind_f_new time_ind];
            ind_f_new = sort(ind_f_new);
            
            ind_a = ind_a + 1 ;
            ind_add_tab(ind_a) = time_ind;
        end
    end
    
    [ind_f_new, ind_add_tab_2] = reccur_time_recti_3(ind_f_new,alls_scans,time_tab_map,t_step,fusionned_Scan_time);
    
    if ind_a > 0 && length(ind_add_tab_2) > 1
        ind_add_tab_2(1) = []; % suppression du 0 ajouté pour pas que la variable soit cide si aucun point n'est ajouté
        ind_add_tab_final = unique([ind_add_tab ind_add_tab_2]);
        for i = 1 : length(ind_add_tab_final)
            alls_scans(ind_add_tab_final(i)) = to_add_pt(alls_scans(ind_add_tab_final(i)));
        end
    end
    
    for i = 1 : length(ind_f_new)
        time_tab_final_2(i) = alls_scans(ind_f_new(i)).retentionTime;
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

%% Pour remettre les bonnes informations dans pixels_scans et pour afficher le chromatogramme avec les points

pixels_scans(:) = alls_scans(ind_f_new);
plot_peak_time(pixels_scans,Scan_time,TIC_tab,time_tab_map); % Function that display the selected peaks on the chromatogram for visual checking
