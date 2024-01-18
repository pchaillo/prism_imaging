function extract_spectra_zone(app, pixels_scans,map,limits)

if isfield(map,'time')
    time_flag = 1;
else
    time_flag = 0;
end

pixels_scans = fix_ms_data(pixels_scans);

loud_flag = 0; % #TODO
[ pixels_ind, scans_ind, pixels_mz, fusion_tab] = data_on_map(app, pixels_scans,map,limits,map.time,time_flag,loud_flag);

[ map.x,map.y,map.z,pixels_mz ] = fix_border(map.x,map.y,map.z,pixels_mz,pixels_ind);

pixels_mz = replace_NaN_by_zero(pixels_mz);

title_str = "Select the area you want to extract by clicking";
display_mz_map(map,pixels_mz,title_str);

[x1,y1] = ginput(1);
[x2,y2] = ginput(1);

[p2,m2] = find( map.x < x1 );
[p4,m4] = find( map.y < y1 );

ind_x1 = max(p2);
ind_y1 = max(m4); 

[p1,m1] = find( map.x < x2 );
[p3,m3] = find( map.y < y2 );

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

max_int_value = max(max(pixels_mz));
% [I,J] = find(pixels_mz == max_int_value) ;

id = 0;
size_map = size(map.x);
map_color = pixels_mz;
for x_ind = min_x : max_x % récupère les indices
    for y_ind = min_y : max_y
        id = id + 1 ;
        selected_ind_array(id) = pixels_ind(x_ind,y_ind); % semble bien fonctionner
        map_color(x_ind,y_ind) = max_int_value;
    end
end

%% Plot multiple spectra

ind_peaks = 0;
for n = 1 : length(selected_ind_array) % récupère les temps et les spectres associés aux indices
    ind_peaks = ind_peaks + 1 ;
    peaks(ind_peaks) = {pixels_scans(selected_ind_array(n)).peaks.mz};
    times(ind_peaks) = pixels_scans(selected_ind_array(n)).retentionTime;
end
peaks = peaks';
times = times';

plot_multiple_spectra(peaks,times,length(selected_ind_array))

title_str = 'Selected area in yellow';
display_mz_map(map,map_color,title_str)

si_p = size(peaks);

win = 0.1;
band = [200 1500];

%f irst line % 1ere ligne
raw_peak_array = peaks{1, 1}  ;
fix_peak_array = bining_fixed_size(raw_peak_array,win,band);
all_selected_spectra_struct(1) = {fix_peak_array};
peak_sum_array = fix_peak_array;

for i = 2 : si_p(1)
    raw_peak_array = peaks{i, 1}  ;
    fix_peak_array = bining_fixed_size(raw_peak_array,win,band);
    all_selected_spectra_struct(i) = {fix_peak_array};
    peak_sum_array(:,2) = peak_sum_array(:,2) + fix_peak_array(:,2);
end

figure()
plot(peak_sum_array(:,1),peak_sum_array(:,2));
xlabel('Mass/Charge (M/Z)')
ylabel('Relative Intensity')
title('Sum of all the spectra of the zone');

csv_spectra_recorder(peak_sum_array,"Test_sauv_somme.csv") % fonction qui n'existe pas, appeler plutot csv_extractor #TODO
% #TODO : sauver tous les spectres dans un .csv et la somme dans un autre ?
