function neighbor_flag = add_selected_neighbor(i,j,neighbor_flag,ind,x_tab,y_tab,l)

if ind < l
    for local_ind = ind + 1 : l
        if i-1 == x_tab(local_ind) && j == y_tab(local_ind)
            neighbor_flag.a = 0;
        end
        if i+1 == x_tab(local_ind) && j == y_tab(local_ind)
            neighbor_flag.b = 0;
        end
        if i == x_tab(local_ind) && j-1 == y_tab(local_ind)
            neighbor_flag.c = 0;
        end
        if i == x_tab(local_ind) && j+1 == y_tab(local_ind)
            neighbor_flag.d = 0;
        end
    end
end