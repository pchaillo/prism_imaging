function [tab tab_fin] = tab_fold_reccur(tab, tab_fin)

tab_to_keep = {};
fus_ind = 0 ;
for i = 1 : length(tab)-1
    tab_raw = tab(i);
    tab_i = tab_raw{1,1};
    tab_raw2 = tab(i+1);
    tab2 = tab_raw2{1,1};
    
    C(i) = {intersect(tab_i,tab2)};
    
    if isempty(C{1,i})
        tab_plein(i) = 0;
    else
        tab_plein(i) = 1;
        fus_ind = fus_ind + 1;
        tab_plein_fus_ind(i) = fus_ind;
        
        tab_new(fus_ind) = {unique([ tab_i tab2]) };
    end
end

if exist('tab_plein')
    h = 1;
    tab_sum = 0;
    for i = 1 : length(tab_plein)
        if tab_plein(i) == 1
            tab_sum = tab_sum + 1;
            tab_sum_tab(h) = tab_sum;
            tab_sum_ind(h) = i;
        else
            h = h + 1;
            tab_sum = 0;
        end
    end
    
    if fus_ind ~= 0
        for i = 1 : length(tab_sum_tab)
            if tab_sum_tab(i) == 1
                ind_01 = tab_sum_ind(i);
                ind_fin = tab_plein_fus_ind(ind_01);
                tab_fin = [tab_fin tab_new(ind_fin)];
            end
        end
        tab_in = tab_new;
    end
    
    if fus_ind > 1
        [tab tab_fin] = tab_fold_reccur(tab_in, tab_fin);
    end
else 
    tab_fin = tab;
end