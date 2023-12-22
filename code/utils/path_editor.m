function path  = path_editor(folder_name,file_name)

% Permet de choisir automatique le bon dossier pour l'enregistrement,
% quelquesoit le fichier dans lequel est stocké le code

% Return the good folder to record the file

workspace_dir = pwd;

if isunix % work for both Linux and Windows OS
    separator = '/';
elseif ispc
    separator = '\';
end

file_dir = strcat(separator,folder_name,separator);
repertory = strcat(workspace_dir, file_dir);
path = [repertory file_name];

