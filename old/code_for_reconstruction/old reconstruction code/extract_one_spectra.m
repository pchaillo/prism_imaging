

function extract_one_spectra(bio_dat,carte,limits)

carte_x = carte.x;
carte_y = carte.y;
carte_z = carte.z;
seuil = -1;

if isfield(carte,'time')
    carte_time = carte.time;
    [ bio_ind ,bio_map ] = mzXML_on_map_norm11(bio_dat,carte_z,limits,carte_time); % put the information on the map
else
    [ bio_ind ,bio_map ] = mzXML_on_map_norm8_3(bio_dat,carte_z,limits,seuil); % put the information on the map
end

[ carte_x,carte_y,carte_z,bio_map  ] = add_border(carte_x,carte_y,carte_z,bio_map);

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


%% Solution 1 - ne fonctionne pas parfaitement
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