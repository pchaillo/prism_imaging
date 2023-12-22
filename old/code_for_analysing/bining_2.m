% Réalise le groupement des données
% remet le tableau dans une forme finie définie par band, la bande de
% masses qui nous interesse et win, la largeur de la fenetre de bining

% forme finie => comparable entre elles

function peak_tab3 = bining_2(peak_tab2,win,band)

init = band(1);
i_end = band(2);

i_win = init;
l = length(peak_tab2);

k = 0;
h = 0;

val_tab = zeros(1,2); % for c
peak_tab3 = zeros(1,2); % for c

ind_p = 0;

for mass = init : win : i_end-win
    
    tab_i_1 = find ( peak_tab2(:,1) > mass );%&& peak_tab2(:,1) < mass +win);
    tab_i_2 = find( peak_tab2(:,1) < mass + win);
    max_ind = max(tab_i_2);
    min_ind = min(tab_i_1);
    
    k = k + 1;
    
    if min_ind < max_ind
        peak_tab3(k,2) = sum(peak_tab2(min_ind:max_ind,2));
        peak_tab3(k,1) = mass;
    elseif min_ind == max_ind
        peak_tab3(k,2) = peak_tab2(min_ind,2);
        peak_tab3(k,1) = mass;
    else
        peak_tab3(k,2) = 0;
        peak_tab3(k,1) = mass;
    end 
end

