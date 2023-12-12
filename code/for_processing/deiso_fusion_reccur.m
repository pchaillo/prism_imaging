function indices_fusion = deiso_fusion_reccur(fusion_tab)

tab = fusion_tab;
tab_fin = [];
[tab tab_fin] = tab_fold_reccur(tab,tab_fin );
indices_fusion = tab_fin;
