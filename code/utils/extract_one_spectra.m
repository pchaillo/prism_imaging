

function extract_one_spectra(bio_dat,carte,limits)

carte_x = carte.x;
carte_y = carte.y;
carte_z = carte.z;

if isfield(carte,'time')
    carte_time = carte.time;
    time_flag = 1;
else
    time_flag = 0;
end

loud_flag = 1;
[ bio_ind ,bio_map ] = mzXML_on_map_norm13(bio_dat,carte_z,limits,carte_time,time_flag);
% [ bio_ind ,bio_map ] = data_on_map(bio_dat,carte_z,limits,carte_time,time_flag,loud_flag);

[ carte_x,carte_y,carte_z,bio_map  ] = fix_border_2(carte_x,carte_y,carte_z,bio_map,bio_ind);

figure()
hold on
s = surf(carte_x,carte_y,carte_z,bio_map);
 s.FaceColor = 'flat'; % set color interpolqtion
 s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
%title(['biometric map, mass limits : ', num2str(import_limits(1)),'  ',num2str(import_limits(2))]);
axis equal
%grid off
axis off
view(2)
hold off

%uiwait(helpdlg('Please click on the starting and ending points.'));
[x1,y1] = ginput(1);

% x_tab = carte_x(:,1);
% y_tab = carte_y(1,:)';
% 
% x_diff = abs(x_tab - x1);
% y_diff = abs(y_tab - y1);
% 
% ind_x = find(min(x_diff) == x_diff);
% ind_y = find(min(y_diff) == y_diff);

% min_diff_x = min(diff_tab_x);
% min_ind_x = find(diff_tab_x==min_diff_x);


%% Solution 1 
carte_x2 = carte_x - x1;
min_x = min(abs(carte_x2));

% [p1,m1] = find( carte_x > x1 );
[p2,m2] = find( carte_x < x1 );
% [p3,m3] = find( carte_y > y1 );
[p4,m4] = find( carte_y < y1 );

% min_x = min(p1);
max_x = max(p2);
% min_y = min(m3);
max_y = max(m4); 

ind_x = max_x;
ind_y = max_y;

ind_bio = bio_ind(ind_x,ind_y);

peaks = bio_dat(ind_bio).peaks.mz;
% times = bio_dat(ind_bio).retentionTime;

figure()
plot(peaks(:,1),peaks(:,2));
xlabel('Mass/Charge (M/Z)')
ylabel('Relative Intensity')