% Avec les trois points différenciées + tab et bio_dat cohérents (sauf pt
% ajoutés)

% Permet de selectionner les valeurs à replacer sur la carte

% réalise la première moitié de la fusion des pics en deux lignes ( fusion_p1() )

% With peak find function
% avec points bleu lorsque fusion

% avec t_b en argument /input

function [bio_dat, time, g] = peak_detection(mzXMLStruct,threshold_begin,t_step)

file_i = mzXMLStruct.scan ;

file = clean_time(file_i); % avec plot_peak2

l = length(file);

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
    ind_p(i) = find( t_i == loc(i) );
end

tab(1,:) = ind_p; % mise des valeurs dans le tableau
tab(2,:) = loc;
tab(3,:) = tab_loc;
tab(4,:) = pk;

deb_sup = find(tab(1,:) == ind_debut); % supprime les points intuiles
tab(:,1:deb_sup-1) = [];

tab_i = tab; % on enregistre le tableau initial avant suppression/ajout de points/retrait du bruit

min_threshold = 2e3; % detection du bruit
ind_bruit =  find(tab(4,:) < min_threshold );
ind_no_bruit =  find(tab(4,:) > min_threshold );
tab_bruit = tab(:,ind_bruit);
tab_no_bruit = tab(:,ind_no_bruit);
% tab_bruit(3,:) = tab_loc_2(ind_bruit);
% nb_diff_bruit = length(tab_bruit) - sum(tab_bruit(3,:) == tab(3,ind_bruit));
tab = tab_no_bruit;

for i = 2 : length(tab) % crée un 3e tableau des ecarts temporels après toutes les correction qui ont été appliquées !
    tab_loc_3(i) = tab(2,i) - tab(2,i-1) ;
end
% nb_diff = length(tab) - sum(tab_loc_3 == tab(3,:));
tab(3,:) = tab_loc_3; % pour remettre les bons écarts dans tab

i_sp = 0; %% fusionne deux pes trop proches ( quand il y a deux valeurs trop proches successives )
ind_fusion =  find(tab(3,:) < t_step - (t_step/8) );
for i = 1 : length(ind_fusion) -1
    if ind_fusion(i)+1 == ind_fusion(i+1)
        i_sp = i_sp + 1;
        to_sup(i_sp) = ind_fusion(i);
        to_fusion(i_sp,1) = tab(1,ind_fusion(i)) ;
        to_fusion(i_sp,2) = tab(1,ind_fusion(i+1)) ;
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
        if to_sup(i) > length(tab)
            %  to_sup(i) = [];
        else
            tab(:,to_sup(i)) = [] ;
        end
    end
    % end
    size_to_fusion = size(to_fusion);
    for i = 1 : size_to_fusion(1)
        %     ind_f = to_fusion(i);
        ind_f_m = to_fusion(i,1);
        ind_f_p = to_fusion(i,2);
        file(ind_f_p) = fusion_p1_2(file(ind_f_m),file(ind_f_p));
    end
end

% % ind_add =  find(tab(3,:) > 2*t_step - t_step/10); % ajoute un point dans les grands espaces
% % for i = 1 : length(ind_add)
% % %     if ind_add(i) > length(ind_p) % ?
% %     if ind_add(i) > length(tab(1,:)) % ?
% %         ind_add(i) = []; % supprime les points à ajouter trop loin
% %     end
% % end
% % i_add = tab(1,ind_add); % indices des points après le trou (ceux pour lesquels on a enregistré un grand écart)
% % i_add2 = i_add - 3; % indice du point que je vais rajouter pour combler
% % for i = 1 : length(i_add2)
% %     file(i_add2(i)) = to_add_pt(file(i_add2(i)));
% % end
% % ind_p2 = sort([tab(1,:),i_add2]); % mélange des indices pour que les points soient dans le bon ordre
% %
% % l_t = length(tab); % resmise des informations dans tab
% % for i = 1 : length(i_add2)
% %     tab(1,l_t+i) = i_add2(i);
% %     loc_r =  file(i_add2(i)).retentionTime;
% %     tab(2,l_t+i) = raw_to_time(loc_r);
% % end
% % tab2 = sortrows(tab',1);
% % tab = tab2';

for i = 1 : length(file)
    file_time_tab(i) = file(i).retentionTime;
    file_peak_tab(i) = file(i).totIonCurrent;
end

ind_add =  find(tab(3,:) > 2*t_step - t_step/10); % ajoute un point dans les grands espaces
ind_add_01 = ind_add -1;
time_diff_tab = tab(3,ind_add);
% time_loc_tab = tab(2,ind_add);
time_loc_tab = tab(2,ind_add_01);
u = 0;
for i = 1 : length(ind_add)
    file_ind_01 = tab(1,ind_add_01(i));
    file_ind_02 = tab(1,ind_add(i));
    nb_pt = ceil(time_diff_tab(i) / t_step) - 1 ; %deuxième - 1 ?
    for j = 1 : nb_pt
        new_point_time = time_loc_tab(i) + j*t_step;
        if new_point_time < time_loc_tab(i) + time_diff_tab(i) - (t_step/3) % securite pour eviter la superposition de points
            new_point_ind = find_closest_pt(new_point_time,file_time_tab);
            %         if new_point_ind == 454 % pour test lors du debuggage
            %             datdatadat = 1220;
            %         end
            u = u + 1;
            new_point_tab(u) = new_point_ind;
        end
    end
end

for i = 1 : length(new_point_tab)
    file(new_point_tab(i)) = to_add_pt(file(new_point_tab(i)));
end

ind_p2 = tab(1,:); % indices des peaks detectés

% sup_deb = find(ind_p2 <= i_d-1);
% ind_p2(sup_deb) = []; % supprime les valeurs avant le premier point
for i = 2 : length(tab) % crée un deuxième tableau des ecarts temporels après toutes les correction qui ont été appliquées !
    tab_loc_2(i) = tab(2,i) - tab(2,i-1) ;
end
nb_diff = length(tab) - sum(tab_loc_2 == tab(3,:));
% min_threshold = 1e4; % detection du bruit
% ind_bruit =  find(tab(4,:) < min_threshold );
% tab_bruit = tab(:,ind_bruit);
% tab_bruit(3,:) = tab_loc_2(ind_bruit);
% nb_diff_bruit = length(tab_bruit) - sum(tab_bruit(3,:) == tab(3,ind_bruit));

tab(3,:) = tab_loc_2; % pour remettre les bons écarts dans tab

ind_p3 = new_point_tab; % indices des points rajoutés pour combler les trous

ind_final_raw= [ ind_p2 ind_p3];
ind_final = sort(ind_final_raw) ;% indices finaux des points à mettre dans bio_dat
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

% tab(1,:) = ind_p; % mise des valeurs dans le tableau
% tab(2,:) = loc;
% tab(3,:) = tab_loc;
% tab(4,:) = pk;

bio_dat(:) = file(ind_final);

plot_peak2(bio_dat,t_i,ion);

time = 0;
g = 0;

