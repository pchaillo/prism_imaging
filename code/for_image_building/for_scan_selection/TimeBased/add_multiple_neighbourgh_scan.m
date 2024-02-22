function all_scans = add_multiple_neighbourgh_scan(all_scans, selected_indices, neighbourgh_nb)

% Function to add next scan fusion (To ensure all useful data is kept)

for i=1 : length(selected_indices)-1
    for n = 1 : neighbourgh_nb
        if selected_indices - n > 1
        [all_scans(selected_indices(i)), all_scans(selected_indices(i)+n)] = fusion_part_A_and_B_output( all_scans(selected_indices(i)), all_scans(selected_indices(i)+n));
        [all_scans(selected_indices(i)), all_scans(selected_indices(i)-n)] = fusion_part_A_and_B_output( all_scans(selected_indices(i)), all_scans(selected_indices(i)-n));
        end
    end
end
