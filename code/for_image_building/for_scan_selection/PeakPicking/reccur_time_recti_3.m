function [ind_f_new, ind_add_tab_2 ] = reccur_time_recti_3(ind_f_old,file,time_tab_map,t_step,file_time_tab)

% Fonction qui rajoute et retire des points en compraant les temps de
% cartographies et issues du fichier mzXML

ok = 0;

for i = 1 : length(ind_f_old)
    time_tab_final_2(i) = file(ind_f_old(i)).retentionTime;
end

for i = 1 : length( time_tab_map)
    time_tab_diff_2(i) = time_tab_final_2(i) - time_tab_map(i);
    if time_tab_diff_2(i) < - t_step*0.8
        if file(ind_f_old(i)).num < 0 % pour ne pas supprimer les lignes des peaks
            ind_f_old(i) = [];
            [ind_f_new, ind_add_tab_2]= reccur_time_recti_3(ind_f_old,file,time_tab_map,t_step,file_time_tab);
            ok = 1;
            break
        end
    elseif time_tab_diff_2(i) >  t_step*1.2 % *1.5 ?
        %         if i > 2
        %         time01 = file(ind_f_old(i)).retentionTime;
        %         time02 = file(ind_f_old(i+1)).retentionTime;
        time01 = file(ind_f_old(i-1)).retentionTime;
        time02 = file(ind_f_old(i)).retentionTime;
        time_val_i = (time01 + time02)/2 ;
        time_ind = find_closest_point(time_val_i,file_time_tab, t_step);
        ind_f_old = [ind_f_old time_ind];
        ind_f_old = sort(ind_f_old);
        [ind_f_new, ind_add_tab_2] = reccur_time_recti_3(ind_f_old,file,time_tab_map,t_step,file_time_tab);
        ok = 1;

        ind_add_tab_2 = [ind_add_tab_2 time_ind];
        break
        %         end
    end
end

if ok == 0
    ind_f_new = ind_f_old;
    ind_add_tab_2 = 0;
end


