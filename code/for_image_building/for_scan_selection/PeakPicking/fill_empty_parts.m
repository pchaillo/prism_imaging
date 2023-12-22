function point_to_add_indices =  fill_empty_parts(t_step,data_array,intern_flag,file,time_res,scan_time_list,begin_index)

%% Add empty points, to fill part where there was no data
%% Ajout de points dans les grands espaces, pour permettre la bonne reconstruction de l'image
big_space_indices =  find(data_array(3,:) > 2*t_step - t_step/10); % ajoute un point dans les grands espaces
big_space_indices_shifted = big_space_indices -1;
time_gap_list = data_array(3,big_space_indices);
% selected_time_list = tab(2,big_space_indices);
selected_time_list = data_array(2,big_space_indices_shifted);
u = 0;
for i = 1 : length(big_space_indices)
%     file_ind_01 = data_array(1,big_space_indices_shifted(i));
%     file_ind_02 = data_array(1,big_space_indices(i));
    nb_pt = ceil(time_gap_list(i) / t_step) - 1 ; %deuxième - 1 ?
    for j = 1 : nb_pt
        new_point_time = selected_time_list(i) + j*t_step;
        if new_point_time < selected_time_list(i) + time_gap_list(i) - time_res*1.5 % securite pour eviter la superposition de points
        % if new_point_time < selected_time_list(i) + time_gap_list(i) - (t_step/3) % securite pour eviter la superposition de points
            new_point_ind = find_closest_point(new_point_time,scan_time_list,t_step);
            u = u + 1;
            point_to_add_indices(u) = new_point_ind;
        end
    end
end

%% Add point after the peaks on chromatogram, to be sure to have enough point for reconstruction
%% Ajout de points après les peaks, pour qu'il ne manque pas de points après que l'analyse ai été effectuée
% ajout de points a la fin, apres le sample
last_selected_time =  data_array(2,end);
last_scan_time = file(end).retentionTime;
nb_pt = ceil((last_scan_time-last_selected_time) / t_step) - 1 ; %deuxième - 1 ?
for j = 1 : nb_pt
    new_point_time = last_selected_time + j*t_step;
    if new_point_time < last_scan_time - time_res*1.5 % securite pour eviter la superposition de points
        % if new_point_time < selected_time_list(i) + time_gap_list(i) - (t_step/3) % securite pour eviter la superposition de points
        new_point_ind = find_closest_point(new_point_time,scan_time_list,t_step);
        u = u + 1;
        point_to_add_indices(u) = new_point_ind;
    end
end

if intern_flag == 1
    %% Add point before the first peaks on chromatogram, to avoid shifted images
    %% Ajout de points AVANT les peaks, pour qu'il ne manque pas de points AVANT que l'analyse ai été effectuée
    % ajout de points a la fin, apres le sample
    first_scan_time = file(1).retentionTime ;
    first_selected_time = data_array(2,1);
    nb_pt = ceil(( first_selected_time - first_scan_time ) / t_step) - 1 ; %deuxième - 1 ?
    for j = 1 : nb_pt
        new_point_time = first_scan_time + j*t_step;
        if new_point_time < first_selected_time - time_res*1.5 % securite pour eviter la superposition de points
            % if new_point_time < selected_time_list(i) + time_gap_list(i) - (t_step/3) % securite pour eviter la superposition de points
            new_point_ind = find_closest_point(new_point_time,scan_time_list,t_step);
            u = u + 1;
            point_to_add_indices(u) = new_point_ind;
        end
    end
end