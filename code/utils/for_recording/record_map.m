function time_diff_med = record_map(map_x,map_y,map_z,name,threshold,with_shift,map_time)
% Records the .map in its designated folder

% Record the threshold

objet.x = map_x;
objet.y = map_y;
objet.z = map_z;

% Si map_time est fourni en argument alors alors on enregistre le fichier map avec le time
if nargin > 6
    objet.time = map_time;
    % écart temporel entre les points !
    size_time = size(map_time);
    u = 0;
    % On effectue le décalage si besoin (with_shift est un booléen)
    if with_shift 
        for i = 1 : size_time(1)
            if ( mod(i,2) ~= 0 )
                for j = 1 : size_time(2)
                    u = u + 1;
                    tab_time(u) = map_time(i,j) ;
                end
            else
                for j = size_time(2) : -1 : 1 % décalage de deux millimètres pour éviter les bloquages
                    u = u + 1;
                    tab_time(u) = map_time(i,j) ;
                end
            end
        end
    else
        for i = 1 : size_time(1)
            for j = 1 : size_time(2)
                u = u + 1;
                tab_time_r(u) = map_time(i,j);
            end
        end
    end
    tab_time = sort(tab_time_r);
    for i = 2 : length(tab_time) % crée un tableau des ecarts temporels
        tab_time_diff(i) = tab_time(i) - tab_time(i-1) ;
    end
    time_diff_med = median(tab_time_diff);
    time_diff_moy = mean(tab_time_diff);
end

figure()
mesh(objet.x,objet.y,objet.z)
axis equal

folder_name = 'files/map files';

chemin = choix_chemin(folder_name,name);

punto = fopen(chemin,'w');

% On rentre les dimensions pour la reconstruction %%%
si = size(objet.z);
fprintf(punto,'%f %f %f %f \n', si(1), si(2),threshold,time_diff_med );
if nargin > 6
    %%% On rentre les données dans le document %%%
    for i = 1 : si(1)
        for j = 1 : si(2)
            fprintf(punto,'%f %f %f %f \n',objet.x(i,j), objet.y(i,j), objet.z(i,j),objet.time(i,j) );
        end
    end
else
    %%% On rentre les données dans le document %%%
    for i = 1 : si(1)
         for j = 1 : si(2)
            fprintf(punto,'%f %f %f %f \n',objet.x(i,j), objet.y(i,j), objet.z(i,j));
        end
    end
end
fclose(punto);

fprintf('Recommended time gap for peak detection %f \n', time_diff_med);