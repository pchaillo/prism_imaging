function mat_pca_circle(win,band,nb_point,bio_dat,tlp)

h = waitbar(0, 'Mat PCA Analysis...');
%%%
l = length(bio_dat);
ind_peak_tab = 0;
for i = 1 : l
    if bio_dat(i).num > 0 % pour ne prendre en compte que les spectres vecteurs d'informations
        ind_peak_tab = ind_peak_tab + 1;
        peak_tab(:,:,ind_peak_tab) = bining_fixed_size(bio_dat(i).peaks.mz,win,band);
        h = waitbar(i/l);
    end
end

disp("bining finished")

%  p_2 = peak_tab(:,:,2);
p_1 = peak_tab(:,:,1);
mass_tab = p_1(:,1);
mass_char = num2str(mass_tab);

si = size(peak_tab);
for i = 1 : si(1)
    p = peak_tab(i,2,:);
    pca_ingredients(:,i) = p;
end
%     p_80 = peak_tab(:,:,80);

[vect_propres,scores,val_propres,t2,explained] = pca(pca_ingredients);

disp("pca computed")

if tlp == 1
    figure('Name','Cercle des corrélations - Toutes les masses','NumberTitle','off');
    plot(vect_propres(:,1),vect_propres(:,2),'.');
    text(vect_propres(:,1),vect_propres(:,2),mass_char);
    hold on
    [x,y,z] = cylinder(1,200);
    plot(x(1,:),y(1,:))
    hold on
    line([-1 1],[0 0])
    line([0 0],[-1 1])
    axis equal
end

% Detection des masses présentes en intensités.

% for i = 1 : si(1) % pas le meme nb de peak
%  [pk loc w pw] = findpeaks(pca_ingredients(i,:),mass_tab'); %trouve les peaks et leurs localisation
% loc_tab(i,:) = loc;
%  pk_tab(i,:) = pk;
% end

% for i = 1 : si(1)
%     p = pca_ingredients(i,:);
%     max_val = max(p);
%     loc = find( p == max_val);
%     loc_tab(i) = loc;
%     max_tab(i) = max_val;
% end

for i = 1 : si(3)
    p = pca_ingredients(i,:);
    max_val = max(p);
    if max_val ~= 0
        loca = find( p == max_val);
        if length(loca) == 1
            loc_tab(i) = loca;
        else
            loc_tab(i) = max(loca); % arbitraire => lorsque deux max, je prend celui de plus grande masse
        end
    end
    max_tab(i) = max_val;
end

% tot_tab(3,:) = loc_tab;
%  tot_tab(2,:) = max_tab;

for i = 1 : length(loc_tab)
    if loc_tab(i) ~= 0
        tot_tab(1,i) = mass_tab(loc_tab(i));
    end
end

max_ion = max(max_tab);
loca_ion = find (max_tab == max_ion);
mass_max = tot_tab(1,loca_ion);

max_tri = sort(max_tab, 'descend');

%for i = 1 : nb_point
mass_max_tab = 0;
i = 0;
while length(mass_max_tab) < nb_point % récupère les 10 masses les plus ionisés
    i = i+1
    if i < length(max_tri)
        max_v = max_tri(i);
        loca_ion = find (max_tab == max_v);
        if length(loca_ion) ~= 1
            loca_ion = max(loca_ion);
        end
        mass_max_tab_r(i) = tot_tab(1,loca_ion);
        mass_max_tab  = unique(mass_max_tab_r);
    else
        break;
    end
end

for i = 1 : length(mass_max_tab)
    m = mass_max_tab(i);
    t(i) = find ( mass_tab == m);
end

% t = find(mass_tab == mass_max_tab);

figure('Name','Cercle des corrélations - 10 masses les plus représentatives','NumberTitle','off');
plot(vect_propres(t,1),vect_propres(t,2),'.');
text(vect_propres(t,1),vect_propres(t,2),mass_char(t,:));
hold on
[x,y,z] = cylinder(1,200);
title(['Percentage of variance explained, PC1 : ', num2str(explained(1)),'  PC2 : ',num2str(explained(2))]);
plot(x(1,:),y(1,:))
hold on
line([-1 1],[0 0])
line([0 0],[-1 1])
axis equal

close(h);

    
    