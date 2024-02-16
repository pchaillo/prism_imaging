function [alls_scans, data_array, filtered_selected_indices, fusionned_indices, deleted_indices ] = peak_fusion(data_array,fusion_percentage,alls_scans,t_step)

%% fusion of close peaks
tolerance_value = fusion_percentage/100;
to_fusion_ind =  find(data_array(3,:) < t_step*tolerance_value ); % Fusion indices in data_array
if (~isempty(to_fusion_ind))
    to_fusion_ind(1) = [] ; % Remove the first point, always null % suppression du 1er pt, tjrs nul
    for i = 1 : length(to_fusion_ind)
        to_fusion(i,1) = data_array(1,to_fusion_ind(i)-1) ;
        to_fusion(i,2) = data_array(1,to_fusion_ind(i)) ;
        TotIon_1 = data_array(4,to_fusion_ind(i)-1);
        TotIon_2 = data_array(4,to_fusion_ind(i));
        if TotIon_1 > TotIon_2 % We delete the scan with the lower TIC
            to_sup(i) = to_fusion_ind(i);
        else
            to_sup(i) = to_fusion_ind(i)-1 ;
        end
    end

    if exist('to_sup') % If there is no point to supress, it means there is no fusion to do !
        to_sup = unique(to_sup);
        for i = length(to_sup) : -1 : 1
            if to_sup(i) > length(data_array)
                %  to_sup(i) = [];
            else
                data_array(:,to_sup(i)) = [] ;
            end
        end
        % remplacer boucle for par data_array(:,to_sup) = []; ??? % #TODO
        size_to_fusion = size(to_fusion);
        for i = 1 : size_to_fusion(1)
            ind_f_m = to_fusion(i,1);
            ind_f_p = to_fusion(i,2);
            Tot_1 = alls_scans(ind_f_m).totIonCurrent;
            Tot_2 = alls_scans(ind_f_p).totIonCurrent;
            if Tot_1 > Tot_2
                alls_scans(ind_f_m) = fusion_part_A(alls_scans(ind_f_m),alls_scans(ind_f_p));
            else
                alls_scans(ind_f_p) = fusion_part_A(alls_scans(ind_f_m),alls_scans(ind_f_p));
            end
        end
    end

    fusion_ind = 0; % Fusion indices for scans_fusion_list
    for i = 1 : length(alls_scans)
        if alls_scans(i).msLevel > 1
            fusion_ind = fusion_ind + 1;
            scans_fusion_list(fusion_ind) = {alls_scans(i).deisotoped};
        end
    end
    to_delete_indices = [];
    if fusion_ind > 0
        processed_scans_fusion_list = deiso_fusion_reccur(scans_fusion_list);
        for i = 1 : length(processed_scans_fusion_list)
            clear fusion_list;
            clear Tot_Ion_list;
            fusion_list = processed_scans_fusion_list{1,i};
            for j = 1 : length(fusion_list)
                Tot_Ion_list(j) = alls_scans(fusion_list(j)).totIonCurrent ;
            end
            [M,ind_max] = max(Tot_Ion_list);
            max_TIC_scan_ind = fusion_list(ind_max); % indice in all_scans that have the maximal TIC between all the scans it will fusion
            fusion_list(ind_max) = []; % Suppresion of that indice in fusion_list, in order to not fusion it two times % suppression de l'indice du maximum du tableau des indices à fusionner
            for j = 1 : length(fusion_list)
                alls_scans(max_TIC_scan_ind) = fusion_part_B(alls_scans(fusion_list(j)),alls_scans(max_TIC_scan_ind),fusion_list);
            end
            to_delete_indices = [ to_delete_indices fusion_list ] ;
        end
    end
    % Cleaning % Nettoyage
    to_delete_indices = sort(to_delete_indices);
    filtered_selected_indices = data_array(1,:); % indices des peaks detectés
    
    [ind_communs i_a i_b ] = intersect(to_delete_indices,filtered_selected_indices);
    data_array(:,i_b) = []; % to delete in data_array all the scan that get fusionned
end

filtered_selected_indices = data_array(1,:); % indices des peaks detectés
si = size(data_array);
time_gap_list = time_list_to_time_gap(data_array(2,:));
data_array(3,:) = time_gap_list; % pour remettre les bons écarts dans data_array

fusionned_indices = to_fusion_ind;
deleted_indices = to_delete_indices;