% Réalise le groupement des données
% remet le tableau dans une forme finie définie par band, la bande de
% masses qui nous interesse et win, la largeur de la fenetre de bining

% forme finie => comparable entre elles
% FORME NORMALISé

%(copi de la fct bining_2)

function peak_tab3 = bining_norm(peak_tab2,win,band)

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

% % old version
% for mass = init : win : i_end-win
%     b_ok = 1;
%     for ind = ind_p : l
%         %while b_ok == 1
%         %ind = ind_p + 1;
%         if peak_tab2(ind,1) >= mass && peak_tab2(ind,1) < mass + win
%             h = h + 1;
%             val_tab(h,:) = peak_tab2(ind,:);
%         else%if mass + win < peak_tab2(ind,1)
%             k = k + 1;
%             %peak_tab3(k,:) = mean(val_tab);
%             peak_tab3(k,2) = sum(val_tab(:,2));
%             peak_tab3(k,1) = mass;
%             % i_win = peak_tab2(i,1);
%             %clearvars val_tab
%             val_tab = zeros(1,2); % for c
%             h = 0;
%             % val_tab(h,:) = peak_tab2(ind,:);
%             % b_ok = 0;
%             % ind_p = ind - 1;
%         end
%     end
%     
% end
