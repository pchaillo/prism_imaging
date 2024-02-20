% DEBUG
csv_map = "M15_T2_corrected.map";
csv_mat = "M15_T2.mat";
band = [0 2000];
win = 0.1;

path(path,"code/utils/for_recording");
path(path,"code/for_processing");
path(path,"files/mat files");
path(path,"files/map files");

map = load(csv_map);

load(csv_mat); % to load the pixel scans from mat files

peak_array = pixels_scans(1).peaks.mz;
peak_array_fixed = bining_fixed_size(peak_array,win,band);
mz_list = peak_array_fixed(:,1)';
l = length(mz_list);

% data_array_for_extraction(1,12:12+l-1) = mz_list; % Always modify accordingly when adding/subtracting information from pixels_scans

% dim = size(map.x);
% %%%%%%%%%%%%%%%%%%%%%%%%%% Stripped version of num_to_position for better
% %%%%%%%%%%%%%%%%%%%%%%%%%% performance
% pixels_number = length(pixels_scans);
% 
% dimX = dim(2);
% 
% num_order = zeros(1, pixels_number);
% countdown = dimX;
% for position = 1:pixels_number
%     quotient = floor((position-1)/dimX);
%     if mod(quotient, 2) == 0
%         num_order(position) = pixels_scans(position).num;
%     else
%         num_order(position) = pixels_scans(position + countdown - 1).num;
%         countdown = countdown - 2;
%         if countdown == -dimX
%             countdown = dimX;
%         end
%     end
% end
% 
% [~, index] = sort(abs(num_order)); % Order in which to pick molecular data sorted time-wise to reconstruct
%                                    % spatial sorting
%%%%%%%%%%%%%%%%%%%%%%%%%%
% data_ind = 1; % Sort absolute nums in increasing order in num_order_table, and fetch the corresponding order 
% number instead of data_ind

total_pixels = map(1,1)*map(1,2);
data_array_for_extraction = zeros(total_pixels, 12+l-1);

parfor ind = 1:total_pixels
    temp = zeros(1, 12+l-1);
    temp(1) = map(ind+1, 1);
    temp(2) = map(ind+1, 2);
    temp(3) = map(ind+1, 3);
    temp(4) = map(ind+1, 4);
    temp(6) = pixels_scans(ind).totIonCurrent;
    temp(7) = pixels_scans(ind).retentionTime;

    fusion_list = pixels_scans(ind).deisotoped;
    l2 = length(fusion_list);
    if l2 == 1
        temp(8) = fusion_list;
        temp(9) = fusion_list;
    else
        sorted_fusion_list = sort(fusion_list);
        temp(8) = sorted_fusion_list(1);
        temp(9) = sorted_fusion_list(l2);
    end
    temp(10) = pixels_scans(ind).basePeakMz;
    temp(11) = pixels_scans(ind).basePeakIntensity;

    peak_array = pixels_scans(ind).peaks.mz;
    peak_array_fixed = bining_fixed_size(peak_array,win,band);
    temp(12:12+l-1) = peak_array_fixed(:,2);

    data_array_for_extraction(ind, :) = temp;
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