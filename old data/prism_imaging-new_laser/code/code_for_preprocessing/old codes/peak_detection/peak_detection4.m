<<<<<<< HEAD
% Avec les trois points différenciées + tab et bio_dat cohérents (sauf pt
% ajoutés)

% Permet de selectionner les valeurs à replacer sur la carte

% réalise la première moitié de la fusion des pics en deux lignes ( fusion_p1() )

% With peak find function
% avec points bleu lorsque fusion

% avec t_b en argument /input

% avec la detection du temps de reconstruction recommandé !

function [bio_dat, time, g] = peak_detection4(mzXMLStruct,threshold_begin,t_step,min_threshold)

file_i = mzXMLStruct.scan ;

file = clean_time(file_i); % avec plot_peak2

l = length(file);

% VARIABLES  %
% min_threshold = 5e3; % detection du bruit
time_res = 1 ;
%            %

%nb_p = 400 ; % number of expected points
%t_step = 3; % time in second between two measure
%t_t = t_step/2 ; % time tolerance

ok = 0; %% trouve le 1er point pour supprimer les valuers nulles qui sont avant
i = 0;
while ok == 0
    i = i + 1;
    if file(i).totIonCurrent > threshold_begin
        ind_debut = i;
        ok = 1;
    end
end

for i = 1: length(file) % récupère les datas
    ion(i) = file(i).totIonCurrent;
    %     t_i_r = file(i).retentionTime;
    %     t_i(i) = raw_to_time(t_i_r);
    t_i(i) = file(i).retentionTime;
end

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

ind_bruit =  find(tab(4,:) < min_threshold );
ind_no_bruit =  find(tab(4,:) > min_threshold );
tab_bruit = tab(:,ind_bruit);
tab_no_bruit = tab(:,ind_no_bruit);
% tab_bruit(3,:) = tab_loc_2(ind_bruit);
% nb_diff_bruit = length(tab_bruit) - sum(tab_bruit(3,:) == tab(3,ind_bruit));
tab_peaks = tab_no_bruit;
ind_peaks2 = tab_peaks(1,:); % indices des peaks detectés

for i = 2 : length(tab_peaks) % crée un 3e tableau des ecarts temporels après toutes les correction qui ont été appliquées !
    tab_loc_3(i) = tab_peaks(2,i) - tab_peaks(2,i-1) ;
end
% nb_diff = length(tab) - sum(tab_loc_3 == tab(3,:));
tab_peaks(3,:) = tab_loc_3; % pour remettre les bons écarts dans tab

i_sp = 0; %% fusionne deux pes trop proches ( quand il y a deux valeurs trop proches successives )
ind_fusion =  find(tab_peaks(3,:) < t_step - (t_step/6) ); % (t_step/6) bonne valeur
for i = 1 : length(ind_fusion) -1
    if ind_fusion(i)+1 == ind_fusion(i+1)
        i_sp = i_sp + 1;
        to_sup(i_sp) = ind_fusion(i);
        to_fusion(i_sp,1) = tab_peaks(1,ind_fusion(i)) ;
        to_fusion(i_sp,2) = tab_peaks(1,ind_fusion(i+1)) ;
    end
end
% ind_abs_fusion = find(tab(3,:) < t_step/1.7 ); % pour fusionner les points trop proches
% ind_abs_fusion(1) = []; % premier point toujours faux, pas encore d'ecart
% if exist('ind_abs_fusion')
%     for i = 1 : length(ind_abs_fusion)
%         i_sp = i_sp + 1;
%         to_sup(i_sp) = ind_abs_fusion(i);
%         to_fusion(i_sp,1) = tab(1,ind_abs_fusion(i)) ;
%         to_fusion(i_sp,2) = tab(1,ind_abs_fusion(i)-1) ;
%     end
% end
if exist('to_sup')
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
        file(ind_f_p) = fusion_p1_3(file(ind_f_m),file(ind_f_p));
    end
end
ind_peaks2 = tab_peaks(1,:); % indices des peaks detectés

for i = 2 : length(tab_peaks) % crée un deuxième tableau des ecarts temporels après toutes les correction qui ont été appliquées !
    tab_loc_2(i) = tab_peaks(2,i) - tab_peaks(2,i-1) ;
end
nb_diff = length(tab) - sum(tab_loc_2 == tab_peaks(3,:));

tab_peaks(3,:) = tab_loc_2; % pour remettre les bons écarts dans tab

for i = 1 : length(file)
    file_time_tab(i) = file(i).retentionTime;
    file_peak_tab(i) = file(i).totIonCurrent;
end

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
            new_point_ind = find_closest_pt(new_point_time,file_time_tab);
            %         if new_point_ind == 454 % pour test lors du debuggage
            %             datdatadat = 1220;
            %         end
            u = u + 1;
            new_point_tab(u) = new_point_ind;
        end
    end
end

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
        new_point_ind = find_closest_pt(new_point_time,file_time_tab);
        %         if new_point_ind == 454 % pour test lors du debuggage
        %             datdatadat = 1220;
        %         end
        u = u + 1;
        new_point_tab(u) = new_point_ind;
    end
end


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

% pour trouver les lignes vectrices f'informations non prises en compte
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

% ut = find(a_ind_no_bruit == ind_peaks2); % ne fonctionne pas : dimensions différentes
ut = ismember(a_ind_no_bruit ,ind_peaks2);

% ind_4 = a_ind_no_bruit(ut);            % verification de la fct ismember
% % ut2 = find(ind_4 == ind_peaks2);
% ut3 = (ind_4 == ind_peaks2);
% ut4 = min(ut3);
% if ut4 ~= 1
%     disp('attention, fct ismember ne fonctionne pas')
% end

ut_neg = ~ ut;
ind_coll_dat = a_ind_no_bruit(ut_neg); % ind des lignes "collatérales" qui comporte elles aussi de l'information moléculaire

for i = 1 : length(ind_peaks2)
    peaks2_time_tab(i) = file(ind_peaks2(i)).retentionTime;
end

for i = 1 : length(ind_coll_dat)
    if ind_coll_dat(i) < 0
        disp('attention, information collatérales dans les points ajoutés entre les peaks');
        %time_ind(i) = 1;
    else
        line = file(ind_coll_dat(i));
        
        %     tps(i) = line.retentionTime;  % pour enregistrer les temps dans un tableau
        %     time_ind(i) = find_closest_pt(tps(i),peaks2_time_tab);
        
        tps = line.retentionTime;  % sans enregistrer les temps dans un tableau
        time_ind(i) = find_closest_pt(tps,peaks2_time_tab);
    end
end

to_fusion_coll(:,1) = ind_peaks2(time_ind);
to_fusion_coll(:,2) = ind_coll_dat ;

file_i2 = file;

size_coll_fus = size(to_fusion_coll);
for i = 1 : size_coll_fus(1)
    ind_f_m = to_fusion_coll(i,1);
    ind_f_p = to_fusion_coll(i,2);
    file(ind_f_m) = fusion_p1_coll2(file(ind_f_m),file(ind_f_p));
end

bio_dat(:) = file(ind_final);

 plot_peak4(bio_dat,t_i,ion);

% detecttion de "plateau" de peaks
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
fprintf('Mean time between peaks : %f seconds \n', time);

g = 0;

=======
% Avec les trois points différenciées + tab et bio_dat cohérents (sauf pt
% ajoutés)

% Permet de selectionner les valeurs à replacer sur la carte

% réalise la première moitié de la fusion des pics en deux lignes ( fusion_p1() )

% With peak find function
% avec points bleu lorsque fusion

% avec t_b en argument /input

% avec la detection du temps de reconstruction recommandé !

function [bio_dat, time, g] = peak_detection4(mzXMLStruct,threshold_begin,t_step,min_threshold)

file_i = mzXMLStruct.scan ;

file = clean_time(file_i); % avec plot_peak2

l = length(file);

% VARIABLES  %
% min_threshold = 5e3; % detection du bruit
time_res = 1 ;
%            %

%nb_p = 400 ; % number of expected points
%t_step = 3; % time in second between two measure
%t_t = t_step/2 ; % time tolerance

ok = 0; %% trouve le 1er point pour supprimer les valuers nulles qui sont avant
i = 0;
while ok == 0
    i = i + 1;
    if file(i).totIonCurrent > threshold_begin
        ind_debut = i;
        ok = 1;
    end
end

for i = 1: length(file) % récupère les datas
    ion(i) = file(i).totIonCurrent;
    %     t_i_r = file(i).retentionTime;
    %     t_i(i) = raw_to_time(t_i_r);
    t_i(i) = file(i).retentionTime;
end

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

ind_bruit =  find(tab(4,:) < min_threshold );
ind_no_bruit =  find(tab(4,:) > min_threshold );
tab_bruit = tab(:,ind_bruit);
tab_no_bruit = tab(:,ind_no_bruit);
% tab_bruit(3,:) = tab_loc_2(ind_bruit);
% nb_diff_bruit = length(tab_bruit) - sum(tab_bruit(3,:) == tab(3,ind_bruit));
tab_peaks = tab_no_bruit;
ind_peaks2 = tab_peaks(1,:); % indices des peaks detectés

for i = 2 : length(tab_peaks) % crée un 3e tableau des ecarts temporels après toutes les correction qui ont été appliquées !
    tab_loc_3(i) = tab_peaks(2,i) - tab_peaks(2,i-1) ;
end
% nb_diff = length(tab) - sum(tab_loc_3 == tab(3,:));
tab_peaks(3,:) = tab_loc_3; % pour remettre les bons écarts dans tab

i_sp = 0; %% fusionne deux pes trop proches ( quand il y a deux valeurs trop proches successives )
ind_fusion =  find(tab_peaks(3,:) < t_step - (t_step/6) ); % (t_step/6) bonne valeur
for i = 1 : length(ind_fusion) -1
    if ind_fusion(i)+1 == ind_fusion(i+1)
        i_sp = i_sp + 1;
        to_sup(i_sp) = ind_fusion(i);
        to_fusion(i_sp,1) = tab_peaks(1,ind_fusion(i)) ;
        to_fusion(i_sp,2) = tab_peaks(1,ind_fusion(i+1)) ;
    end
end
% ind_abs_fusion = find(tab(3,:) < t_step/1.7 ); % pour fusionner les points trop proches
% ind_abs_fusion(1) = []; % premier point toujours faux, pas encore d'ecart
% if exist('ind_abs_fusion')
%     for i = 1 : length(ind_abs_fusion)
%         i_sp = i_sp + 1;
%         to_sup(i_sp) = ind_abs_fusion(i);
%         to_fusion(i_sp,1) = tab(1,ind_abs_fusion(i)) ;
%         to_fusion(i_sp,2) = tab(1,ind_abs_fusion(i)-1) ;
%     end
% end
if exist('to_sup')
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
        file(ind_f_p) = fusion_p1_3(file(ind_f_m),file(ind_f_p));
    end
end
ind_peaks2 = tab_peaks(1,:); % indices des peaks detectés

for i = 2 : length(tab_peaks) % crée un deuxième tableau des ecarts temporels après toutes les correction qui ont été appliquées !
    tab_loc_2(i) = tab_peaks(2,i) - tab_peaks(2,i-1) ;
end
nb_diff = length(tab) - sum(tab_loc_2 == tab_peaks(3,:));

tab_peaks(3,:) = tab_loc_2; % pour remettre les bons écarts dans tab

for i = 1 : length(file)
    file_time_tab(i) = file(i).retentionTime;
    file_peak_tab(i) = file(i).totIonCurrent;
end

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
            new_point_ind = find_closest_pt(new_point_time,file_time_tab);
            %         if new_point_ind == 454 % pour test lors du debuggage
            %             datdatadat = 1220;
            %         end
            u = u + 1;
            new_point_tab(u) = new_point_ind;
        end
    end
end

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
        new_point_ind = find_closest_pt(new_point_time,file_time_tab);
        %         if new_point_ind == 454 % pour test lors du debuggage
        %             datdatadat = 1220;
        %         end
        u = u + 1;
        new_point_tab(u) = new_point_ind;
    end
end


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

% pour trouver les lignes vectrices f'informations non prises en compte
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

% ut = find(a_ind_no_bruit == ind_peaks2); % ne fonctionne pas : dimensions différentes
ut = ismember(a_ind_no_bruit ,ind_peaks2);

% ind_4 = a_ind_no_bruit(ut);            % verification de la fct ismember
% % ut2 = find(ind_4 == ind_peaks2);
% ut3 = (ind_4 == ind_peaks2);
% ut4 = min(ut3);
% if ut4 ~= 1
%     disp('attention, fct ismember ne fonctionne pas')
% end

ut_neg = ~ ut;
ind_coll_dat = a_ind_no_bruit(ut_neg); % ind des lignes "collatérales" qui comporte elles aussi de l'information moléculaire

for i = 1 : length(ind_peaks2)
    peaks2_time_tab(i) = file(ind_peaks2(i)).retentionTime;
end

for i = 1 : length(ind_coll_dat)
    if ind_coll_dat(i) < 0
        disp('attention, information collatérales dans les points ajoutés entre les peaks');
        %time_ind(i) = 1;
    else
        line = file(ind_coll_dat(i));
        
        %     tps(i) = line.retentionTime;  % pour enregistrer les temps dans un tableau
        %     time_ind(i) = find_closest_pt(tps(i),peaks2_time_tab);
        
        tps = line.retentionTime;  % sans enregistrer les temps dans un tableau
        time_ind(i) = find_closest_pt(tps,peaks2_time_tab);
    end
end

to_fusion_coll(:,1) = ind_peaks2(time_ind);
to_fusion_coll(:,2) = ind_coll_dat ;

file_i2 = file;

size_coll_fus = size(to_fusion_coll);
for i = 1 : size_coll_fus(1)
    ind_f_m = to_fusion_coll(i,1);
    ind_f_p = to_fusion_coll(i,2);
    file(ind_f_m) = fusion_p1_coll2(file(ind_f_m),file(ind_f_p));
end

bio_dat(:) = file(ind_final);

 plot_peak4(bio_dat,t_i,ion);

% detecttion de "plateau" de peaks
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
fprintf('Mean time between peaks : %f seconds \n', time);

g = 0;

>>>>>>> prism_copy_for_tests
