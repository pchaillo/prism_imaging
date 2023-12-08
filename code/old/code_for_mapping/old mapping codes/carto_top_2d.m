% Créé une carte 2d

function carto_top_2d()

% cartographie la zone et non l'objet

global carte
global scan
global zone

disp('Creating the map');

%carte.o = 0;

v = 0;

for k = zone.dec : scan.pas : zone.dim_x+zone.dec
    v = v + 1 ;
    if ( mod(v,2) ~= 0 )
        u = 0;
        for j = 2 : scan.pas : zone.dim_y +2
            u = u +1;

            carte.x(v,u) = k;
            carte.y(v,u) = j;
           % carte.r(v,u) = mesure_2(vid,new_tab,scan.h);
            carte.i(v,u) = 0;
            
            %             m = get_pos(t);
            %             test_pos(a,m,t);
        end
    else
        u =  ( zone.dim_y  ) / scan.pas +2  ;
        for j = zone.dim_y+2 : -scan.pas : 2 % décalage de deux millimètres pour éviter les bloquages
            u = u - 1;

            carte.x(v,u) = k;
            carte.y(v,u) = j;
            %            carte.r(v,u) = mesure_2(vid,new_tab,scan.h);
            carte.i(v,u) = 0;
            
            %             m = get_pos(t);
            %             test_pos(a,m,t);
        end
    end
end