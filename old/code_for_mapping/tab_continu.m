function new_tab = tab_continu(tab)

% supprime les valeurs fausses
% nouvelle version pour ILD1320-25
 

supp = 1 ;
arret = 0 ;
f =  length(tab)-1 ;
c_sup = 0;
while supp ~= 0
    supp = 0;
    f = length(tab)-1;
    
    while arret == 0
        
        if f == 2
            arret = 1;
        end
        
        if f >= length(tab)
            f = length(tab)-1;
        end
        
        if abs( tab(2,f+1) ) < abs(tab(2,f) )
            tab(:,f+1) = [];
            supp = supp + 1;
        else
            f = f - 1;
        end
        
    end
    c_sup = c_sup +1 ;
    tab_sup(c_sup) = supp;
end

t_sup = sum(tab_sup)

to_supp = -1;

if t_sup > 100
    disp('tableau faussé');
end

for i = 1 :  length(tab) % pour corriger les valeurs concordantes mais tout de meme fausses
    if tab(2,i) <0.8
        to_supp = [to_supp i];
    end
end

to_supp(1) = []; % on retire le -1 mis initialement

tab(:,to_supp) = [];

new_tab = tab;