function [indices,corrected_topography_time_list] = time_based_rectification(app, alls_scans,map_time,indices,t_step,scan_time_list,aspiration_time)

si_time = size(map_time);
if si_time(1) ~= 1
    
    topography_time_list = time_to_list(map_time);
    corrected_topography_time_list = topography_time_list + aspiration_time ;
    
    for i = 1 : length(indices)
        spectrometry_selected_times_list(i) = alls_scans(indices(i)).retentionTime;
    end
    
    if length( spectrometry_selected_times_list) < length(corrected_topography_time_list)
        update_log(app, '-------------------------------------------------------------------------------------------------e');
        update_log(app, '-------------------------------------------------------------------------------------------------e');
        update_log(app, '-------------------------------------------------------------------------------------------------e');
        update_log(app, 'ATTENTION, coefficient de fusion trop important, moins des peaks detectés que de points sur la carte');
        update_log(app, '=> ajout de pt faux pour compenser');
        update_log(app, 'ATTENTION, fusion coefficient too high, less detected peaks thans points/pixels on the image');
        update_log(app, '=> add empty points to compensate');
        update_log(app, '-------------------------------------------------------------------------------------------------e');
        update_log(app, '-------------------------------------------------------------------------------------------------e');
        update_log(app, '-------------------------------------------------------------------------------------------------e');
    end
    
    for i = 1 : length( corrected_topography_time_list)
        topo_spectro_time_shift_list(i) = spectrometry_selected_times_list(i) - corrected_topography_time_list(i);
    end
    
    topo_spectro_time_shift_gap_list = time_list_to_time_gap(topo_spectro_time_shift_list);
    topo_spectro_time_shift_gap_list(1) = []; % supress the first value to get the good indices

    ind_a = 0;
    for i = length(topo_spectro_time_shift_gap_list) : -1 : 1 % suppression des points en trop
        if topo_spectro_time_shift_gap_list(i) < - t_step*0.7
            if alls_scans(indices(i+1)).num < 0 % pour ne pas supprimer les lignes des peaks
                indices(i+1) = [];
            end
        elseif topo_spectro_time_shift_gap_list(i) > t_step*0.7 % REMPLACER 0.7 PAR FUSION COEFF ???
            % i
            time01 = alls_scans(indices(i)).retentionTime;
            time02 = alls_scans(indices(i+1)).retentionTime;
            time_val_i = (time01 + time02)/2 ;
            time_ind = find_closest_point(time_val_i,scan_time_list, t_step);
            indices = [indices time_ind];
            indices = sort(indices);
            
            ind_a = ind_a + 1 ;
            ind_add_array(ind_a) = time_ind;
        end
    end
    
    [indices, all_ind_in_timelist] = time_based_reccursive_indices_rectification(indices, alls_scans, corrected_topography_time_list, t_step, scan_time_list);
    % new_indices_selection, all_ind_in_timelist

    if ind_a > 0 && length(all_ind_in_timelist) > 1
        all_ind_in_timelist(1) = []; % suppression du 0 ajouté pour pas que la variable soit vide si aucun point n'est ajouté
        ind_add_array_final = unique([ind_add_array all_ind_in_timelist]);
        for i = 1 : length(ind_add_array_final)
            alls_scans(ind_add_array_final(i)) = to_add_pt(alls_scans(ind_add_array_final(i)));
        end
    end
    
    for i = 1 : length(indices) %utile ? #TODO
        time_tab_final_2(i) = alls_scans(indices(i)).retentionTime;
    end
    
    for i = 1 : length( corrected_topography_time_list)
        time_tab_diff_2(i) = time_tab_final_2(i) - corrected_topography_time_list(i);
    end
    
    debug = 0;
    
    indices = unique(indices);
    
    % Prendre le bon nombre de point pile pour la carte
    number_of_point_on_map = length(topography_time_list);
    indices = indices(1:number_of_point_on_map);
else 
    corrected_topography_time_list = 0;
end