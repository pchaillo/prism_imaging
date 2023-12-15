% Permet de selectionner les valeurs à replacer sur la carte

% réalise la première moitié de la fusion des pics en deux lignes ( fusion_p1_top() )

% Meilleure vesrion => fusion des peaks proches et des données collatérales
% -> sensé fonctionner pour tous les spectres et toutes les fréquences
% d'échantillonage

% avec la detection du temps de reconstruction recommandé !

% avec mode trigerreint interne avec un flag en argument !

% avec le pourcentage de tolérance en argument !

function [pixels_scans, estimated_time_gap] = Peak_picking(mzXMLStruct, threshold_begin, t_step, noise_threshold, intern_flag, fusion_percentage, map_time)

% Indices = position in the list or in the arrat
% Nums = position in the raw mzXML file


all_scans_raw = mzXMLStruct.scan ;

alls_scans = clean_time(all_scans_raw); % Function that convert all the time value in retentionTime variable from char to double 
alls_scans = clean_fusion_list(alls_scans);
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

[TIC_list, Scan_time] = extract_TIC_and_time(alls_scans);

%% Matlab function peak detection
[selected_peaks, selected_times, w, pw] = findpeaks(TIC_list, Scan_time); % trouve les peaks et leurs localisation

time_gap_list = time_list_to_time_gap(selected_times);

for i = 1 : length(selected_times) % Get peaks index, relatively to time !
    selected_indices(i) = find( Scan_time == selected_times(i) );
end

data_array(1,:) = selected_indices; % old ind_peaks % mise des valeurs dans le tableau % utile ? rend le code moins clair ! #TODO
data_array(2,:) = selected_times; % old loc
data_array(3,:) = time_gap_list; % old tab_loc
data_array(4,:) = selected_peaks; % old pk

first_point_indice = find(data_array(1,:) == first_point_indice); % Suppress all points before the 1st one
data_array(:,1:first_point_indice-1) = [];

estimated_time_gap = time_from_peaks_fcn(data_array, noise_threshold);

%% Apply filtering using noise_threshold %% Application du filtrage min par threshold de bruit
noise_indices =  find(data_array(4,:) < noise_threshold ); % Supprimer ? #TODO
data_indices  =  data_array(4,:) > noise_threshold ;
filtered_data_array =  data_array(:,data_indices); 

psi = size(filtered_data_array);
if psi(2) == 0
    disp('----- Attention : too high minimum threshold, no peaks detected -------');
    %quit(1) #TODO => Que faire ici ? Bloquer programme, envoyer erreur ?? 
    return
end

filtered_time_gap_list = time_list_to_time_gap(filtered_data_array(2,:));
filtered_data_array(3,:) = filtered_time_gap_list;

%% Fusion of selected peaks that are too close to each other
[alls_scans, filtered_data_array, filtered_selected_indices, fusionned_indices, deleted_indices] = peak_fusion(filtered_data_array, fusion_percentage ,alls_scans, t_step);

[fusionned_TIC_list, fusionned_Scan_time] = extract_TIC_and_time(alls_scans);

%% Detection de la pente comme un peaks % #TODO
% ajouter dans la dernière version
% ajouter une condition pour savoir si il y a bien une pente
if intern_flag == 1
    filtered_selected_indices = [ 1 filtered_selected_indices];
end

%% Add points in empty space (like shooting on glass = no data) %% Ajout des points dans les espaces
point_to_add_indices =  fill_empty_parts(t_step, filtered_data_array, intern_flag, alls_scans, time_res, fusionned_Scan_time, first_point_indice);

%% Generation of the good indices %% Génération des bon indices
if exist('point_to_add_indices')
    for i = 1 : length(point_to_add_indices)
        alls_scans(point_to_add_indices(i)) = Set_scan_as_empty(alls_scans(point_to_add_indices(i)));
    end
    filtered_selected_indices = [ filtered_selected_indices point_to_add_indices];
end

[sorted_selected_indices, ordre ]= sort(filtered_selected_indices) ;% indices finaux des points à mettre dans pixels_scans
[uv,a,b] = unique(sorted_selected_indices);
if length(uv) ~= length(sorted_selected_indices)
    disp('Attention : points superposition, look at the biodat variable or at the mat file')
end

%% Usefull value for debug
% final_data_array(1,:) = sorted_selected_indices; % pour informations
% final_data_array(2,:) =  fusionned_Scan_time(sorted_selected_indices) ;
% final_time_gap_list = time_list_to_time_gap(final_data_array(2,:));
% final_data_array(3,:) = final_time_gap_list;
% final_data_array(4,:) = TIC_list(sorted_selected_indices) ;
% too_short = find(final_data_array(3,:) < t_step - t_step/3); % pas utilisé ailleurs => Supprimer #TODO ? Utile pour debug ?
% too_long = find(final_data_array(3,:) > t_step + t_step/5);

%% pour trouver les lignes vectrices d'informations non prises en compte et les fusionner au peak le plus proche
last_selected_point_indice = filtered_data_array(1,end);
alls_scans = collateral_fusion(alls_scans, first_point_indice, last_selected_point_indice, noise_threshold, filtered_selected_indices, fusionned_indices, t_step, deleted_indices);

%% Pour comparer le temps des points finaux avec les temps enregistrés lors de la cartographie
[Final_selected_indices_list,corrected_topography_time_list] = time_based_rectification(alls_scans,map_time,sorted_selected_indices,t_step,fusionned_Scan_time,aspiration_time);

%% Pour remettre les bonnes informations dans pixels_scans et pour afficher le chromatogramme avec les points

pixels_scans(:) = alls_scans(Final_selected_indices_list);
plot_peak_time(pixels_scans,Scan_time,TIC_list,corrected_topography_time_list); % Function that display the selected peaks on the chromatogram for visual checking
