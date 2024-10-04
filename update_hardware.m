% Launch this whenever a new hardware class is added!
% Note: I have really tried to make something cleaner, however scanning
% folders is not supported for compilation. As such, the next best thing I
% have found is to generate text files containing the names of each class
% before compilation. The contents of these files are used to populate
% dropdown menus for the various software methods and hardware classes.
% paths = ['./code/hardware/laser/*.m', '/code/hardware/robot/*.m', './code/hardware/sensor/*.m', './code/method/scan_selection/*.m'];

addpath(genpath('code'))
addpath(genpath('files'))

csv_normalization_tab = folder_scan_without_extension('./code/method/csv_normalization/*.py');
norm_types = [];
for i = csv_normalization_tab
   if i ~= "_Template_"
     norm_types=[norm_types;i];
   end
end

mass_spectrometer_tab = folder_scan_without_extension('./code/hardware/mass_spectrometer/*.m');
ms_types = [];
for i = mass_spectrometer_tab
   if i ~= "_template_(name_MUST_be_changed)"
     ms_types=[ms_types;i];
   end
end

robot_types_tab = folder_scan_without_extension('./code/hardware/robot/*.m');
robot_types = [];
for i = robot_types_tab
   if i ~= "_template_(name_MUST_be_changed)"
     robot_types=[robot_types;i];
   end
end

scan_methods_tab = folder_scan_without_extension('./code/method/scan_selection/*.m');
scan_methods = [];
for i = scan_methods_tab
   if i ~= "_template_(name_MUST_be_changed)"
     scan_methods=[scan_methods;i];
   end
end

sensor_types_tab = folder_scan_without_extension('./code/hardware/sensor/*.m');
sensor_types = [];
for i = sensor_types_tab
   if not(ismember(i, ["_template_(name_MUST_be_changed)", "AnalogicSensorBase", "NumericSensorBase"]))
     sensor_types=[sensor_types;i];
   end
end

source_types_tab = folder_scan_without_extension('./code/hardware/source/*.m');
source_types = []; %Formerly "laser_types"
for i = source_types_tab
   if i ~= "_template_(name_MUST_be_changed)"
     source_types=[source_types;i];
   end
end

csv_normalization_tab_names = fopen(strcat(pwd, "/code/method/csv_normalization/csv_normalization_types.txt"), 'W');
mass_spectrometer_types_names = fopen(strcat(pwd, "/code/hardware/mass_spectrometer_types.txt"), 'W');
robot_types_names = fopen(strcat(pwd, "/code/hardware/robot_types.txt"), 'W');
scan_methods_names = fopen(strcat(pwd, "/code/method/scan_methods.txt"), 'W');
sensor_types_names = fopen(strcat(pwd, "/code/hardware/sensor_types.txt"), 'W');
source_types_names = fopen(strcat(pwd, "/code/hardware/source_types.txt"), 'W');

for i = norm_types
    fprintf(csv_normalization_tab_names, '%s\n', i);
end

for i = ms_types
    fprintf(mass_spectrometer_types_names, '%s\n', i);
end

for i = robot_types
    fprintf(robot_types_names, '%s\n', i);
end

for i = scan_methods
    fprintf(scan_methods_names, '%s\n', i);
end

for i = sensor_types
    fprintf(sensor_types_names, '%s\n', i);
end

for i = source_types
    fprintf(source_types_names, '%s\n', i);
end

fclose('all');
