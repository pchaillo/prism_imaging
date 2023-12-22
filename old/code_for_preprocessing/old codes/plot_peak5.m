function plot_peak5(bio_dat,t_i,ion)

%avec meilleure fusion
% avec fusion collatérales

figure() % plot les points choisis
hold on
plot(t_i,ion)
ind_fus = 0; % point fussionnes
ind_norm = 0; % peaks normaux
ind_ad = 0; % points ajoutes
ind_coll = 0; % Points qui resultent d'une fusion "collatérale"
for i = 1 :length(bio_dat)
    %if floor(bio_dat(i).num) ~= bio_dat(i).num
    if bio_dat(i).centroided ~= 0
        ind_fus = ind_fus + 1 ;
        pk_fus(ind_fus) = bio_dat(i).totIonCurrent; % ou bio_dat(i).centroided ?
        %         loc_r= bio_dat(i).retentionTime;
        %         loc_rond(ind_rond) = raw_to_time(loc_r);
        loc_fus(ind_fus) = bio_dat(i).retentionTime;
    elseif bio_dat(i).num < 0
        ind_ad = ind_ad + 1;
        pk_ad(ind_ad) = bio_dat(i).totIonCurrent;
        %         loc_r = bio_dat(i).retentionTime;
        %         loc_x(ind_x) = raw_to_time(loc_r);
        loc_ad(ind_ad) = bio_dat(i).retentionTime;
    elseif bio_dat(i).msLevel > 1
        ind_coll = ind_coll + 1;
        pk_coll(ind_coll) =  bio_dat(i).totIonCurrent;
        loc_coll(ind_coll) = bio_dat(i).retentionTime;
    else
        ind_norm = ind_norm + 1 ;
        %         loc_r= bio_dat(i).retentionTime;
        %         loc2(ind2) = raw_to_time(loc_r);
        loc_norm(ind_norm) = bio_dat(i).retentionTime;
        pk_norm(ind_norm) = bio_dat(i).totIonCurrent;
    end
end
if exist('loc_norm')
    scatter(loc_norm,pk_norm,'*','red');
end
if exist('loc_coll')
    scatter(loc_coll,pk_coll,'o','red');
end
if exist('loc_fus')
    scatter(loc_fus,pk_fus,'o','m');
end
if exist('loc_ad')
    scatter(loc_ad,pk_ad,'d','b');
end
hold off