function [raw_array final_array] = list_fold_reccur(raw_array, final_array)

fusion_indice = 0 ;
for i = 1 : length(raw_array)-1
    selected_raw_array = raw_array(i);
    value_1 = selected_raw_array{1,1};
    selected_raw_array2 = raw_array(i+1);
    value_2 = selected_raw_array2{1,1};
    
    C(i) = {intersect(value_1,value_2)};
    
    if isempty(C{1,i})
        mask_list(i) = 0;
    else
        mask_list(i) = 1;
        fusion_indice = fusion_indice + 1;
        fusion_indices_list(i) = fusion_indice;
        
        intermediary_array(fusion_indice) = {unique([ value_1 value_2]) };
    end
end

if exist('mask_list')
    ind_in_array = 1;
    following_indice = 0;
    for i = 1 : length(mask_list)
        if mask_list(i) == 1
            following_indice = following_indice + 1;
            following_indices_list(ind_in_array) = following_indice;
            ind_in_fusion_list(ind_in_array) = i;
        else
            ind_in_array = ind_in_array + 1;
            following_indice = 0;
        end
    end
    
    if fusion_indice ~= 0
        for i = 1 : length(following_indices_list)
            if following_indices_list(i) == 1
                intermediary_indice = ind_in_fusion_list(i);
                indice = fusion_indices_list(intermediary_indice);
                final_array = [final_array intermediary_array(indice)];
            end
        end
        array_for_reccursive = intermediary_array;
    end
    
    if fusion_indice > 1
        [raw_array final_array] = list_fold_reccur(array_for_reccursive, final_array);
    end
else 
    final_array = raw_array;
end