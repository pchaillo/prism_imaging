function OptionTab = folder_scan_without_extension(folder_name, ~)
% Recovers the names of files and folders
str = folder_scan(folder_name);
si =  size(str);
for i = 1 : si(2)
    newStr = split(str(i),'.');
    OptionTab(i) = newStr(1);
end