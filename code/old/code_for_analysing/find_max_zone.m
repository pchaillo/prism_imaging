function max_map_3 = find_max_zone(max_map,max_mass_tab)

si = size(max_map);

for i = 1 : si(1)
    for j = 1 : si(2)
        if max_map(i,j) == max_mass_tab(1)
            max_map_3(i,j,1) = 1/2 ;
        elseif max_map(i,j) == max_mass_tab(2)
            max_map_3(i,j,2) = 1/2 ;
        elseif max_map(i,j) == max_mass_tab(3)
            max_map_3(i,j,3) = 1/2 ;
        end
    end
end

max_map_3(si(1),si(2),:) = 0;
