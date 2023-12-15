function str = folder_scan(folder_name)

listeFichiersCode = dir(folder_name) ;
si =  size(listeFichiersCode);

for i = 1 : si(1)
    str(i) = convertCharsToStrings(listeFichiersCode(i).name);
end