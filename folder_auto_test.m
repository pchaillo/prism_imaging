path(path,'code/code_for_recording')

% %v1
% listeFichiersCode = dir('./code/hardware/robot/*.m') ;
% 
% app.LaserDropDown.Items = listeFichiersCode
% 
% si =  size(listeFichiersCode)
%  for i = 1 : si(1)
%     i
%  end


% clc %v2
% clear all
% 
% listeFichiersCode = dir('./code/hardware/robot/*.m') ;
% si =  size(listeFichiersCode)
% for i = 1 : si(1)
%     str = convertCharsToStrings(listeFichiersCode(i).name)
%     newStr = split(str,'.')
%     Options_name_tab(i) = newStr(1)
% end

% v3
Folder_name = './code/hardware/robot/*.m';
OptionTab = folder_scan(Folder_name);