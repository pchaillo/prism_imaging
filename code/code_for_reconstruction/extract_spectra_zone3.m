function extract_spectra_zone3(bio_dat,carte,limits)

carte_x = carte.x;
carte_y = carte.y;
carte_z = carte.z;
seuil = -1;

if isfield(carte,'time')
    carte_time = carte.time;
    time_flag = 1;
else
    time_flag = 0;
end

loud_flag = 0;
 [ bio_ind ,bio_map ] = mzXML_on_map_norm17(bio_dat,carte_z,limits,carte_time,time_flag,loud_flag); 

[ carte_x,carte_y,carte_z,bio_map  ] = fix_border_2(carte_x,carte_y,carte_z,bio_map,bio_ind);

figure()
hold on
s = surf(carte_x,carte_y,carte_z,bio_map);
%s.FaceAlpha=0.9; % niveau de tranparence
s.FaceColor = 'flat'; % set color interpolqtion
s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
%title(['biometric map, mass limits : ', num2str(import_limits(1)),'  ',num2str(import_limits(2))]);
axis equal
%grid off
axis off
view(2)
hold off

[x1,y1] = ginput(1);
[x2,y2] = ginput(1);

[p2,m2] = find( carte_x < x1 );
[p4,m4] = find( carte_y < y1 );

ind_x1 = max(p2);
ind_y1 = max(m4); 

[p1,m1] = find( carte_x < x2 );
[p3,m3] = find( carte_y < y2 );

ind_x2 = max(p1);
ind_y2 = max(m3); 

if ind_x1 > ind_x2
    max_x = ind_x1;
    min_x = ind_x2;
else 
    max_x = ind_x2;
    min_x = ind_x1;
end

if ind_y1 > ind_y2
    max_y = ind_y1;
    min_y = ind_y2;
else 
    max_y = ind_y2;
    min_y = ind_y1;
end

max_int_value = max(max(bio_map));
 [I,J] = find(bio_map == max_int_value) ;

id = 0;
size_map = size(carte_x);
map_color = bio_map;
for x_ind = min_x : max_x % récupère les indices
    for y_ind = min_y : max_y
        id = id + 1 ;
        bio_ind_tab(id) = bio_ind(x_ind,y_ind); % semble bien fonctionner
        map_color(x_ind,y_ind) = max_int_value;
    end
end
ind_peaks = 0;
for n = 1 : length(bio_ind_tab) % récupère les temps et les spectres associés aux indices
    ind_peaks = ind_peaks + 1 ;
    peaks(ind_peaks) = {bio_dat(bio_ind_tab(n)).peaks.mz};
    times(ind_peaks) = bio_dat(bio_ind_tab(n)).retentionTime;
end
peaks = peaks';
times = times';

resolution = 10000;

 figure()
% plot3(peaks(:,1),times, peaks(:,2));
[MZ,Y] = msppresample(peaks,resolution);
h = length(bio_ind_tab);
% subplot(1,2,1); % pour mettre a coté de la carte
 plot3(repmat(MZ,1,h),repmat(times',resolution,1),Y) % a terminer, mais fonctionne bien
% PLOT A RESOUDRE
xlabel('Mass/Charge (M/Z)')
ylabel('Retention Time')
zlabel('Relative Intensity')
%subplot(1,2,2);  % pour mettre a coté de la carte

figure()
s = surf(carte_x,carte_y,carte_z,map_color);
s.FaceAlpha=0.9; % niveau de tranparence
s.FaceColor = 'flat'; % set color interpolqtion
s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
title('Zone of the mass spectra');
axis equal
%grid off
axis off

si_p = size(peaks);

win = 0.1;
band = [200 1500];

%1ere ligne
peak_tab2 = peaks{1, 1}  ;
peak_tab3 = bining_norm(peak_tab2,win,band);
norm_peak_struct(1) = {peak_tab3};
peak_tab_norm_sum = peak_tab3;

for i = 2 : si_p(1)
    peak_tab2 = peaks{i, 1}  ;
    peak_tab3 = bining_norm(peak_tab2,win,band);
    norm_peak_struct(i) = {peak_tab3};
    peak_tab_norm_sum(:,2) = peak_tab_norm_sum(:,2) + peak_tab3(:,2);
end
    
figure()
plot(peak_tab_norm_sum(:,1),peak_tab_norm_sum(:,2));
xlabel('Mass/Charge (M/Z)')
ylabel('Relative Intensity')
title('Sum of all the spectra of the zone');

csv_spectra_recorder(peak_tab_norm_sum,"Test_sauv_somme.csv")


