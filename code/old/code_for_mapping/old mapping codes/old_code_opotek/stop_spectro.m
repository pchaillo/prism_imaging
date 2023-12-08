% Ne marche pas => a priori l'arrêt du spectro par ce genre de commande est
% impossible sans que des accès nous soient fournis par le constructeur du
% spectromètre de masse

function stop_spectro(a)

writeDigitalPin(a,'A4',0) 
pause(0.1)

writeDigitalPin(a,'A4',1)