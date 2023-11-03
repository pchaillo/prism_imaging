% Permet de selectionner les valeurs à replacer sur la carte

% réalise la première moitié de la fusion des pics en deux lignes ( fusion_p1_top() )

% Meilleure vesrion => fusion des peaks proches et des données collatérales
% -> sensé fonctionner pour tous les spectres et toutes les fréquences
% d'échantillonage

% avec la detection du temps de reconstruction recommandé !

% avec mode trigerreint interne avec un flag en argument => prend en compte la 1ere pente comme un peak !

% avec le pourcentage de tolérance en argument !

function [bio_dat, time, g] = peak_detection11(mzXMLStruct,threshold_begin,t_step,min_threshold,intern_flag,tolerance)

file_i = mzXMLStruct.scan ;

file = clean_time(file_i); % transformation du temps en une varibale numérique
file = clean_deiso2(file);

l = length(file);

% VARIABLES  %
% min_threshold = 5e3; % detection du bruit
time_res = 1 ;
%            %

%nb_p = 400 ; % number of expected points
%t_step = 3; % time in second between two measure
%t_t = t_step/2 ; % time tolerance

%% Détection du premier pic

ok = 0; %% trouve le 1er point pour supprimer les valuers nulles qui sont avant
i = 0;
while ok == 0
    i = i + 1;
    if file(i).totIonCurrent > threshold_begin
        ind_debut = i;
        ok = 1;
    end
end

%% Récupération des informations

for i = 1: length(file) % récupère les datas
    ion(i) = file(i).totIonCurrent;
    %     t_i_r = file(i).retentionTime;
    %     t_i(i) = raw_to_time(t_i_r);
    t_i(i) = file(i).retentionTime;
end

%% Détection de peaks matlab

[pk loc w pw] = findpeaks(ion,t_i); %trouve les peaks et leurs localisation

for i = 2 : length(loc) % crée un tableau des ecarts temporels
    tab_loc(i) = loc(i) - loc(i-1) ;
end

for i = 1 : length(loc) % récupère les indices des peaks
    ind_peaks(i) = find( t_i == loc(i) );
end

tab(1,:) = ind_peaks; % mise des valeurs dans le tableau
tab(2,:) = loc;
tab(3,:) = tab_loc;
tab(4,:) = pk;

deb_sup = find(tab(1,:) == ind_debut); % supprime les points intuiles
tab(:,1:deb_sup-1) = [];

tab_i = tab; % on enregistre le tableau initial avant suppression/ajout de points/retrait du bruit

%% Application du filtrage min par threshold de bruit
ind_bruit =  find(tab(4,:) < min_threshold );
ind_no_bruit =  find(tab(4,:) > min_threshold );
tab_bruit = tab(:,ind_bruit);
tab_no_bruit = tab(:,ind_no_bruit);
% tab_bruit(3,:) = tab_loc_2(ind_bruit);
% nb_diff_bruit = length(tab_bruit) - sum(tab_bruit(3,:) == tab(3,ind_bruit));
tab_peaks = tab_no_bruit;
ind_peaks2 = tab_peaks(1,:); % indices des peaks detectés

psi = size(tab_peaks);
if psi(2) == 0
    disp('----- Attention to high min threshold, no peaks detected -------');
    %quit(1)
    return
end

for i = 2 : length(tab_peaks) % crée un 3e tableau des ecarts temporels après toutes les correction qui ont été appliquées !
    tab_loc_3(i) = tab_peaks(2,i) - tab_peaks(2,i-1) ;
end
% nb_diff = length(tab) - sum(tab_loc_3 == tab(3,:));
tab_peaks(3,:) = tab_loc_3; % pour remettre les bons écarts dans tab

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
nb_diff = length(tab) - sum(tab_loc_2 == tab_peaks(3,:));

tab_peaks(3,:) = tab_loc_2; % pour remettre les bons écarts dans tab

for i = 1 : length(file)
    file_time_tab(i) = file(i).retentionTime;
    file_peak_tab(i) = file(i).totIonCurrent;
end

%% Ajout de points dans les grands espaces, pour permettre la bonne reconstruction de l'image
ind_add =  find(tab_peaks(3,:) > 2*t_step - t_step/10); % ajoute un point dans les grands espaces
ind_add_01 = ind_add -1;
time_diff_tab = tab_peaks(3,ind_add);
% time_loc_tab = tab(2,ind_add);
time_loc_tab = tab_peaks(2,ind_add_01);
u = 0;
for i = 1 : length(ind_add)
    file_ind_01 = tab_peaks(1,ind_add_01(i));
    file_ind_02 = tab_peaks(1,ind_add(i));
    nb_pt = ceil(time_diff_tab(i) / t_step) - 1 ; %deuxième - 1 ?
    for j = 1 : nb_pt
        new_point_time = time_loc_tab(i) + j*t_step;
        if new_point_time < time_loc_tab(i) + time_diff_tab(i) - time_res*1.5 % securite pour eviter la superposition de points
        % if new_point_time < time_loc_tab(i) + time_diff_tab(i) - (t_step/3) % securite pour eviter la superposition de points
            new_point_ind = find_closest_pt_3(new_point_time,file_time_tab,t_step);
            %         if new_point_ind == 454 % pour test lors du debuggage
            %             datdatadat = 1220;
            %         end
            u = u + 1;
            new_point_tab(u) = new_point_ind;
        end
    end
end

%% Ajout de points après les peaks, pour qu'il ne manque pas de points après que l'analyse ai été effectuée
% ajout de points a la fin, apres le sample
ind_fin_peaks = tab_peaks(1,end);
ind_fin = length(file);
time_01 =  tab_peaks(2,end);
time_02 = file(end).retentionTime;
nb_pt = ceil((time_02-time_01) / t_step) - 1 ; %deuxième - 1 ?
for j = 1 : nb_pt
    new_point_time = time_01 + j*t_step;
    if new_point_time < time_02 - time_res*1.5 % securite pour eviter la superposition de points
        % if new_point_time < time_loc_tab(i) + time_diff_tab(i) - (t_step/3) % securite pour eviter la superposition de points
        new_point_ind = find_closest_pt_3(new_point_time,file_time_tab,t_step);
        %         if new_point_ind == 454 % pour test lors du debuggage
        %             datdatadat = 1220;
        %         end
        u = u + 1;
        new_point_tab(u) = new_point_ind;
    end
end

if intern_flag == 1
    %% Ajout de points AVANT les peaks, pour qu'il ne manque pas de points AVANT que l'analyse ai été effectuée
    % ajout de points a la fin, apres le sample
    ind_deb_peaks = tab_peaks(1,end);
    ind_deb = ind_debut;
    time_01_2 = file(1).retentionTime ;
    time_02_2 = tab_peaks(2,1);
    nb_pt = ceil(( time_02_2 - time_01_2 ) / t_step) - 1 ; %deuxième - 1 ?
    for j = 1 : nb_pt
        new_point_time = time_01_2 + j*t_step;
        if new_point_time < time_02_2 - time_res*1.5 % securite pour eviter la superposition de points
            % if new_point_time < time_loc_tab(i) + time_diff_tab(i) - (t_step/3) % securite pour eviter la superposition de points
            new_point_ind = find_closest_pt_3(new_point_time,file_time_tab,t_step);
            %         if new_point_ind == 454 % pour test lors du debuggage
            %             datdatadat = 1220;
            %         end
            u = u + 1;
            new_point_tab(u) = new_point_ind;
        end
    end
end

%% Ajout de la pente comme le 1er point !

%dbug = 0;
if intern_flag == 1
    
    ind_peaks2 = [ 1 ind_peaks2];
end

%% Génération des bon indices

if exist('new_point_tab')
    for i = 1 : length(new_point_tab)
        file(new_point_tab(i)) = to_add_pt(file(new_point_tab(i)));
    end
    ind_p3 = new_point_tab; % indices des points rajoutés pour combler les trous
    ind_final_raw= [ ind_peaks2 ind_p3];
else
    ind_final_raw = ind_peaks2;
end

[ind_final, ordre ]= sort(ind_final_raw) ;% indices finaux des points à mettre dans bio_dat
[uv,a,b] = unique(ind_final);
if length(uv) ~= length(ind_final)
    disp('Attention : points superposition, look at the biodat variable or at the mat file')
end

tab_final(1,:) = ind_final; % pour informations
tab_final(2,:) =    file_time_tab(ind_final) ;
for i = 2 : length(ind_final) % crée un tableau des ecarts temporels
    tab_loc_final(i) = tab_final(2,i) - tab_final(2,i-1) ;
end
tab_final(3,:) = tab_loc_final;
tab_final(4,:) =   file_peak_tab(ind_final) ;
trop_court = find(tab_final(3,:) < t_step - t_step/3);
trop_long = find(tab_final(3,:) > t_step + t_step/5);

%% pour trouver les lignes vectrices d'informations non prises en compte et les fusionner au peak le plus proche
%ind_deb = tab(1,1); % existe dejà, ind_debut
ind_fin = tab_peaks(1,end);

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

%% Pour remettre les bonnes informations dans bio_dat et pour afficher le chromatogramme avec les points

bio_dat(:) = file(ind_final);

 plot_peak5(bio_dat,t_i,ion);

%% Pour estimer le temps de reconstruction à choisir
% detecttion de "plateau" de peaks, prendre ceux après la fusion des peaks
% !
ind_bruit_compar = [  ind_no_bruit ind_bruit];
[ ind_tries , ordre_2 ] = sort(ind_bruit_compar);
% for i = 1 : length(ind_final_raw)-1 % fonctionne mais inutilement complexe
%     if ind_final_raw(i) > ind_final_raw(i+1)
%         ind_deb_bruit = i+1;
%     end
% end
ind_deb_bruit = length(ind_no_bruit) + 1;
plateau = 1;
%plat_time_tab;
ind_plat = 0;
for i = 1 : length(ordre_2)-1
    if ordre_2(i) >= ind_deb_bruit
        plateau = 0;
%     elseif ordre(i) < ordre(i+1)
% %     elseif plateau == 1
% %         ind_plat = ind_plat + 1;
% %         plat_time_tab(ind_plat) = tab_final(3,i);
    else
        plateau = 1;
    end
    if plateau == 1
        ind_plat = ind_plat + 1;
        ind_plat_tab(ind_plat) = i;
       % plat_time_tab(ind_plat) = tab(3,i);
    end
end

ind_plat_tab2 = ind_plat_tab; % pour retirer les écarts en dehors des plateaux
for i = length(ind_plat_tab) : - 1 : 2
    if ind_plat_tab(i-1) ~= ind_plat_tab(i) - 1
        ind_plat_tab2(i) = [];
    end
end

plat_time_tab = tab(3,ind_plat_tab2);

% temps de reconstruction suggéré
time = mean(plat_time_tab); % fonctionne très bien sur cet exemple !
% time2 = median(plat_time_tab);
fprintf('Mean time between peaks : %f seconds \n Attention, ne fonctionne pas à haute fréquence d échantillonage \n', time);

g = 0;

