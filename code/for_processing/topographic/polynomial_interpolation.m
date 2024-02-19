function interpolated_map = polynomial_interpolation(map,multiplier)

% Réalise l'interpolation polynomiale pour ajouter des points entre les
% valeurs mesurées.

% ordre 3
% réalise l'approximation sur les deux axes
% Third degree polynomial
% Performs the approximation on both axes

si = size(map.x);

scanning_step = map.x(2,1) - map.x(1,1);

map.r = map.z;

for u = 1 : si(2)
    for v = 2 : si(1)-2
        x = [v-1, v , v + 1,v+2] ;
        y = [map.r(v-1,u),map.r(v,u) , map.r(v+1,u) , map.r(v+2,u)];  %
        q(v,:) = polyfit (x,y,3);
    end
    q_tot{1,u} = q ;
end


for u = 1 : 1 : si(2)
    g = 0;
    for v =  1 : 1 : si(1)-2
       q = q_tot{1,u};
        
        if v == 1
            f = 0;
        else
            f = 1;
        end
        
        for k = v + f*(1/multiplier) : 1/multiplier : v+1
            g = g + 1 ;
            b = q(v,1)*k^3 + q(v,2)*k^2 + q(v,3)*k + q(v,4);
            if b ~= 0
                o2(g,u) = b;
            end
        end
    end
end

%%% ajout de ligne de 0 pour mettre le tableau dans le bon format
for t = 1 : multiplier
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

% map en v
for v = 1 : 1 : si0(1)
    g = 0;
    for u = 1 : 1 : si0(2) - 2 
        p = p_tot{1,v};
        
        if u == 1
            f = 0;
        else
            f = 1;
        end
        
        for k = u + f*(1/multiplier): 1/multiplier : u + 1 
            g = g + 1 ;
            b = p(u,1)*k^3 + p(u,2)*k^2 + p(u,3)*k + p(u,4);
            if b~= 0
                interpolated_map.z(v,g) = b;
            end
            
        end
        
    end
end

su = size(interpolated_map.z);
l = su(1);
m = su(2);
%prise en compte des valeurs impossbiles pour puissance 3
% ajout de lignes de 0 sur les cotés
for t = 1 : multiplier
    l = l + 1 ;
    m = m + 1 ;
    interpolated_map.z(l,:) = 0;
    interpolated_map.z(:,m) = 0;
end

% L'interpolation du 3e ordre ne peut pas être effectué sur les points du
% bord par manque de points : Je complète les bords de mon inerpolation du
% 3e ordre par les valeurs obtenues par une interpolation du 2nd ordre
carte_o2 = poly_2nd_ordre(map,multiplier);

x = 0;
for i = map.x(1 , 1 ) : scanning_step/multiplier: map.x( si(1) , 1 )
    x = x + 1;
    y = 0;
    for j = map.y(1,1) : scanning_step/multiplier : map.y(1,si(2))
        y = y + 1;
        if interpolated_map.z(x,y) == 0
           interpolated_map.z(x,y) = carte_o2(x,y);
        end
        interpolated_map.x(x,y) = i;
        interpolated_map.y(x,y) = j;
        
        x_new = ceil(x/multiplier); 
        y_new = ceil(y/multiplier); 
      
        interpolated_map.time(x,y) = map.time(x_new,y_new);
        
    end
end

g = 44;


