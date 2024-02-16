function value = compute_new_height(x,y,edge_flags,neighbor_flag,map_out)

neighbor_flag_sum = neighbor_flag.a + neighbor_flag.b + neighbor_flag.c + neighbor_flag.d;

if neighbor_flag_sum == 0
    value = 0 ;
else
    A = neighbor_flag.a*map_out(x-edge_flags.i_m,y);
    B = neighbor_flag.b*map_out(x+edge_flags.i_p,y);
    C = neighbor_flag.c*map_out(x,y-edge_flags.j_m);
    D = neighbor_flag.d*map_out(x,y+edge_flags.j_p);
    value = ( A + B + C + D ) / neighbor_flag_sum;
end