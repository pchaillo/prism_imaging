function close_tcp_r(t)

% Pour desactiver le MECA500 et fermer sa connecion TCP/IP

if t.BytesAvailable ~= 0 % && h < 100 % wait robot message
    data_r = fread(t, t.BytesAvailable); %vide le buffer
end

data = ['DeactivateRobot' char(0)];
fwrite(t,data)
pause(0.1)

while t.BytesAvailable == 0 % && h < 100 % wait robot message
    % h = h + 1;
end
data = fread(t, t.BytesAvailable);
m = char(data);
m1 = convertCharsToStrings(m);
m2 = convertContainedStringsToChars(m1);
m3 = m2(2 : 5 );
u = str2double(m3);
if m3 == '2004'
    disp('Robot Desactivated')
end

pause(0.01)
fclose(t);

%disp('Robot deactivated')

