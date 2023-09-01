function OptionTab = folder_scan(folder_name)

listeFichiersCode = dir(folder_name) ;
si =  size(listeFichiersCode);
for i = 1 : si(1)
    str = convertCharsToStrings(listeFichiersCode(i).name);
    newStr = split(str,'.');
    OptionTab(i) = newStr(1);
end