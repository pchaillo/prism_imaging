function indices_fusion = deiso_fusion_reccur(deiso_tab)

tab = deiso_tab;
tab_fin = [];
[tab tab_fin] = tab_fold_reccur_3(tab,tab_fin );
indices_fusion = tab_fin;

%test = 2;