function [alls_scans, data_tab, filtered_selected_indices, ind_fusion, ind_peaks_supp ] = peak_fusion(data_tab,fusion_percentage,alls_scans,t_step)

%% fusion of close peaks
tolerance_value = fusion_percentage/100;
ind_fusion =  find(data_tab(3,:) < t_step*tolerance_value ); % Fusion indices in data_tab
if (~isempty(ind_fusion))
    ind_fusion(1) = [] ; % supress 1st point, always null % suppression du 1er pt, tjrs nul
    for i = 1 : length(ind_fusion)
        to_fusion(i,1) = data_tab(1,ind_fusion(i)-1) ;
        to_fusion(i,2) = data_tab(1,ind_fusion(i)) ;
        TotIon_1 = data_tab(4,ind_fusion(i)-1);
        TotIon_2 = data_tab(4,ind_fusion(i));
        if TotIon_1 > TotIon_2 % We delete the scan with the lower TIC
            to_sup(i) = ind_fusion(i);
        else
            to_sup(i) = ind_fusion(i)-1 ;
        end
    end

    if exist('to_sup') % If there is no point to supress, it means there is no fusion to do !
        to_sup = unique(to_sup);
        for i = length(to_sup) : -1 : 1
            if to_sup(i) > length(data_tab)
                %  to_sup(i) = [];
            else
                data_tab(:,to_sup(i)) = [] ;
            end
        end
        % remplacer boucle for par data_tab(:,to_sup) = []; ??? % #TODO
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

    fusion_ind = 0; % Fusion indices for scans_fusion_tab
    for i = 1 : length(alls_scans)
        if alls_scans(i).msLevel > 1
            fusion_ind = fusion_ind + 1;
            scans_fusion_tab(fusion_ind) = {alls_scans(i).deisotoped};
        end
    end
    ind_peaks_supp = [];
    if fusion_ind > 0
        processed_scans_fusion_tab = deiso_fusion_reccur(scans_fusion_tab);
        for i = 1 : length(processed_scans_fusion_tab)
            clear tab_fusion;
            clear Tot_Ion_tab;
            tab_fusion = processed_scans_fusion_tab{1,i};
            for j = 1 : length(tab_fusion)
                Tot_Ion_tab(j) = alls_scans(tab_fusion(j)).totIonCurrent ;
            end
            [M,ind_max] = max(Tot_Ion_tab);
            max_TIC_scan_ind = tab_fusion(ind_max); % indice in all_scans that have the maximal TIC between all the scans it will fusion
            tab_fusion(ind_max) = []; % Suppresion of that indice in tab_fusion, in order to not fusion it two times % suppression de l'indice du maximum du tableau des indices à fusionner
            for j = 1 : length(tab_fusion)
                alls_scans(max_TIC_scan_ind) = fusion_part_B(alls_scans(tab_fusion(j)),alls_scans(max_TIC_scan_ind),tab_fusion);
            end
            ind_peaks_supp = [ ind_peaks_supp tab_fusion ] ;
        end
    end
    % Cleaning % Nettoyage
    ind_peaks_supp = sort(ind_peaks_supp);
    filtered_selected_indices = data_tab(1,:); % indices des peaks detectés
    
    [ind_communs i_a i_b ] = intersect(ind_peaks_supp,filtered_selected_indices);
    data_tab(:,i_b) = []; % to delete in data_tab all the scan that get fusionned
end

filtered_selected_indices = data_tab(1,:); % indices des peaks detectés
si = size(data_tab);
for i = 2 : si(2) % Compute again time gap, and replace the tab in data_tab variable % crée un deuxième tableau des ecarts temporels après toutes les correction qui ont été appliquées !
    time_gap_tab(i) = data_tab(2,i) - data_tab(2,i-1) ;
end
data_tab(3,:) = time_gap_tab; % pour remettre les bons écarts dans tab

