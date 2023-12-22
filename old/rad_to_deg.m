function data = rad_to_deg(a)

a = (a/pi)*180;
data = "MoveJoints("+a(1)+","+a(2)+","+a(3)+","+a(4)+","+a(5)+","+a(6)+")"+char(0);
data = char(data);