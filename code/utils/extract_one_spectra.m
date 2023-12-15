

function extract_one_spectra(pixels_scans,map,name_map,limits)


if isfield(map,'time')
    time_flag = 1;
else
    time_flag = 0;
end

loud_flag = 1;
[ bio_ind ,pixels_mz ] = mzXML_on_map_norm13(pixels_scans,map.z,limits,map.time,time_flag);
% [ bio_ind ,bio_map ] = data_on_map(pixels_scans,carte_z,limits,carte_time,time_flag,loud_flag); % not working ? #TODO

[ map.x,map.y,map.z,pixels_mz  ] = fix_border_2(map.x,map.y,map.z,pixels_mz,bio_ind);

% figure() % fonction d'affichage a factoriser #TODO
% hold on
% s = surf(carte_x,carte_y,carte_z,bio_map);
%  s.FaceColor = 'flat'; % set color interpolqtion
%  s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
% %title(['biometric map, mass limits : ', num2str(import_limits(1)),'  ',num2str(import_limits(2))]);
% axis equal
% %grid off
% axis off
% view(2)
% hold off

display_mz_map(map,pixels_mz)

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

ind_x = max_x;
ind_y = max_y;

ind_bio = bio_ind(ind_x,ind_y);

peaks = pixels_scans(ind_bio).peaks.mz;
% times = pixels_scans(ind_bio).retentionTime;
csv_filename = "files/csv files/"+name_map(1:end-4)+"_x_"+ind_x+"_y_"+ind_y+".csv";
export_spectra_to_csv(peaks,csv_filename);
figure();
plot(peaks(:,1),peaks(:,2));
xlabel('Mass/Charge (M/Z)');
ylabel('Relative Intensity');