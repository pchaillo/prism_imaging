
function list_folders = find_folders_and_subfolders(folder_name)

[folders,files] = sort_folders_and_files(folder_name);
size_folders = size(folders);
if size_folders(1) > 0
    list_folders = [folders];
    for i = 1 : size_folders(1)
        sub_folders = find_folders_and_subfolders(folder_name + "/" + folders(i));
        list_folders = [list_folders;sub_folders];
    end
else 
    list_folders = [];
end
end