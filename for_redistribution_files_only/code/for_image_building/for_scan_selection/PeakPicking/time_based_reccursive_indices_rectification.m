function [new_indices_selection, all_ind_in_timelist ] = time_based_reccursive_indices_rectification(indices, alls_scans, time_list, t_step, scan_time_list)

% Fonction qui rajoute et retire des points en comparant les temps de
% cartographies et issues du fichier mzXML
% Function that can add or remove points by comparing mapping times with
% mzXML times

ok = 0; % Should be renamed

for i = 1 : length(indices)
    all_scans_time_list(i) = alls_scans(indices(i)).retentionTime;
end

for i = 1 : length( time_list)
    time_difference_list(i) = all_scans_time_list(i) - time_list(i);
    if time_difference_list(i) < - t_step*0.8
        if alls_scans(indices(i)).num < 0 % pour ne pas supprimer les lignes des peaks
            indices(i) = [];
            [new_indices_selection, all_ind_in_timelist] = time_based_reccursive_indices_rectification(indices, alls_scans, time_list, t_step, scan_time_list);
            ok = 1;
            break
        end
    elseif time_difference_list(i) >  t_step*1.2 % *1.5 ?
        time01 = alls_scans(indices(i-1)).retentionTime;
        time02 = alls_scans(indices(i)).retentionTime;
        time_val_i = (time01 + time02)/2 ;
        ind_in_timelist = find_closest_point(time_val_i,scan_time_list, t_step);
        indices = [indices ind_in_timelist];
        indices = sort(indices);
        [new_indices_selection, all_ind_in_timelist] = time_based_reccursive_indices_rectification(indices, alls_scans, time_list, t_step, scan_time_list);
        ok = 1;

        all_ind_in_timelist = [all_ind_in_timelist ind_in_timelist];
        break
        %         end
    end
end

if ok == 0
    new_indices_selection = indices;
    all_ind_in_timelist = 0;
end


