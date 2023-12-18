function poly_appro_top()

% Réalise l'interpolation polynomiale pour ajouter des points entre les
% valeurs mesurées.

% fonctionne pour carte.r pas sym
% suit carte.r
% x et y + réalisable
% ne fonctionne pas et pas forcément utile
% ordre 3
% réalise l'approximation sur les deux axes

global carte
global scan

carte.o = 0;

% polynome en u % 3e ordre
si = size(carte.r);
for u = 1 : si(2)
    for v = 2 : si(1)-2
        x = [v-1, v , v + 1,v+2] ;
        y = [carte.r(v-1,u),carte.r(v,u) , carte.r(v+1,u) , carte.r(v+2,u)];  %
        q(v,:) = polyfit (x,y,3);
    end
    q_tot{1,u} = q ;
end

% carte en u
u = 0;
for i = carte.y(1,1) : scan.pas : carte.y( 1 , si(2) )% +scan.pas
    u = u + 1;
    v = 0;
    g = 0;
    for j =  carte.x(1,1) : scan.pas : carte.x( si(1) , 1 ) -2*scan.pas
        v = v + 1 ;
        q = q_tot{1,u};
        
        if v == 1
            f = 0;
        else
            f = 1;
        end
        
        for k = v + f*(1/scan.pre) : 1/scan.pre : v+1
            g = g + 1 ;
            b = q(v,1)*k^3 + q(v,2)*k^2 + q(v,3)*k + q(v,4);
            if b ~= 0
                %o2(v,g) = b ;
                o2(g,u) = b;
            end
        end
        
    end
end

for t = 1 : scan.pre
    g = g + 1;
    % o2(:,g) = 0;
    o2(g,:) = 0;
end

% polynome en v % 3e ordre
si0 = size(o2);
for v = 1  : si0(1)
    for u = 2 : si0(2)-2
        x = [u-1, u , u + 1, u+2] ;
        y = [o2(v,u-1),o2(v,u) , o2(v,u+1), o2(v,u+2)];  %
        p(u,:) = polyfit (x,y,3);
    end
    p_tot{1,v} = p;
end

% carte en v
v = 0;
for i = carte.x(1,1) : scan.pas/scan.pre: carte.x( si(1) , 1 )%+scan.pas
    v = v + 1;
    u = 0; % 0
    g = 0;
    % g2 = 0;
    for j = carte.y(1,1) +scan.pas : scan.pas : carte.y( 1 , si(2) ) - scan.pas
        u = u + 1;
        p = p_tot{1,v};
        
        if u == 1
            f = 0;
        else
            f = 1;
        end
        
        for k = u + f*(1/scan.pre): 1/scan.pre : u + 1 %- 1/scan.pre
            g = g + 1 ;
            b = p(u,1)*k^3 + p(u,2)*k^2 + p(u,3)*k + p(u,4);
            if b~= 0
                carte.o(v,g) = b;
            end
            
        end
        
    end
end

su = size(carte.o);
l = su(1);
m = su(2);
for t = 1 : scan.pre %prise en compte des valeurs impossbiles pour puissance 3
    l = l + 1 ;
    m = m + 1 ;
    carte.o(l,:) = 0;
    carte.o(:,m) = 0;
end

% L'interpolation du 3e ordre ne peut pas être effectué sur les points du
% bord par manque de points : Je complète les bords de mon inerpolation du
% 3e ordre par les valeurs obtenues par une interpolation du 2nd ordre
poly_appro_2nd_ordre_top();

x = 0;
for i = carte.x(1 , 1 ) : scan.pas/scan.pre: carte.x( si(1) , 1 )% + scan.pas/scan.pre
    x = x + 1;
    y = 0;
    for j = carte.y(1,1) : scan.pas/scan.pre : carte.y(1,si(2))% + scan.pas/scan.pre
        y = y + 1;
        if carte.o(x,y) == 0
            carte.o(x,y) = carte.o2(x,y);
        end
        carte.x_o(x,y) = i;
        carte.y_o(x,y) = j;
    end
end
