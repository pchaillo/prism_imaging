function  t = init_tcp()

% Initialise la connexion avec le robot MECA500

% Connexion
t = tcpip('192.168.0.100',10000,'NetworkRole','client');
fopen(t);
pause(0.1);

ok = 1;

while t.BytesAvailable == 0 % && h < 100 % wait robot message
    % h = h + 1;
end
data = fread(t, t.BytesAvailable);
m = char(data);
m1 = convertCharsToStrings(m);
m2 = convertContainedStringsToChars(m1);
m3 = m2(2 : 5 );
%u = str2double(m3);
if m3 == '3000'
    disp('Robot Connected')
end

%Activation
%disp('Activation of the robot')
data = ['ActivateRobot' char(0)];
fwrite(t,data)
pause(0.1);
%pause(5);
while t.BytesAvailable == 0 % && h < 100 % wait robot message
    % h = h + 1;
end
data = fread(t, t.BytesAvailable);
m = char(data);
m1 = convertCharsToStrings(m);
m2 = convertContainedStringsToChars(m1);
m3 = m2(2 : 5 );
if m3 == '2000'
    disp('Robot Activated')
elseif m3 == '1011'
    disp('Robot is in error')
    ok = 0;
end

% Home
data = ['Home' char(0)];
fwrite(t,data)
%pause(8); % 10
pause(0.1);
while t.BytesAvailable == 0 % && h < 100 % wait robot message
    % h = h + 1;
end
data = fread(t, t.BytesAvailable);
m = char(data);
m1 = convertCharsToStrings(m);
m2 = convertContainedStringsToChars(m1);
m3 = m2(2 : 5 );
if m3 == '2002'
    disp('Robot Homed')
end

% while t.BytesAvailable == 0 % && h < 100 % wait robot message
%     % h = h + 1;
% end
% data = fread(t, t.BytesAvailable);
% m = char(data);
% m1 = convertCharsToStrings(m);
% m2 = convertContainedStringsToChars(m1);
% m3 = m2(2 : 5 );
% u = str2double(m3);
% if m3 == '2002'
%     disp('Homed')
% end

data = ['SetJointVel(15)' char(0)]; % set the percentage of maximum velocity, at 25% by default.
fwrite(t,data)
% while t.BytesAvailable == 0 % && h < 100 % wait robot message
% end
% data = fread(t, t.BytesAvailable);
% m = char(data);
% m1 = convertCharsToStrings(m);
% m2 = convertContainedStringsToChars(m1);
% m3 = m2(2 : 5 );
% % if m3 == '2002' %% A ADAPTER A LA REPONSE
% %     disp('Robot Homed')
% % end
    
data = ['SetBlending(90)' char(0)]; % désactive l'optimisation de trajectoire
fwrite(t,data)
% disp('pos init - 0 ')
% data = ['MoveJoints(90,0.000,0.000,0.000,0.000,0.000)' char(0)];
% fwrite(t,data)
%  pause(8); % 10
 
 %%% Vide le buffer %%%
if t.BytesAvailable ~= 0 % && h < 100 % wait robot message
    data_r = fread(t, t.BytesAvailable); %vide le buffer
end

%%% Position retour dans la boite %%%
% data = ['MoveJoints(0,-60.000,60.000,0.000,25.000,0.000)' char(0)];

if ok == 0
    t = 0;
end