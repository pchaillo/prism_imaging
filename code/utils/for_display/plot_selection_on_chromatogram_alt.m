function plot_selection_on_chromatogram_alt(t_i, ion, topography_time_list, merge_centrepoints, merged_points, filler_points, normal_points)
% Note: The new code probably does not integrate seemlessly with peak
% picking methods 
% Function that display the selected peaks on the chromatogram for visual checking, distinguishing the different type of scan selection with a diferent symbol

figure();
hold on
plot(t_i,ion)
ind_fus = 0; % ENG : Merged scans / FR : point fusionnés
ind_norm = 0; % Classically selected scan
ind_ad = 0; % Empty added scans to ensure good data positioning
ind_coll = 0; % ENG : Scan that contain merged data // FR : scans qui resultent d'une fusion "collatérale"

% Handle Merged Points
if ~isempty(merged_points)
    pk_fus = merged_points(:, 2); % TIC
    loc_fus = merged_points(:, 1); % Retention Time
end

% Handle filler points
% TODO: filler_points should be a list identical to merged_points in shape)
if ~isempty(filler_points)
    pk_ad = filler_points(:, 2);
    loc_ad = filler_points(:, 1);
end

% Handle center points of merges
if ~isempty(merge_centrepoints)
    pk_coll = merge_centrepoints(:, 2);
    loc_coll = merge_centrepoints(:, 1);
end

% Handle points that were selected without mergeing
% TODO: normal_points should be a list identical to merged_points in shape
if ~isempty(normal_points)
    pk_norm = merged_points(:, 2);
    loc_norm = merged_points(:, 1);
end

if topography_time_list ~= 0  % to plot the line between the selected scan and the time recorded during acquisition 
    time_lines_x = [loc_coll , topography_time_list']';
    time_lines_y = [pk_coll, pk_coll]';
    plot(time_lines_x, time_lines_y);
end 

if exist('loc_norm', 'var')
   s(1) = scatter(loc_norm,pk_norm,'*','red','DisplayName','Scan');
end
if exist('loc_coll', 'var')
    scatter(loc_coll, pk_coll, 'o', 'red');
end
if exist('loc_fus', 'var')
    scatter(loc_fus, pk_fus, '*', 'm');
end
if exist('loc_ad', 'var')
    scatter(loc_ad, pk_ad, 'd', 'b');
end

xlabel('Time (s)')
ylabel('TIC Intensity (A.U.)')
title('Selected scans on the chromatogram')

hold off
