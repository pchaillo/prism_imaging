function csv_image_recorder(map,bio_dat,csv_name)



l = length(bio_dat); % useless

win = 0.1; % a mettre en argument
band = [100 1500];

peak_tab = bio_dat(1).peaks.mz;
peak_tab_clean = bining_2(peak_tab,win,band);
mz_ind_tab = peak_tab_clean(:,1)';
l = length(mz_ind_tab);

tab(1,6:6+l-1) = mz_ind_tab;

dim = size(carte.x);
u = 1;

for j = 1: 1 : dim(1) 
    for k = 1 : dim(2)
        u = u +1;
        u
        tab(u,1) = carte.x(j,k);
        tab(u,2) = carte.y(j,k);
        tab(u,3) = carte.z(j,k);
        tab(u,4) = carte.time(j,k);
        tab(u,6) = bio_dat(u-1).totIonCurrent; % -1 pcq la 1ère ligne est prise pour mettre les indices des rapports mz
        tab(u,7) = bio_dat(u-1).retentionTime; % -1 pcq la 1ère ligne est prise pour mettre les indices des rapports mz
       
        deiso = bio_dat(u-1).deisotoped;
        l2 = length(deiso);
        if l2 == 1 
            tab(u,8) = deiso;
            tab(u,9) = deiso;
        else 
            deiso_sort = sort(deiso);
            tab(u,8) = deiso_sort(1);
            tab(u,9) = deiso_sort(l2);
        end

        tab(u,10) = bio_dat(u-1).basePeakMz; % -1 pcq la 1ère ligne est prise pour mettre les indices des rapports mz
        tab(u,11) = bio_dat(u-1).basePeakIntensity; % -1 pcq la 1ère ligne est prise pour mettre les indices des rapports mz
       
        
        peak_tab = bio_dat(u-1).peaks.mz;
        peak_tab_clean = bining_2(peak_tab,win,band);
        tab(u,12:12+l-1) = peak_tab_clean(:,2)';
    end
end

cell = num2cell(tab');
cell{1,1} = "x";
cell{2,1} = "y";
cell{3,1} = "z";
cell{4,1} = "time";
cell{5,1} = "Cluster ind";
cell{6,1} = "totIonCurrent";
cell{7,1} = "retentionTime";
cell{8,1} = "Start Scan";
cell{9,1} = "End Scan";
cell{10,1} = "Base Peak Mz";
cell{11,1} = "Base Peak Intensity";

T = cell2table(cell);
writetable(T,csv_name)