

disp("Chargement du fichier mzXML en cours")
mzxml_r = "08_09_2023_tir_freq_max_doigt_2";
nom_mzxml = strcat(mzxml_r,'.mzXML');
mzXML.Struct = mzxmlread(nom_mzxml);

disp("Chargement du fichier mzXML terminé ")
figure()
plot_chromatogram(mzXML.Struct)