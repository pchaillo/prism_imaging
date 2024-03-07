function extract_one_spectra(app, pixels_scans,map,name_map,limits,loud_flag)


if isfield(map,'time')
    time_flag = 1;
else
    time_flag = 0;
end

[ pixels_ind, ~, pixels_mz, ~] = data_on_map(app, pixels_scans,map,limits,map.time,time_flag,loud_flag);

[ map.x,map.y,map.z,pixels_mz  ] = fix_border(map.x,map.y,map.z,pixels_mz,pixels_ind);

pixels_mz = replace_NaN_by_zero(pixels_mz);
% pixels_mz = replace_NaN_by_zero(pixels_mz); % two times ? #TODO

title_str = "Pick the pixel that you want to extract the spectra";
display_mz_map(map,pixels_mz,title_str)

[x1,y1] = ginput(1);

map.x2 = map.x - x1;
min_x = min(abs(map.x2));

% [p1,m1] = find( carte_x > x1 );
[p2,m2] = find( map.x < x1 );
% [p3,m3] = find( carte_y > y1 );
[p4,m4] = find( map.y < y1 );

% min_x = min(p1);
max_x = max(p2);
% min_y = min(m3);
max_y = max(m4); 

ind_x = max_x; % indices of the selected pixel in the image
ind_y = max_y;

selected_ind = pixels_ind(ind_x,ind_y); % indice of the selected pixel in the pixels_scans

peaks_array = pixels_scans(selected_ind).peaks.mz;
% times = pixels_scans(ind_bio).retentionTime;
csv_filename = "files/csv files/"+name_map(1:end-4)+"_x_"+ind_x+"_y_"+ind_y+".csv";

export_spectra_to_csv(peaks_array,csv_filename);
disp(csv_filename)

figure();
plot(peaks_array(:,1),peaks_array(:,2));
xlabel('Mass/Charge (M/Z)');
ylabel('Relative Intensity');
