function [file, tab_peaks, ind_peaks2, ind_fusion, ind_peaks_supp ] = peak_fusion2(tab_peaks,tolerance,file,t_step)

%% fusion des peaks trop proches
tolerance_value = tolerance/100;
%ind_fusion =  find(tab_peaks(3,:) < t_step/2.1 ); % (t_step - t_step/6) bonne valeur // ou t_step/3
ind_fusion =  find(tab_peaks(3,:) < t_step*tolerance_value );
if (~isempty(ind_fusion))
    ind_fusion(1) = [] ; % suppression du 1er pt, tjrs nul
    for i = 1 : length(ind_fusion)
        to_fusion(i,1) = tab_peaks(1,ind_fusion(i)-1) ;
        to_fusion(i,2) = tab_peaks(1,ind_fusion(i)) ;
        TotIon_1 = tab_peaks(4,ind_fusion(i)-1);
        TotIon_2 = tab_peaks(4,ind_fusion(i));
        if TotIon_1 > TotIon_2
            to_sup(i) = ind_fusion(i);
        else
            to_sup(i) = ind_fusion(i)-1 ;
        end
    end
    if exist('to_sup')
        to_sup = unique(to_sup);
        % to_fusion = tab(1,to_sup);
        for i = length(to_sup) : -1 : 1
            if to_sup(i) > length(tab_peaks)
                %  to_sup(i) = [];
            else
                tab_peaks(:,to_sup(i)) = [] ;
            end
        end
        % remplacer boucle for par tab_peaks(:,to_sup) = []; ???
        % end
        size_to_fusion = size(to_fusion);
        for i = 1 : size_to_fusion(1)
            %     ind_f = to_fusion(i);
            ind_f_m = to_fusion(i,1);
            ind_f_p = to_fusion(i,2);
            Tot_1 = file(ind_f_m).totIonCurrent;
            Tot_2 = file(ind_f_p).totIonCurrent;
            if Tot_1 > Tot_2
                file(ind_f_m) = fusion_p1_top_A(file(ind_f_m),file(ind_f_p));
            else
                file(ind_f_p) = fusion_p1_top_A(file(ind_f_m),file(ind_f_p));
            end
        end
    end
    deiso_ind = 0;
    for i = 1 : length(file)
        if file(i).msLevel > 1
            deiso_ind = deiso_ind + 1;
            deiso_tab(deiso_ind) = {file(i).deisotoped};
            %  deiso_tab_ind(deiso_ind) = i;
        end
    end
    ind_peaks_supp = [];
    if deiso_ind > 0
        indices_fusion = deiso_fusion_reccur(deiso_tab);
        for i = 1 : length(indices_fusion)
            clear tab_fusion;
            clear Tot_Ion_tab;
            tab_fusion = indices_fusion{1,i};
            for j = 1 : length(tab_fusion)
                Tot_Ion_tab(j) = file(tab_fusion(j)).totIonCurrent ;
            end
            [M,ind_max] = max(Tot_Ion_tab);
            line_ind_max = tab_fusion(ind_max);
            tab_fusion(ind_max) = []; % suppression de l'indice du maximum du tableau des indices à fusionner
            for j = 1 : length(tab_fusion)
                file(line_ind_max) = fusion_p1_top_B2(file(tab_fusion(j)),file(line_ind_max),tab_fusion);
            end
            ind_peaks_supp = [ ind_peaks_supp tab_fusion ] ;
        end
    end
    % Netoyage
    ind_peaks_supp = sort(ind_peaks_supp);
    ind_peaks2 = tab_peaks(1,:); % indices des peaks detectés
    
    [ind_communs i_a i_b ] = intersect(ind_peaks_supp,ind_peaks2);
    % for i = 1 : length(i_b)
    tab_peaks(:,i_b) = [];
    %     tab_peaks(:,i_b(i)) = [];
    % end
end

ind_peaks2 = tab_peaks(1,:); % indices des peaks detectés

si = size(tab_peaks);
for i = 2 : si(2) % crée un deuxième tableau des ecarts temporels après toutes les correction qui ont été appliquées !
    tab_loc_2(i) = tab_peaks(2,i) - tab_peaks(2,i-1) ;
end

% a quoi sert cette ligne ????
%nb_diff = length(tab) - sum(tab_loc_2 == tab_peaks(3,:));

tab_peaks(3,:) = tab_loc_2; % pour remettre les bons écarts dans tab

