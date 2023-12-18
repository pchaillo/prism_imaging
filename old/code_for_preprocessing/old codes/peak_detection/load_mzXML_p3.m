% Permet de selectionner les valeurs à replacer sur la carte

% réalise la première moitié de la fusion des pics en deux lignes ( fusion_p1() )

% With peak find function
% avec points bleu lorsque fusion

function [bio_dat, time, g] = load_mzXML_p3(mzXMLStruct,threshold_begin)


file = mzXMLStruct.scan ;

l = length(file);

%nb_p = 400 ; % number of expected points
t_step = 3; % time in second between two measure
t_t = 1.4; % time tolerance

ok = 0; %% trouve le 1er point pour supprimer les valuers nulles qui sont avant
i = 0;

while ok == 0
    i = i + 1;
    if file(i).totIonCurrent > threshold_begin
        i_d = i;
        ok = 1;
    end
end

for i = 1: length(file) % récupère les datas
    ion(i) = file(i).totIonCurrent;
    t_i_r = file(i).retentionTime;
    t_i(i) = raw_to_time(t_i_r);
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

i_sp = 0; %% fusionne deux points trop proches ( quand il y a deux valeur a 2 sec d'ecart successives )
ind_2 =  find(tab(3,:) < 2.9);
for i = 1 : length(ind_2) -1
    if ind_2(i)+1 == ind_2(i+1)
        i_sp = i_sp + 1;
        to_sup(i_sp) = ind_2(i);
        to_fusion(i_sp,1) = tab(1,ind_2(i)) ;
        to_fusion(i_sp,2) = tab(1,ind_2(i+1)) ;
    end
end
if exist('to_sup')
    % to_fusion = tab(1,to_sup);
    for i = length(to_sup) : -1 : 1
        if to_sup(i) > length(tab)
            %  to_sup(i) = [];
        else
            tab(:,to_sup(i)) = [] ;
        end
    end
end

for i = 1 : length(to_fusion)
    %     ind_f = to_fusion(i);
    ind_f_m = to_fusion(i,1);
    ind_f_p = to_fusion(i,2);
    file(ind_f_p) = fusion_p1(file(ind_f_m),file(ind_f_p));
end


ind_5 =  find(tab(3,:) > 5.7); % ajoute un point dans les grands espaces
for i = 1 : length(ind_5)
    if ind_5(i) > length(ind_p)
        ind_5(i) = [];
    end
end
i_add = tab(1,ind_5);
i_add2 = i_add - 1;
ind_p2 = sort([tab(1,:),i_add2]);

sup_deb = find(ind_p2 <= i_d-1);
ind_p2(sup_deb) = []; % supprime les valeurs avant le premier point

bio_dat(:) = file(ind_p2);

figure() % plot les points choisis
hold on
plot(t_i,ion)
ind_bleu = 0;
for i = 1 :length(bio_dat)
    if floor(bio_dat(i).num) ~= bio_dat(i).num
        ind_bleu = ind_bleu + 1 ;
        pk_bleu(ind_bleu) = bio_dat(i).totIonCurrent;
        loc_r= bio_dat(i).retentionTime;
        loc_bleu(ind_bleu) = raw_to_time(loc_r);
    else
        loc_r= bio_dat(i).retentionTime;
        loc2(i) = raw_to_time(loc_r);
        pk2(i) = bio_dat(i).totIonCurrent;
    end
end
plot(loc2,pk2,'*');
if exist('loc_bleu')
    plot(loc_bleu,pk_bleu,'o');
end
hold off


time = 0;
g = 0;

