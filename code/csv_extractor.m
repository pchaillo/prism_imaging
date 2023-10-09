% Version avec le binning

function csv = csv_extractor(csv_map, csv_mat, band, win)

path(path,"code/code_for_analysing");
path(path,"code/code_for_recording");
path(path,"mat files");
path(path,"map files")

carte = load_map_fcn(csv_map);

load(csv_mat);

% l = length(bio_dat); % useless
% 
% win = win_size
% band = [mass_min, mass_max]

peak_tab = bio_dat(1).peaks.mz;
peak_tab_clean = bining_2(peak_tab,win,band);
mz_ind_tab = peak_tab_clean(:,1)';
l = length(mz_ind_tab);

tab(1,12:12+l-1) = mz_ind_tab; % Always modify accordingly when adding/subtracting information from bio_dat

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
cell{1,1} = "X";
cell{2,1} = "Y";
cell{3,1} = "Z";
cell{4,1} = "Time";
cell{5,1} = "Cluster index";
cell{6,1} = "TIC";
cell{7,1} = "Retention Time";
cell{8,1} = "Scan Start";
cell{9,1} = "Scan End";
cell{10,1} = "Base Peak Mz";
cell{11,1} = "Base Peak Intensity";

T = cell2table(cell);

export_name = erase(csv_map, '.map');
export_name = append(export_name, '.csv');

writetable(T,export_name)

movefile(export_name,"csv files")
% csvwrite("msi_data_test4_last.csv",tab')
disp('Successfuly exported data to a CSV file')
end
