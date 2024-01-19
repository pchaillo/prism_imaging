function neighbor_flag = false_neighbor_detection(i,j,edge_flags,min_threshold,max_threshold,map,map_out)

if map_out(i - edge_flags.i_m, j) < min_threshold || map_out(i - edge_flags.i_m, j) > max_threshold || map(i,j) == 0.01 || map(i,j) == 0.02
    neighbor_flag.a = 0;
else
    neighbor_flag.a = 1;
end

if map_out(i + edge_flags.i_p,j) < min_threshold || map_out(i + edge_flags.i_p,j) > max_threshold || map(i,j) == 0.01 || map(i,j) == 0.02
    neighbor_flag.b = 0;
else
    neighbor_flag.b = 1;
end

if map_out(i,j-edge_flags.j_m) < min_threshold ||  map_out(i,j-edge_flags.j_m) > max_threshold || map(i,j) == 0.01 || map(i,j) == 0.02
    neighbor_flag.c = 0;
else
    neighbor_flag.c = 1;
end

if map_out(i,j+edge_flags.j_p) < min_threshold || map_out(i,j+edge_flags.j_p) > max_threshold || map(i,j) == 0.01 || map(i,j) == 0.02
    neighbor_flag.d = 0;
else
    neighbor_flag.d = 1;
end