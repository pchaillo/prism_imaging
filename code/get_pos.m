% Pour récupérer la position actuelle du robot
% Envoie la trame de commande + reception de la reponse

function u3 = get_pos(t)

% % clean buffer
% data = fread(t, t.BytesAvailable);
% mesg = char(data);
% message1 = convertCharsToStrings(mesg);


% data = ['GetJoints' char(0)];
data = ['GetPose' char(0)];
fwrite(t,data)
%pause(0.05);
while t.BytesAvailable == 0 % attend le message
end
data = fread(t, t.BytesAvailable);
m = char(data);
m1 = convertCharsToStrings(m);
m2 = convertContainedStringsToChars(m1);
l = length(m2);
m3 = m2(8 : l-2);
u = split(m3,',');
u2 = str2double(u);
u3 = u2';
%pause(1)