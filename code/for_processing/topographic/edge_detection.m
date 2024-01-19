function edge_flags = edge_detection(i,j,dim)

%%% Edges Detection %%%
if i == 1
    edge_flags.i_m = -1;
else
    edge_flags.i_m = 1;
end

if i == dim(1)
    edge_flags.i_p = -1;
else
    edge_flags.i_p = 1;
end

if j == 1
    edge_flags.j_m = -1;
else
    edge_flags.j_m = 1;
end

if j == dim(2)
    edge_flags.j_p = -1;
else
    edge_flags.j_p = 1;
end
            