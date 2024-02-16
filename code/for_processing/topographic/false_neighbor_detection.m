function neighbor_flag = false_neighbor_detection(x,y,edge_flags,min_threshold,max_threshold,map,map_out)

if map_out(x - edge_flags.i_m, y) < min_threshold || map_out(x - edge_flags.i_m, y) > max_threshold || map(x,y) == 0.01 || map(x,y) == 0.02
    neighbor_flag.a = 0;
else
    neighbor_flag.a = 1;
end

if map_out(x + edge_flags.i_p,y) < min_threshold || map_out(x + edge_flags.i_p,y) > max_threshold || map(x,y) == 0.01 || map(x,y) == 0.02
    neighbor_flag.b = 0;
else
    neighbor_flag.b = 1;
end

if map_out(x,y-edge_flags.j_m) < min_threshold ||  map_out(x,y-edge_flags.j_m) > max_threshold || map(x,y) == 0.01 || map(x,y) == 0.02
    neighbor_flag.c = 0;
else
    neighbor_flag.c = 1;
end

if map_out(x,y+edge_flags.j_p) < min_threshold || map_out(x,y+edge_flags.j_p) > max_threshold || map(x,y) == 0.01 || map(x,y) == 0.02
    neighbor_flag.d = 0;
else
    neighbor_flag.d = 1;
end