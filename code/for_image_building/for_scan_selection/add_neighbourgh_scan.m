function all_scans = add_neighbourgh_scan(all_scans,selected_indices)

% Function to add next scan fusion (to be sure to not miss any useful data

for i=1 : length(selected_indices)-1
    all_scans(selected_indices(i)) = fusion_part_A( all_scans(selected_indices(i)), all_scans(selected_indices(i+1)) );
end
