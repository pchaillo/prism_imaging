b1 = app.MassbandminEditField.Value;
b2 = app.maxEditField.Value;
band = [b1 b2];
nb_point = app.NumberofpointonthecorrelationcirclemaximummzEditField.Value;
win = app.BiningwindowmassEditField.Value;
nom_r = app.MatfilenameEditField_2.Value;
nom = strcat(nom_r,'.mat');
load(nom);
tlp = app.ShowalsoallmassesonanothercorrelationcircleCheckBox.Value;
mat_pca_circle2(win,band,nb_point,bio_dat,tlp)
