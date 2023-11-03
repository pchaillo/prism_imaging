function [carte_o, carte_x_o, carte_y_o, carte_time_o, bio_map_o] = polynomial_interpolation_bio(carte,scan_pre,bio_map)

% Réalise l'interpolation polynomiale pour ajouter des points entre les
% valeurs mesurées.

% ordre 3
% réalise l'approximation sur les deux axes

si = size(carte.x);

scan_pas = carte.x(2,1) - carte.x(1,1);

carte.r = carte.z;

for u = 1 : si(2)
    for v = 2 : si(1)-2
        x = [v-1, v , v + 1,v+2] ;
        y = [carte.r(v-1,u),carte.r(v,u) , carte.r(v+1,u) , carte.r(v+2,u)];  %
        q(v,:) = polyfit (x,y,3);
        
        y_bio = [bio_map(v-1,u), bio_map(v,u) , bio_map(v+1,u) , bio_map(v+2,u)];  
        q_bio(v,:) = polyfit(x,y_bio,3);
    end
    q_tot{1,u} = q ;
    q_tot_bio{1,u} = q_bio;
end


for u = 1 : 1 : si(2)
    g = 0;
    for v =  1 : 1 : si(1)-2
       q = q_tot{1,u};
       q_bio = q_tot_bio{1,u};
        
        if v == 1
            f = 0;
        else
            f = 1;
        end
        
        for k = v + f*(1/scan_pre) : 1/scan_pre : v+1
            g = g + 1 ;
            
            b = q(v,1)*k^3 + q(v,2)*k^2 + q(v,3)*k + q(v,4);
            if b ~= 0
                o2(g,u) = b;
            end
            
            c = q_bio(v,1)*k^3 + q_bio(v,2)*k^2 + q_bio(v,3)*k + q_bio(v,4);
            if b ~= 0
                b2(g,u) = c;
            end
        end
    end
end

%%% ajout de ligne de 0 pour mettre le tableau dans le bon format
for t = 1 : scan_pre
    g = g + 1;
    % o2(:,g) = 0;
    o2(g,:) = 0;
    b2(g,:) = 0 ;
end


% polynome en v % 3e ordre
si0 = size(o2);
for v = 1  : si0(1)
    for u = 2 : si0(2)-2
        x = [u-1, u , u + 1, u+2] ;
        y = [o2(v,u-1),o2(v,u) , o2(v,u+1), o2(v,u+2)];  %
        p(u,:) = polyfit (x,y,3);
        
        y_bio = [b2(v,u-1), b2(v,u) , b2(v,u+1), b2(v,u+2)];
        p_bio(u,:) = polyfit (x,y_bio,3);
        
    end
    p_tot{1,v} = p;
    p_tot_bio{1,v} = p_bio;
end

% carte en v
for v = 1 : 1 : si0(1)
    g = 0;
    for u = 1 : 1 : si0(2) - 2
        p = p_tot{1,v};
        p_bio = p_tot_bio{1,v};
        
        if u == 1
            f = 0;
        else
            f = 1;
        end
        
        for k = u + f*(1/scan_pre): 1/scan_pre : u + 1 %- 1/scan.pre
            g = g + 1 ;
            
            b = p(u,1)*k^3 + p(u,2)*k^2 + p(u,3)*k + p(u,4);
            if b~= 0
                carte_o(v,g) = b;
            end
            
            c = p_bio(u,1)*k^3 + p_bio(u,2)*k^2 + p_bio(u,3)*k + p_bio(u,4);
            if b~= 0
                bio_map_o(v,g) = c;
            end
        end
        
    end
end

su = size(carte_o);
l = su(1);
m = su(2);
%prise en compte des valeurs impossbiles pour puissance 3
% ajout de lignes de 0 sur les cotés
for t = 1 : scan_pre
    l = l + 1 ;
    m = m + 1 ;
    carte_o(l,:) = 0;
    carte_o(:,m) = 0;
    bio_map_o(l,:) = 0;
    bio_map_o(:,m) = 0;
end

% L'interpolation du 3e ordre ne peut pas être effectué sur les points du
% bord par manque de points : Je complète les bords de mon inerpolation du
% 3e ordre par les valeurs obtenues par une interpolation du 2nd ordre
carte_o2 = poly_2nd_ordre(carte,scan_pre);
bio_map_o2 = poly_2nd_ordre_general(bio_map,scan_pre);


x = 0;
for i = carte.x(1 , 1 ) : scan_pas/scan_pre: carte.x( si(1) , 1 )% + scan.pas/scan.pre
    x = x + 1;
    y = 0;
    for j = carte.y(1,1) : scan_pas/scan_pre : carte.y(1,si(2))% + scan.pas/scan.pre
        y = y + 1;
        if carte_o(x,y) == 0
            carte_o(x,y) = carte_o2(x,y);
            bio_map_o(x,y) = bio_map_o2(x,y);
        end
        carte_x_o(x,y) = i;
        carte_y_o(x,y) = j;
        
        %         %% cette attribution est lacunaire, il faut en trouver une autre !
        %         x_new = round(x/scan_pre) %+1/scan_pre);% +0.5;%+ ); %?
        %         y_new = round(y/scan_pre )%+1/scan_pre);% +0.5;%+ 1/scan_pre); % ?
        %         if x_new == 0
        %             x_new = 1;
        %         end
        %         if y_new == 0
        %             y_new = 1;
        %         end
        
        x_new = ceil(x/scan_pre); %+1/scan_pre);% +0.5;%+ ); %?
        y_new = ceil(y/scan_pre); %+1/scan_pre);% +0.5;%+ 1/scan_pre); % ?
      
        
        carte_time_o(x,y) = carte.time(x_new,y_new);
        
    end
end

g = 44;


