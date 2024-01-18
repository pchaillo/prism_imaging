function alls_scans = collateral_fusion(app, alls_scans, first_point_indice, last_selected_point_indice, noise_threshold, selected_indices, fusion_indices, t_step, deleted_indices )
%% all the scans that need to be fusionned are added in deisotoped variable in mxXML matlab format #TODO

selected_scans = alls_scans(first_point_indice:last_selected_point_indice);

selected_scans_TIC = extract_TIC(selected_scans);
selected_scans_num = extract_num(selected_scans);

under_noise_indices =  find(selected_scans_TIC < noise_threshold );
over_noise_indices =  find(selected_scans_TIC > noise_threshold );
% under_noise_num = selected_scans_num(under_noise_indices);
over_noise_nums = selected_scans_num(over_noise_indices); % à comparer avec les peaks pour ajouter les infos !
% comparer avec selected_indices;

over_noise_mask = ismember(over_noise_nums ,selected_indices);

under_noise_mask = ~ over_noise_mask;
selected_over_noise_inds = over_noise_nums(under_noise_mask); % indices de toutes les lignes au dessus du threshold minimum de bruit

if (~isempty(fusion_indices))
    [common_indices aa to_supp_ind ] = intersect(deleted_indices, selected_over_noise_inds); % delete all the already fusionned scans % retrait de toutes les lignes déjà fusionnées
    selected_over_noise_inds(to_supp_ind)=[];
end

for i = 1 : length(selected_indices)
    selected_time_list(i) = alls_scans(selected_indices(i)).retentionTime;
end

ind = 0;
for i = 1 : length(selected_over_noise_inds)
    if selected_over_noise_inds(i) < 0
        update_log(app, 'Warning: Collateral information found in the points assigned between peaks.');
    else
        ind = ind + 1;
        scan = alls_scans(selected_over_noise_inds(i));
        time = scan.retentionTime;  % Without recording times in a table
        indices_in_time_list(ind) = find_closest_point(time,selected_time_list,t_step);
        p_ind_tab(ind) = i;
    end
end

if ind > 0
    to_fusion_array(:,1) = selected_indices(indices_in_time_list);
    to_fusion_array(:,2) = selected_over_noise_inds(p_ind_tab) ;
        
    size_coll_fus = size(to_fusion_array);
    for i = 1 : size_coll_fus(1)
        mains_ind = to_fusion_array(i,1);
        collateral_fusion_ind = to_fusion_array(i,2);
        alls_scans(mains_ind) = fusion_part_A_and_B(alls_scans(mains_ind),alls_scans(collateral_fusion_ind));
    end
end
