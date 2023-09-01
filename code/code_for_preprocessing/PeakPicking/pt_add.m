function new_point_tab =  pt_add(t_step,tab_peaks,intern_flag,file,time_res,file_time_tab,begin_index)

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
            new_point_ind = find_closest_pt_4(new_point_time,file_time_tab,t_step);
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
        new_point_ind = find_closest_pt_4(new_point_time,file_time_tab,t_step);
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
    ind_deb = begin_index;
    time_01_2 = file(1).retentionTime ;
    time_02_2 = tab_peaks(2,1);
    nb_pt = ceil(( time_02_2 - time_01_2 ) / t_step) - 1 ; %deuxième - 1 ?
    for j = 1 : nb_pt
        new_point_time = time_01_2 + j*t_step;
        if new_point_time < time_02_2 - time_res*1.5 % securite pour eviter la superposition de points
            % if new_point_time < time_loc_tab(i) + time_diff_tab(i) - (t_step/3) % securite pour eviter la superposition de points
            new_point_ind = find_closest_pt_4(new_point_time,file_time_tab,t_step);
            %         if new_point_ind == 454 % pour test lors du debuggage
            %             datdatadat = 1220;
            %         end
            u = u + 1;
            new_point_tab(u) = new_point_ind;
        end
    end
end