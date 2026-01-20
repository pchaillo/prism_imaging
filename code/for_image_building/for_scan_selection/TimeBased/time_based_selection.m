% Selects the values that must be plotted on the chromatogram

% Performs the first part of peak fusion in two lines ( fusion_p1_top() )

% Meilleure vesrion => fusion des peaks proches et des données collatérales
% -> sensé fonctionner pour tous les spectres et toutes les fréquences
% d'échantillonage

% avec la detection du temps de reconstruction recommandé !

% avec mode trigerreint interne avec un flag en argument !

% avec le pourcentage de tolérance en argument !

function [pixels_scans, estimated_time_gap] = time_based_selection(mzXMLStruct, map_time, aspiration_time, neighbour_nb, aspiration_shift)

all_scans_raw = mzXMLStruct.scan ;

all_scans  = clean_time(all_scans_raw); % Transforms time into a numerical variable

clear all_scans_raw

all_scans  = clean_fusion_list(all_scans ); % TODO: Use a bespoke column instead of repurposing the deisotoping column for storage

l = length(all_scans);

TIC_list = extract_TIC(all_scans);
scan_time_list = extract_time(all_scans);

map_time = apply_prog_aspiration(map_time,aspiration_time,aspiration_shift); 

topography_time_list = time_to_list(map_time);

selected_indices = corresponding_time(scan_time_list, topography_time_list); % Identify intensities by temporal correlation

%% Aggregate the next point 
if neighbour_nb > 0
    %all_scans =
    %add_multiple_neighbouring_scan(all_scans,selected_indices,neighbour_nb);
    % Older method
    
    % Experimental alternative
    trimmed_scans(:) = all_scans(selected_indices);
    [pixels_scans, merged_points_id] = add_multiple_neighbouring_scan_alt(all_scans, selected_indices, neighbour_nb, l, trimmed_scans);
    merged_points = [scan_time_list(merged_points_id) ; TIC_list(merged_points_id)]';
    merge_centrepoints = [[pixels_scans(:).retentionTime] ; [pixels_scans(:).ionisationEnergy]]';
end

%% Pour remettre les bonnes informations dans pixels_scans et pour afficher le chromatogramme avec les points

%pixels_scans(:) = all_scans(selected_indices); % older method

plot_selection_on_chromatogram_alt(scan_time_list, TIC_list, topography_time_list, merge_centrepoints, merged_points, [], []);

estimated_time_gap = 0;

