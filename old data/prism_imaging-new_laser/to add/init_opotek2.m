function opotek = init_opotek2()

opotek = tcpip('192.168.0.59',10001,'NetworkRole','client');
fopen(opotek);

data = "LVERS";
data;
data = char(data);
fwrite(opotek,data);

while opotek.BytesAvailable == 0 % && h < 100 % wait robot message
    % h = h + 1;
end
data = fread(opotek, opotek.BytesAvailable);
m = char(data);
m1 = convertCharsToStrings(m);
m2 = convertContainedStringsToChars(m1);
m3 = m2(2 : 5 );
%u = str2double(m3);
if m3 == '3000'
    disp('Robot Connected')
end


fclose(opotek);