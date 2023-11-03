function ok = reset_error(t)

% Pour supprimer l'etat d'erreur du MECA500

global robot

%a(6) = 180 % we should not do that !!
%disp('dirty fix here')

data = ['ResetError' char(0)];
fwrite(t,data)

while t.BytesAvailable == 0 % && h < 100 % wait robot message
end

data = fread(t, t.BytesAvailable);
m = char(data);
m1 = convertCharsToStrings(m);
m2 = convertContainedStringsToChars(m1);
m3 = m2(2 : 5 );
u = str2double(m3);

if u == 2005 || u == 2006 
    disp('Erreur OK');
    ok = 1;
else 
    ok = 0;
end
