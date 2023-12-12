
function list_folders = find_folders_and_subfolders(folder_name)

folders = folder_scan(folder_name);
size_folders = size(folders);
disp(size_folders);
list_folders = folders;
if size_folders(2) > 0
    for i = 3 : size_folders(2)
        sub_folders = folder_scan_recursive(folder_name + "/" + folders(i));
        list_folders = list_folders + sub_folders;
        disp(list_folders);
    end
end
end