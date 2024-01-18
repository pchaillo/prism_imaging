function indice_in_time_list = find_closest_point(initial_time_value, time_list, t_step)
% anciennement, find_dlosest_pt_4
% avec retour 0 si impossible
% rectifie les problèmes de temps !

time_band = t_step*6 ; % taille de la bande de temps à balayer

begin_of_time_band_indices = find( time_list > (initial_time_value - time_band) );
end_of_time_band_indices = find(time_list < (initial_time_value + time_band));

if isempty(begin_of_time_band_indices) || isempty(end_of_time_band_indices)
    indice_in_time_list = 1;
else
    minimal_indice  = min(begin_of_time_band_indices);
    maximal_indice = max(end_of_time_band_indices);
    
    u = 0;
    for i = minimal_indice : maximal_indice
        u = u + 1;
        gap_list(u) = abs(time_list(i) - initial_time_value);
    end
    
    if exist("gap_list")
        minimal_gap_time = min(gap_list);
        ind_in_gap_list = find( gap_list == minimal_gap_time );
        
        if length(ind_in_gap_list > 1)
            ind_in_gap_list = ind_in_gap_list(1);
        end
        
        closest_time_value = time_list(minimal_indice + ind_in_gap_list - 1);
        
        indice_in_time_list = find(time_list == closest_time_value);
        
        if length(indice_in_time_list) > 1
            update_log(app, 'Warning: Time is not properly recorded in the mzXML file. This may distort the peak detection');
            update_log(app, 'Attention: - Le temps est mal enregistré dans le fichier mzXML. Cela peut nuire à la détection de pics.');
            update_log(app, indice_in_time_list);
            indice_in_time_list = indice_in_time_list(1);
        end
    else
        indice_in_time_list = 2;
    end
end