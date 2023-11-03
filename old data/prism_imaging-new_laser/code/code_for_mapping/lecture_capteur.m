function valeur = lecture_capteur(ard)

stop = 0;

nb_err = 0;

nb_err_attente = 10;

while stop == 0
    pause(0.05)
    u = readVoltage(ard , 'A1'); % ressort la tension en V
    if u < 0.75
        %disp('lecture capteur impossible')
        nb_err = nb_err + 1 ;
        if nb_err > nb_err_attente
            valeur = 0 % peut etre trouver une meilleure solution ?
            stop = 1;
        end
    else
        valeur = u
        stop = 1;
    end
    
end

