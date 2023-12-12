function [folders,files] = sort_folders_and_files(folder_name)
    files_and_folders = folder_scan(folder_name);
    si = size(files_and_folders);
    folders= [];
    files= [];
for i = 3 : si(2)
    sub = folder_scan(folder_name+"/"+files_and_folders(i));
    if sub(1) == "." && sub(2) == ".."  
        folders = [folders;files_and_folders(i)];
    else
        files = [files;files_and_folders(i)];
    end
end