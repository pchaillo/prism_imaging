function new_map_time = apply_prog_aspiration(map_time,aspiration,aspiration_shift)

si = size(map_time);

cst = aspiration_shift;

u = 0;
tot = si(1)*si(2);

for i = 1 : si(1)
    for j = 1 : si(2)
        u = u + 1;
        new_map_time(i,j) = map_time(i,j) + aspiration + (u/tot)*cst;
    end
end