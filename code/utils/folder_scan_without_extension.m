function OptionTab = folder_scan_without_extension(folder_name)
% Récupère le nom des fichiers ET dossiers 
str = folder_scan(folder_name);
si =  size(str);
for i = 1 : si(2)
    newStr = split(str(i),'.');
    OptionTab(i) = newStr(1);
end