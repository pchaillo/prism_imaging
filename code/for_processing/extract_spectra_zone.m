function [selected_ind_list, map_color,min_max_list] = extract_spectra_zone(app, pixels_scans,map,limits,loud_flag,nom_mat)

if isfield(map,'time')
    time_flag = 1;
else
    time_flag = 0;
end

pixels_scans = fix_ms_data(pixels_scans);

[ pixels_ind, ~, pixels_mz, ~] = data_on_map(app, pixels_scans,map,limits,map.time,time_flag,loud_flag);

[ map.x,map.y,map.z,pixels_mz ] = fix_border(map.x,map.y,map.z,pixels_mz,pixels_ind);

pixels_mz = replace_NaN_by_zero(pixels_mz);

title_str = "Select the area you want to extract by clicking";
display_mz_map(map,pixels_mz,title_str)
view(2)
axis equal

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

id = 0;
size_map = size(map.x);
map_color = pixels_mz;
for x_ind = min_x : max_x % récupère les indices
    for y_ind = min_y : max_y
        id = id + 1 ;
        selected_ind_list(id) = pixels_ind(x_ind,y_ind); % semble bien fonctionner
        map_color(x_ind,y_ind) = max_int_value;
    end
end

min_max_list = [min_x max_x min_y max_y];
