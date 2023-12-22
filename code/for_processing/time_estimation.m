function estimated_time = time_estimation(data_array,noise_threshold)
% Compute the mean time between selected peaks

noise_indices =  find(data_array(4,:) < noise_threshold );
over_noise_indices =  find(data_array(4,:) > noise_threshold );

%% Pour estimer le temps de reconstruction à choisir
% detection de "plateau" de peaks, prendre ceux après la fusion des peaks !
ind_bruit_compar = [  over_noise_indices noise_indices];
[ sorted_indices , ordre_2 ] = sort(ind_bruit_compar);

ind_deb_bruit = length(over_noise_indices) + 1;
following = 1;

following_ind = 0;
for i = 1 : length(ordre_2)-1
    if ordre_2(i) >= ind_deb_bruit
        following = 0;
    else
        following = 1;
    end
    if following == 1
        following_ind = following_ind + 1;
        indice_list(following_ind) = i;
    end
end

fixed_indice_list = indice_list; % pour retirer les écarts en dehors des plateaux
for i = length(indice_list) : - 1 : 2
    if indice_list(i-1) ~= indice_list(i) - 1
        fixed_indice_list(i) = [];
    end
end

following_time_gap_list = data_array(3,fixed_indice_list);

% temps de reconstruction suggéré
estimated_time = mean(following_time_gap_list); % fonctionne très bien sur cet exemple !
% time2 = median(following_time_gap_list);
fprintf('Mean time between peaks : %f seconds \n Attention, ne fonctionne pas à haute fréquence d échantillonage \n', estimated_time);