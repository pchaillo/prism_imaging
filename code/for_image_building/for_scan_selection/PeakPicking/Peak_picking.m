% Selects the values that will be placed onto the map
% Does the first hald of the peaks' fusion in two lines (fusion_p1_top())

% Best version => Fusion of neighbouring peaks and collateral data
% -> Should work for all spectra and sampling frequencies

% Reconstruction time detection is recommanded 
% Triggereint with a flag as argument 
% Tolerance percentage as an argument


function [pixels_scans, estimated_time_gap] = Peak_picking(app, mzXMLStruct, threshold_begin, t_step, noise_threshold, intern_flag, fusion_percentage, map_time)

% Indices = position in the list or in the array
% Nums = position in the raw mzXML file


all_scans_raw = mzXMLStruct.scan ;
all_scans = clean_time(all_scans_raw); % Function that convert all the time value in retentionTime variable from char to double 
all_scans = clean_fusion_list(all_scans);

% VARIABLES  %
time_res = 0.5 ; % Faire remonter en argument de la fonction ?
aspiration_time = 0.35; % This probably should be set in the GUI instead

TIC_list = extract_TIC(all_scans);
Scan_time_list = extract_time(all_scans);

[data_array,first_point_indice] = create_data_array_from_peak_detection(all_scans,threshold_begin,TIC_list,Scan_time_list);

estimated_time_gap = time_estimation(data_array, noise_threshold);

%% Apply filtering using noise_threshold %% Application du filtrage min par threshold de bruit
noise_indices =  find(data_array(4,:) < noise_threshold ); % Supprimer ? #TODO
data_indices  =  data_array(4,:) > noise_threshold ;
filtered_data_array =  data_array(:,data_indices); 

psi = size(filtered_data_array);
if psi(2) == 0
    update_log(app, '----- Warning: Minimum threshold is too high. No peaks detected. -------');
    %quit(1) #TODO => Que faire ici ? Bloquer programme, envoyer erreur ??     
    return
end

filtered_time_gap_list = time_list_to_time_gap(filtered_data_array(2,:));
filtered_data_array(3,:) = filtered_time_gap_list;

%% Fusion of selected peaks that are too close to each other
[all_scans, filtered_data_array, filtered_selected_indices, fusionned_indices, deleted_indices] = peak_fusion(filtered_data_array, fusion_percentage ,all_scans, t_step);

fusionned_Scan_time = extract_time(all_scans);

%% Slope detection like a peak % #TODO
% ajouter dans la dernière version
% ajouter une condition pour savoir si il y a bien une pente
if intern_flag == 1
    filtered_selected_indices = [ 1 filtered_selected_indices];
end

%% Add points in empty space (like shooting on glass = no data) %% Ajout des points dans les espaces
point_to_add_indices =  fill_empty_parts(app, t_step, filtered_data_array, intern_flag, all_scans, time_res, fusionned_Scan_time, first_point_indice);

%% Generation of the good indices %% Génération des bon indices
if exist('point_to_add_indices')
    for i = 1 : length(point_to_add_indices)
        all_scans(point_to_add_indices(i)) = Set_scan_as_empty(all_scans(point_to_add_indices(i)));
    end
    filtered_selected_indices = [ filtered_selected_indices point_to_add_indices];
end

[sorted_selected_indices, ordre]= sort(filtered_selected_indices) ;% indices finaux des points à mettre dans pixels_scans
[uv,a,b] = unique(sorted_selected_indices);
if length(uv) ~= length(sorted_selected_indices)
    update_log(app, 'Warning: Points are overlapping. Please investigate the all_peaks variable or the mat file.')
end

%% Usefull value for debug
% final_data_array(1,:) = sorted_selected_indices; % pour informations
% final_data_array(2,:) =  fusionned_Scan_time(sorted_selected_indices) ;
% final_time_gap_list = time_list_to_time_gap(final_data_array(2,:));
% final_data_array(3,:) = final_time_gap_list;
% final_data_array(4,:) = TIC_list(sorted_selected_indices) ;
% too_short = find(final_data_array(3,:) < t_step - t_step/3); % pas utilisé ailleurs => Supprimer #TODO ? Utile pour debug ?
% too_long = find(final_data_array(3,:) > t_step + t_step/5); %TOCHOOSE

%% pour trouver les lignes vectrices d'informations non prises en compte et les fusionner au peak le plus proche
last_selected_point_indice = filtered_data_array(1,end);
all_scans = collateral_fusion(app, all_scans, first_point_indice, last_selected_point_indice, noise_threshold, filtered_selected_indices, fusionned_indices, t_step, deleted_indices);

%% Pour comparer le temps des points finaux avec les temps enregistrés lors de la cartographie
[Final_selected_indices_list,corrected_topography_time_list] = time_based_rectification(app, all_scans,map_time,sorted_selected_indices,t_step,fusionned_Scan_time,aspiration_time);

%% Pour remettre les bonnes informations dans pixels_scans et pour afficher le chromatogramme avec les points

pixels_scans(:) = all_scans(Final_selected_indices_list);
plot_selection_on_chromatogram(pixels_scans,Scan_time_list,TIC_list,corrected_topography_time_list,all_scans); % Function that display the selected peaks on the chromatogram for visual checking
