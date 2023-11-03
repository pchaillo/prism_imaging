function set_pos(a,t)

% Pour envoyer une position à atteindre au MECA500

global robot

%a(6) = 180 % we should not do that !!
%disp('dirty fix here')

data = "MovePose("+a(1)+","+a(2)+","+a(3)+","+a(4)+","+a(5)+","+a(6)+")"+char(0);
data;
data = char(data);

robot.arret = security_check(a(1),a(2),a(3));

if robot.arret == 0
    fwrite(t,data);
  %  pause(0.01); % ?
   % h = 0;
    while t.BytesAvailable == 0 % && h < 100 % wait robot message
       % h = h + 1;
    end
    
    % read robot message
    data = fread(t, t.BytesAvailable);
    m = char(data);
    m1 = convertCharsToStrings(m);
    m2 = convertContainedStringsToChars(m1);
    m3 = m2(2 : 5 );
    u = str2double(m3);
    
    if u ~= 3012 && length(m) == 22
        robot.arret = 1;
    end
else
    disp('robot arrêté par sécurité');
end