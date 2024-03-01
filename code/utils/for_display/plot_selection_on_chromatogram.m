function plot_selection_on_chromatogram(pixels_scans,t_i,ion,topography_time_list,all_scans)
% Function that display the selected peaks on the chromatogram for visual checking

%avec meilleure fusion
% avec fusion collatérales

figure(); % plot les points choisis
hold on
plot(t_i,ion)
ind_fus = 0; % point fussionnes
ind_norm = 0; % peaks normaux
ind_ad = 0; % points ajoutes
ind_coll = 0; % Points qui resultent d'une fusion "collatérale"
for i = 1 :length(pixels_scans)
    %% pour scatter les points
    %if floor(pixels_scans(i).num) ~= pixels_scans(i).num
    if pixels_scans(i).centroided ~= 0
        ind_fus = ind_fus + 1 ;
        pk_fus(ind_fus) = pixels_scans(i).ionisationEnergy; % ou pixels_scans(i).centroided ?
        %         loc_r= pixels_scans(i).retentionTime;
        %         loc_rond(ind_rond) = raw_to_time(loc_r);
        loc_fus(ind_fus) = pixels_scans(i).retentionTime;
    elseif pixels_scans(i).num < 0
        ind_ad = ind_ad + 1;
        pk_ad(ind_ad) = pixels_scans(i).ionisationEnergy;
        %         loc_r = pixels_scans(i).retentionTime;
        %         loc_x(ind_x) = raw_to_time(loc_r);
        loc_ad(ind_ad) = pixels_scans(i).retentionTime;
    elseif pixels_scans(i).msLevel > 1
        ind_coll = ind_coll + 1;
        pk_coll(ind_coll) =  pixels_scans(i).ionisationEnergy;
        loc_coll(ind_coll) = pixels_scans(i).retentionTime;
    else
        ind_norm = ind_norm + 1 ;
        %         loc_r= pixels_scans(i).retentionTime;
        %         loc2(ind2) = raw_to_time(loc_r);
        loc_norm(ind_norm) = pixels_scans(i).retentionTime;
        pk_norm(ind_norm) = pixels_scans(i).ionisationEnergy;
    end
    %% pour plot les lignes d'écarts temporels
    
    if topography_time_list ~= 0
        
    int = pixels_scans(i).ionisationEnergy;
    time_dat = pixels_scans(i).retentionTime;
    time_map = topography_time_list(i);
    
%     time_line_x(i,:) = [time_dat int ];
%     time_line_y(i,:) = [time_map int ];

    time_line_x = [time_dat time_map];
    time_line_y = [int int ];
    
    plot(time_line_x,time_line_y);
    
    end
    
end

%     plot(time_line_x,time_line_y);

for i = 1 :length(all_scans)
    %% pour scatter les points
    %if floor(pixels_scans(i).num) ~= pixels_scans(i).num
    if all_scans(i).centroided ~= 0
        ind_fus = ind_fus + 1 ;
        pk_fus(ind_fus) = all_scans(i).ionisationEnergy; % ou pixels_scans(i).centroided ?
        %         loc_r= pixels_scans(i).retentionTime;
        %         loc_rond(ind_rond) = raw_to_time(loc_r);
        loc_fus(ind_fus) = all_scans(i).retentionTime;
    end
end

if exist('loc_norm')
    % plot(loc_norm,pk_norm,'*','red');
   s(1) = scatter(loc_norm,pk_norm,'*','red','DisplayName','Scan');
end
if exist('loc_coll')
    scatter(loc_coll,pk_coll,'o','red');
end
if exist('loc_fus')
    scatter(loc_fus,pk_fus,'*','m');
end
if exist('loc_ad')
    scatter(loc_ad,pk_ad,'d','b');
end

xlabel('Time (s)')
ylabel('TIC intensity')
title('Scan selection on chromatogram')
% axes()


hold off

% hIm = imshow('legend3.PNG') % Faire legend ? #TODO
% % hIm = imshow(rgbImage);
% hSP = imscrollpanel(hFig,hIm);
% set(hSP,'Units','normalized',...
%     'Position',[0 .1 1 .9])
% % 2. Add a Magnification Box and an Overview tool.
% hMagBox = immagbox(hFig,hIm);
% pos = get(hMagBox,'Position');
% set(hMagBox,'Position',[0 0 pos(3) pos(4)])
% imoverview(hIm)
% % 3. Get the scroll panel API to programmatically control the view.
% api = iptgetapi(hSP);
% % 4. Get the current magnification and position.
% mag = api.getMagnification();
% r = api.getVisibleImageRect();
% % 5. View the top left corner of the image.
% api.setVisibleLocation(0.5,0.5)
% truesize([50 50])
