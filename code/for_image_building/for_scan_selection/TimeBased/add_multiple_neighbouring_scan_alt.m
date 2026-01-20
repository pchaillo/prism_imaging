function [trimmed_scans, merged_points_ids] = add_multiple_neighbouring_scan_alt(all_scans, selected_indices, neighbour_nb, l, trimmed_scans)

% Experimental alternative that performs fusion directly instead of waiting
% for preprocessing, in a manner that hopefully gains time

merged_points_ids = zeros(1, length(selected_indices) *  neighbour_nb * 2)'; % This list exclusively retains the indices of points that are merged onto selected points
current_idx = 1;

for idx = 1:length(selected_indices)
    local_indices = selected_indices(idx) - neighbour_nb: selected_indices(idx) + neighbour_nb;
    local_indices = local_indices(local_indices>0);
    local_indices = local_indices(local_indices<(l+1));
    local_merged_indices = local_indices(local_indices ~= selected_indices(idx));
    merged_points_ids(current_idx: current_idx + length(local_merged_indices) -  1) = local_merged_indices;
    current_idx = current_idx + length(local_merged_indices);
    clear local_merged_indices
    
    
    trimmed_scans(idx).deisotoped = local_indices; % TODO: Move those indices to a bespoke column instead of repurposing
    trimmed_scans(idx).totIonCurrent = sum([all_scans(local_indices).totIonCurrent]); 
    
    mz_list = [all_scans(local_indices).peaks];
    mz = {mz_list.mz};
    mz = vertcat(mz{:});
    clear mz_list
    mz_merged = reshape(mz, 2, []).';
    mz_merged(mz_merged(:,2) == 0, :) = []; % Removes empty datapoints
    % Data fusion
    [unique_mz, ~, groups] = unique(mz_merged(:,1), "stable");
    intensity_sum = accumarray(groups, mz_merged(:,2));
    trimmed_scans(idx).peaks.mz = [unique_mz, intensity_sum];
end

merged_points_ids = unique(merged_points_ids(merged_points_ids ~= 0));
