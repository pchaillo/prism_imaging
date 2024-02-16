function neighbor_flag = add_selected_neighbor(x,y,neighbor_flag,ind,x_list,y_list,l)

if ind < l
    for local_ind = ind + 1 : l
        if x-1 == x_list(local_ind) && y == y_list(local_ind)
            neighbor_flag.a = 0;
        end
        if x+1 == x_list(local_ind) && y == y_list(local_ind)
            neighbor_flag.b = 0;
        end
        if x == x_list(local_ind) && y-1 == y_list(local_ind)
            neighbor_flag.c = 0;
        end
        if x == x_list(local_ind) && y+1 == y_list(local_ind)
            neighbor_flag.d = 0;
        end
    end
end