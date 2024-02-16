function indices_fusion_list = deiso_fusion_reccur(scans_fusion_list)

list = scans_fusion_list;
final_list = [];
[list final_list] = list_fold_reccur(list,final_list );
indices_fusion_list = final_list;
