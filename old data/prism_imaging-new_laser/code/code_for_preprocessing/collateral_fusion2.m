function file = collateral_fusion2(file,ind_debut,ind_fin,min_threshold,ind_peaks2,ind_fusion,t_step,ind_peaks_supp)

a_file = file(ind_debut:ind_fin);
for i = 1 : length(a_file)
    a_int_tab(i) = a_file(i).totIonCurrent;
    a_ind(i) = a_file(i).num;
end
a_bruit =  find(a_int_tab < min_threshold );
a_no_bruit =  find(a_int_tab > min_threshold );
a_ind_bruit = a_ind(a_bruit);
a_ind_no_bruit = a_ind(a_no_bruit); % à comparer avec les peaks pour ajouter les infos !
% comparer avec ind_peaks2;

ut = ismember(a_ind_no_bruit ,ind_peaks2);

ut_neg = ~ ut;
ind_coll_dat_raw = a_ind_no_bruit(ut_neg); % indices de toutes les lignes au dessus du threshold minimum de bruit
ind_coll_dat_01 = ind_coll_dat_raw;

if (~isempty(ind_fusion))
    [ind_communs_2 i_a2 i_b2 ] = intersect(ind_peaks_supp,ind_coll_dat_01); % retrait de toutes les lignes déjà fusionnées
    ind_coll_dat_01(i_b2)=[];
end

ind_coll_dat = ind_coll_dat_01; % ind des lignes "collatérales" qui comporte elles aussi de l'information moléculaire

for i = 1 : length(ind_peaks2)
    peaks2_time_tab(i) = file(ind_peaks2(i)).retentionTime;
end

p = 0;
for i = 1 : length(ind_coll_dat)
    if ind_coll_dat(i) < 0
        disp('attention, information collatérales dans les points detectés entre les peaks');
        %time_ind(i) = 1;
    else
        p = p + 1;
        line = file(ind_coll_dat(i));
        
        %     tps(i) = line.retentionTime;  % pour enregistrer les temps dans un tableau
        %     time_ind(i) = find_closest_pt(tps(i),peaks2_time_tab);
        
        tps = line.retentionTime;  % sans enregistrer les temps dans un tableau
        if i == 865
            wahou = 0;
        end
        time_ind(p) = find_closest_pt_4(tps,peaks2_time_tab,t_step);
        p_ind_tab(p) = i;
    end
end

if p > 0
    to_fusion_coll(:,1) = ind_peaks2(time_ind);
    to_fusion_coll(:,2) = ind_coll_dat(p_ind_tab) ;
    
    file_i2 = file;
    
    size_coll_fus = size(to_fusion_coll);
    for i = 1 : size_coll_fus(1)
        ind_f_m = to_fusion_coll(i,1);
        ind_f_p = to_fusion_coll(i,2);
        file(ind_f_m) = fusion_p1_top(file(ind_f_m),file(ind_f_p));
    end
end
