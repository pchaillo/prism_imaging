function csv = csv_extractor(app, csv_map, csv_mat, band, win)

% Band = [M/z_min, M/z_max] 
% Win = Binning window in M/z
% One of those names needs to change, too unclear #TODO

map = load(csv_map);

m = load(csv_mat); % Without loading the pixel scans as an object, MatLab throws a hissy fit and refuses to use in inside the loop
m = m.pixels_scans;

disp("Files loaded. Starting preprocessing.")

peak_array = m(1).peaks.mz;
peak_array_fixed = binning_fixed_size(peak_array, win, band);
mz_list = peak_array_fixed(:,1)'; % ' to transpose the array
l = length(mz_list);

% Time correction

%%%%%%%%%%%%%%%%%%%%%%%%%% Stripped version of num_to_position for better
%%%%%%%%%%%%%%%%%%%%%%%%%% performance

pixels_number = length(m);
 
dimX = map(1,2);
 
num_order = zeros(1, pixels_number);
countdown = dimX;
for position = 1:pixels_number
    quotient = floor((position-1)/dimX);
    if mod(quotient, 2) == 0
        num_order(position) = position;
    else
        num_order(position) = position + countdown - 1;
        countdown = countdown - 2;
        if countdown == -dimX
            countdown = dimX;
        end
    end
end
 
%%%%%%%%%%%%%%%%%%%%%%%%%%
% data_ind = 1; % Sort absolute nums in increasing order in num_order_table, and fetch the corresponding order 
% number instead of data_ind

total_pixels = map(1,1)*map(1,2);

% Preallocate a cell array to store temporary results
%temp_results = cell(total_pixels, 1);
x = map(2:end, 1);
y = map(2:end, 2);
z = map(2:end, 3);
time = map(2:end, 4);
tic = [];
rt = [];
deisotoped = {};
bp = [];
bpi = [];
mz = {};

disp('Deconstructing the mat file...')
for i = 1:total_pixels
    pixel_id = num_order(i);
    tic(i) = m(pixel_id).totIonCurrent;
    rt(i) = m(pixel_id).retentionTime;
    deisotoped{i} = m(pixel_id).deisotoped;

    if isempty(m(pixel_id).basePeakMz)
        bp(i) = 0;
    else
        bp(i) = m(pixel_id).basePeakMz;
    end 

    if isempty(m(pixel_id).basePeakIntensity)
        bpi(i) = 0;
    else
        bpi(i) = m(pixel_id).basePeakIntensity;
    end

    if isempty(m(pixel_id).peaks.mz)
        mz{i} = [0 0];
    else
        mz{i} = m(pixel_id).peaks.mz;
    end
end 

clear m num_order map pixels_number
disp('Done. Starting data processing.')


%temp_results(1,12:12+l-1) = mz_list; % Always modify accordingly when adding/subtracting information from pixels_scans
csv_cell = num2cell(zeros(total_pixels + 1, 1));
csv_cell{1,1} = ["x", "y", "z", "Time", "Cluster index", "TIC", "Retention Time", "Scan Start", "Scan End", "Base Peak m/Z", "Base Peak Intensity", string(mz_list)];

parfor ind = 1:total_pixels
    % update_log(app, ind)
    disp(ind) % #TODO : Replace with percentage of completion

    % Use a temporary variable to store the data
    temp = zeros(1, 12 + l - 1);
    temp(1) = x(ind); % Y
    temp(2) = y(ind); % X
    temp(3) = z(ind); % Z
    temp(4) = time(ind); % Time
    temp(6) = tic(ind);
    temp(7) = rt(ind);

    fusion_list = deisotoped{ind};
    l2 = length(fusion_list);

    if l2 == 1
        temp(8) = fusion_list;
        temp(9) = fusion_list;
    else
        sorted_fusion_list = sort(fusion_list);
        temp(8) = sorted_fusion_list(1);
        temp(9) = sorted_fusion_list(l2);
    end

    temp(10) = bp(ind);
    temp(11) = bpi(ind);

    peak_array_fixed = binning_fixed_size(mz{ind}, win, band);
    temp(12:12+l-1) = peak_array_fixed(:, 2);

    % Store the temporary variable in the cell array
    csv_cell{ind+1} = temp;
end

csv_concatenate = {};
parfor i=1:length(csv_cell)
    csv_concatenate = [csv_concatenate, csv_cell{i}];
end
csv_export = reshape(csv_concatenate, [], total_pixels + 1); % Needs a header row

clear csv_concatenate csv_cell

% Concatenate the results from the cell array into the final array
export_name = strrep(csv_mat, '.mat', ".csv");
header_row = num2cell(zeros(1, total_pixels + 1));

for i = 1:total_pixels + 1
    header_row{1, i} = i;
end

header_row{1,1} = "Data Type";
csv_export = vertcat(header_row, csv_export);

disp('Data successfuly sorted. Creating the CSV file. This may take a while...')

writematrix(csv_export, export_name)

%fcell2csv(export_name, csv_export)

out_path = strrep(app.map_path, "map_files", "csv_files");
movefile(export_name, out_path)

sentence = strcat("File saved in: ", export_name);
update_log(app, sentence)

end
