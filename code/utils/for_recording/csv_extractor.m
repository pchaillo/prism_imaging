% Version avec le binning
% Band = [M/z_min, M/z_max] 
% Win = Binning window in M/z

function csv = csv_extractor(csv_map, csv_mat, band, win)

    % #TODO = fonction trop lente ?

path(path,"code/code_for_analysing");
path(path,"code/code_for_recording");
path(path,"code/code_for_export");
path(path,"mat files");
path(path,"map files");

map = load_map_fcn(csv_map);

load(csv_mat); % to load the pixels scans variable from mat files

peak_array = pixels_scans(1).peaks.mz;
peak_array_fixed = bining_fixed_size(peak_array,win,band);
mz_list = peak_array_fixed(:,1)';
l = length(mz_list);

data_array_for_extraction(1,12:12+l-1) = mz_list; % Always modify accordingly when adding/subtracting information from pixels_scans

dim = size(map.x);
%%%%%%%%%%%%%%%%%%%%%%%%%% Stripped version of num_to_position for better
%%%%%%%%%%%%%%%%%%%%%%%%%% performance
pixels_number = length(pixels_scans);

dimX = dim(2);

num_order = zeros(1, pixels_number);
countdown = dimX;
for position = 1:pixels_number
    quotient = floor((position-1)/dimX);
    if mod(quotient, 2) == 0
        num_order(position) = pixels_scans(position).num;
    else
        num_order(position) = pixels_scans(position + countdown - 1).num;
        countdown = countdown - 2;
        if countdown == -dimX
            countdown = dimX;
        end
    end
end

[~, index] = sort(abs(num_order)); % Order in which to pick molecular data sorted time-wise to reconstruct
                                   % spatial sorting
%%%%%%%%%%%%%%%%%%%%%%%%%%
data_ind = 1; % Sort absolute nums in increasing order in num_order_table, and fetch the corresponding order 
% number instead of data_ind

for x_ind = 1: 1 : dim(1)
    for y_ind = 1 : dim(2)
%         v = index(data_ind);
        data_ind = data_ind +1;
        data_ind
        data_array_for_extraction(data_ind,1) = map.x(x_ind,y_ind);
        data_array_for_extraction(data_ind,2) = map.y(x_ind,y_ind);
        data_array_for_extraction(data_ind,3) = map.z(x_ind,y_ind);
        data_array_for_extraction(data_ind,4) = map.time(x_ind,y_ind);
        data_array_for_extraction(data_ind,6) = pixels_scans(index(data_ind-1)).totIonCurrent; % -1 pcq la 1ère ligne est prise pour mettre les indices des rapports mz
        data_array_for_extraction(data_ind,7) = pixels_scans(index(data_ind-1)).retentionTime; % -1 pcq la 1ère ligne est prise pour mettre les indices des rapports mz

        fusion_list = pixels_scans(index(data_ind-1)).deisotoped;
        l2 = length(fusion_list);
        if l2 == 1
            data_array_for_extraction(data_ind,8) = fusion_list;
            data_array_for_extraction(data_ind,9) = fusion_list;
        else
            sorted_fusion_list = sort(fusion_list);
            data_array_for_extraction(data_ind,8) = sorted_fusion_list(1);
            data_array_for_extraction(data_ind,9) = sorted_fusion_list(l2);
        end

        data_array_for_extraction(data_ind,10) = pixels_scans(index(data_ind-1)).basePeakMz; % -1 pcq la 1ère ligne est prise pour mettre les indices des rapports mz
        data_array_for_extraction(data_ind,11) = pixels_scans(index(data_ind-1)).basePeakIntensity; % -1 pcq la 1ère ligne est prise pour mettre les indices des rapports mz


        peak_array = pixels_scans(index(data_ind-1)).peaks.mz;
        peak_array_fixed = bining_fixed_size(peak_array,win,band);
        data_array_for_extraction(data_ind,12:12+l-1) = peak_array_fixed(:,2)';
    end
end

cell = num2cell(data_array_for_extraction');
cell{1,1} = "x";
cell{2,1} = "y";
cell{3,1} = "z";
cell{4,1} = "Time";
cell{5,1} = "Cluster index";
cell{6,1} = "TIC";
cell{7,1} = "Retention Time";
cell{8,1} = "Scan Start";
cell{9,1} = "Scan End";
cell{10,1} = "Base Peak Mz";
cell{11,1} = "Base Peak Intensity";

data_table = cell2table(cell);

export_name = erase(csv_map, '.map');
export_name = append(export_name, '.csv');

writetable(data_table,export_name)

movefile(export_name,"files/csv files")
% csvwrite("msi_data_test4_last.csv",data_array_for_extraction')
disp('Successfuly exported data to a CSV file')
end
