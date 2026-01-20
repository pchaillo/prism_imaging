function plot_selection_on_chromatogram(pixels_scans,t_i,ion,topography_time_list,all_scans)
% Function that display the selected peaks on the chromatogram for visual checking, distinguishing the different type of scan selection with a diferent symbol

figure();
hold on
plot(t_i,ion)
ind_fus = 0; % ENG : Merged scans / FR : point fusionnés
ind_norm = 0; % Classically selected scan
ind_ad = 0; % Empty added scans to ensure good data positioning
ind_coll = 0; % ENG : Scan that contain merged data // FR : scans qui resultent d'une fusion "collatérale"

for i = 1 :length(pixels_scans)
    if pixels_scans(i).centroided == -1 
        ind_fus = ind_fus + 1 ;
        pk_fus(ind_fus) = pixels_scans(i).ionisationEnergy; 
        loc_fus(ind_fus) = pixels_scans(i).retentionTime;
    elseif pixels_scans(i).num < 0 % num < 0 so it's an empty point added to fill the empty part of the image
        ind_ad = ind_ad + 1;
        pk_ad(ind_ad) = pixels_scans(i).ionisationEnergy;
        loc_ad(ind_ad) = pixels_scans(i).retentionTime;
    elseif pixels_scans(i).msLevel > 1
        ind_coll = ind_coll + 1;
        pk_coll(ind_coll) =  pixels_scans(i).ionisationEnergy;
        loc_coll(ind_coll) = pixels_scans(i).retentionTime;
    else
        ind_norm = ind_norm + 1 ;
        pk_norm(ind_norm) = pixels_scans(i).ionisationEnergy;
        loc_norm(ind_norm) = pixels_scans(i).retentionTime;
    end

    
    if topography_time_list ~= 0  % to plot the line between the selected scan and the time recorded during acquisition  
        int = pixels_scans(i).ionisationEnergy;
        time_dat = pixels_scans(i).retentionTime;
        time_map = topography_time_list(i);
        time_line_x = [time_dat time_map];
        time_line_y = [int int ];
        plot(time_line_x,time_line_y);  
    end
    
end

for i = 1 :length(all_scans) % to add the merged points that are not in the initially selected scan list
    if all_scans(i).centroided == -1
        ind_fus = ind_fus + 1 ;
        pk_fus(ind_fus) = all_scans(i).ionisationEnergy; 
        loc_fus(ind_fus) = all_scans(i).retentionTime;
    end
end


if exist('loc_norm')
   s(1) = scatter(loc_norm,pk_norm,'*','red','DisplayName','Scan');
end
if exist('loc_coll')
    scatter(loc_coll, pk_coll, 'o', 'red');
end
if exist('loc_fus')
    scatter(loc_fus, pk_fus, '*', 'm');
end
if exist('loc_ad')
    scatter(loc_ad, pk_ad, 'd', 'b');
end

xlabel('Time (s)')
ylabel('TIC Intensity (A.U.)')
title('Selected scans on the chromatogram')


hold off
