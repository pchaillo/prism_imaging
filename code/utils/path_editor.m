function path  = path_editor(folder_name,file_name)

% Automatically picks the proper folder to record a file, no matter where
% the file is stored

% Return the proper folder to record the file

workspace_dir = pwd;

if isunix % works for both Linux and Windows OS
    separator = '/';
elseif ispc
    separator = '\';
end

file_dir = strcat(separator, folder_name, separator);
repertory = strcat(workspace_dir, file_dir);
path = [repertory file_name];

