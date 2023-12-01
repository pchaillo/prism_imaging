function chemin  = choix_chemin(folder_name,file_name)

% Permet de choisir automatique le bon dossier pour l'enregistrement,
% quelquesoit le fichier dans lequel est stocké le code

% Return the good folder to record the file

workspace_dir = pwd;

if isunix % work for both Linux and Windows OS
    sep = '/';
elseif ispc
    sep = '\';
end

fichier_dir = strcat(sep,folder_name,sep);
repertoire = strcat(workspace_dir, fichier_dir);
chemin = [repertoire file_name];

