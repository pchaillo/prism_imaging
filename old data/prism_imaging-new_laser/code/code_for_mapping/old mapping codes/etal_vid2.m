function new_tab = etal_vid2(t,ard)

% do the calibration of the new sensor (ILD1320-25 Microepsilon)

global scan
global zone

disp('Etallonage en cours')

u = 0;
k = 0;
f = 0;
d = 0;

pas = scan.etal;

plage_capt = 25; %plage de mesure du capteur en mm

% hauteur de début de l'étalonnage : dépend de la distance entre la caméra et le pointeur laser => plus la caméra et le laser sont proches, plus on peut commencer la calibration bas
i_d = 71 + scan.s_offset -0.25; % height of the beginnig of the calibration (71 cool)
i_f = i_d + plage_capt ;

i = i_d;

pos_x = zone.dec;
pos_y = 0;

a = [pos_x pos_y i 180 0 180 ];
set_pos(a,t);
pause(7)

while u == 0
    
    k = k + 1;
    
    if mod(k,100) == 0
        
        tension = lecture_capteur(ard);
       % valeur = readVoltage(ard,'A1');
        
        if f == 0 % pour déterminer si on monte ou si on descend
            i = i + pas;
            if i == i_f % si la hauteur finale est atteinte, on commence à redescendre
                f = 1;
            end
        else
            i = i - pas;
            if i == i_d + 0.25% lorsqu'on est revenu à la position initiale, l'étalonnage s'arrete
                u = 1;
            end
        end
        
        if i < 50 % i étant la hauteur de l'effecteur, il s'agit d'une sécurité pour arrêter la calibration si le robot s'approche trop près du sol
            u = 1;
            disp('arret de l etalonnage par securite')
        end
        
        a = [pos_x pos_y i 180 0 180 ];
        set_pos(a,t);
        
        d = d + 1;
        tab(:,d) = [i ; tension];
        
        if i == i_f % pour avoir un beau tableau bien symetrique
            d = d+1;
            tab(:,d) = [i ; tension];
        end
    end
    
end

taille_i = (i_f - i_d)/pas ; % récupération de la taille attendue du tableau

tab1 = tab(:,1: taille_i); % division en deux tableaux équivalents (un pour la montée, un pour la descente)
tab2bis = tab(:,taille_i+1:2*taille_i);
tab2 = fliplr(tab2bis);

error = 0.1; % erreur tolere en volt
n = 0;

si = size(tab1);
for j = 1 : si(2) - 1
    if tab1(2,j+1) > tab1(2,j) - error && tab1(2,j+1) < tab1(2,j) + error % je compare les tableaux de montée et de descente point par point,  si les valeurs correspondent je les garde dans le tableau final
        n = n + 1;
        new_tab(:,n) =  [ (tab1(1,j)+tab2(1,j+1))/2 ; (tab1(2,j)+tab2(2,j+1))/2 ];
    end
end
