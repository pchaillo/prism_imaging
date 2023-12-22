function carte_o2 = poly_2nd_ordre(carte,scan_pre)

% Réalise une interpolation polynomiale pour ajouter des points entre les
% valeurs mersurées.

% carte.r non sym
% pour carte.r adapté
% réalise l'approximation sur les deux axes

carte.r = carte.z;

scan.n = 2;

si_r = size(carte.r);
% polynome en u


for v = 1  : si_r(1)
    for u = 2 : si_r(2) - 1
        x = [u-1, u , u + 1] ;
        y = [carte.r(v,u-1),carte.r(v,u) , carte.r(v,u+1)];  %
        q(u,:) = polyfit (x,y,scan.n);
    end
    q_tot{1,v} = q;
end

% carte en u
for v = 1 : 1 : si_r(1) %+scan.pas
    g = 0;
    for u = 2 : 2 : si_r(2) -1
        
        p = q_tot{1,v};
        
        if u == 2
            f = 0;
        else
            f = 1;
        end
        
        for k = u -1 + f*(1/scan_pre) : 1/scan_pre : u - 1/scan_pre
            g = g + 1 ;
            a = p(u-1,1)*k^2 + p(u-1,2)*k + p(u-1,3);
            b = p(u,1)*k^2 + p(u,2)*k + p(u,3);
            if a ~= 0
                o2(v,g) = ( a + b ) / 2 ;
            else
                o2(v,g) = b;
            end
        end
        
        for k = u : 1/scan_pre : u+1
            g = g + 1 ;
            si = size(p);
            if u + 1 > si(1)
                a = 0;
            else
                a = p(u+1,1)*k^2 + p(u+1,2)*k + p(u+1,3);
            end
            b = p(u,1)*k^2 + p(u,2)*k + p(u,3);
            if a ~= 0
                o2(v,g) = ( a + b ) / 2 ;
            else
                o2(v,g) = b;
            end
        end
        
    end
end

si0 = size( o2 );
% polynome en v
for u = 1 : si0(2)
    for v = 2 : si0(1) -1
        x = [v-1, v , v + 1] ;
        y = [o2(v-1,u),o2(v,u) , o2(v+1,u)];  %
        p(v,:) = polyfit (x,y,scan.n);
    end
    p_tot{1,u} = p;
end

% carte en u
for u = 1 : 1 : si0(2) %+ scan.pas - 2*scan.pas/scan.pre %ajout du 2 avec le -

    g = 0;
    for v = 2 : 2 : si0(1) - 1
        
        p = p_tot{1,u};
        
        if v == 2
            f = 0;
        else
            f = 1;
        end
        
        for k = v -1 + f*(1/scan_pre) : 1/scan_pre : v - 1/scan_pre
            g = g + 1 ;
            a = p(v-1,1)*k^2 + p(v-1,2)*k + p(v-1,3);
            b = p(v,1)*k^2 + p(v,2)*k + p(v,3);
            if a ~= 0
                carte_o2(g,u) = ( a + b ) / 2 ;
            else
                carte_o2(g,u) = b;
            end
        end
        
        for k = v : 1/scan_pre : v+1
            g = g + 1 ;
            si = size(p);
            if v + 1 > si(1)
                a = 0;
            else
                a = p(v+1,1)*k^2 + p(v+1,2)*k + p(v+1,3);
            end
            b = p(v,1)*k^2 + p(v,2)*k + p(v,3);
            if a ~= 0
                carte_o2(g,u) = ( a + b ) / 2 ;
            else
                carte_o2(g,u) = b;
            end
        end
        
    end
end