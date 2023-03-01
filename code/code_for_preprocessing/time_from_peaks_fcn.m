function time_estimation = time_from_peaks_fcn(tab,min_threshold)

ind_bruit =  find(tab(4,:) < min_threshold );
ind_no_bruit =  find(tab(4,:) > min_threshold );

%% Pour estimer le temps de reconstruction à choisir
% detection de "plateau" de peaks, prendre ceux après la fusion des peaks !
ind_bruit_compar = [  ind_no_bruit ind_bruit];
[ ind_tries , ordre_2 ] = sort(ind_bruit_compar);

ind_deb_bruit = length(ind_no_bruit) + 1;
plateau = 1;

ind_plat = 0;
for i = 1 : length(ordre_2)-1
    if ordre_2(i) >= ind_deb_bruit
        plateau = 0;
    else
        plateau = 1;
    end
    if plateau == 1
        ind_plat = ind_plat + 1;
        ind_plat_tab(ind_plat) = i;
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

time_estimation = time ;