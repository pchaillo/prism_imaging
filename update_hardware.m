% Launch this whenever a new hardware class is added!
% Note: I have really tried to make something cleaner, however scanning
% folders is not supported for compilation. As such, the next best thing I
% have found is to generate text files containing the names of each class
% before compilation. The contents of these files are used to populate
% dropdown menus for the various software methods and hardware classes.
% paths = ['./code/hardware/laser/*.m', '/code/hardware/robot/*.m', './code/hardware/sensor/*.m', './code/method/scan_selection/*.m'];

addpath(genpath('3d_export/'))
addpath(genpath('code'))
addpath(genpath('files'))

scan_methods_tab = folder_scan_without_extension('./code/method/scan_selection/*.m');
scan_methods = [];
for i = scan_methods_tab
   if i ~= "_template_(name_MUST_be_changed)"
     scan_methods=[scan_methods;i];
   end
end

laser_types_tab = folder_scan_without_extension('./code/hardware/laser/*.m');
laser_types = [];
for i = laser_types_tab
   if i ~= "_template_(name_MUST_be_changed)"
     laser_types=[laser_types;i];
   end
end

sensor_types_tab = folder_scan_without_extension('./code/hardware/sensor/*.m');
sensor_types = [];
for i = sensor_types_tab
   if i ~= "_template_(name_MUST_be_changed)"
     sensor_types=[sensor_types;i];
   end
end

robot_types_tab = folder_scan_without_extension('./code/hardware/sensor/*.m');
robot_types = [];
for i = robot_types_tab
   if i ~= "_template_(name_MUST_be_changed)"
     robot_types=[robot_types;i];
   end
end

scan_methods_names = fopen(strcat(pwd, "/code/method/scan_methods.txt"), 'W');
laser_types_names = fopen(strcat(pwd, "/code/hardware/laser_types.txt"), 'W');
sensor_types_names = fopen(strcat(pwd, "/code/hardware/sensor_types.txt"), 'W');
robot_types_names = fopen(strcat(pwd, "/code/hardware/robot_types.txt"), 'W');

for i = scan_methods
    fprintf(scan_methods_names, '%s\n', i);
end

for i = laser_types
    fprintf(laser_types_names, '%s\n', i);
end

for i = sensor_types
    fprintf(sensor_types_names, '%s\n', i);
end

for i = robot_types
    fprintf(robot_types_names, '%s\n', i);
end

fclose('all');
