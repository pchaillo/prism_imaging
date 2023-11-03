% Réalise le groupement des données

function peak_tab3 = bining(peak_tab2,win)

if length(peak_tab2) ~= 0 &&  length(peak_tab2) ~= 1
    init = peak_tab2(1,1);
    i_win = init;
    si = size(peak_tab2);
    l = si(1);
    
    k = 0;
    h = 0;
    
    val_tab = zeros(1,2); % for c
    peak_tab3 = zeros(1,2); % for c
    
    for i = 1 : l
        if peak_tab2(i,1) >= i_win && peak_tab2(i,1) < i_win + win
            h = h + 1;
            val_tab(h,:) = peak_tab2(i,:);
        else
            k = k + 1;
            %peak_tab3(k,:) = mean(val_tab);
            peak_tab3(k,2) = sum(val_tab(:,2));
            peak_tab3(k,1) = mean(val_tab(:,1));
            i_win = peak_tab2(i,1);
            %clearvars val_tab
            val_tab = zeros(1,2); % for c
            h = 1 ;
            val_tab(h,:) = peak_tab2(i,:);
        end
    end
else
    peak_tab3 = zeros(1,2);
end
