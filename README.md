# prism_imaging


Attention, penser à créer les répertoires "csv files", "map files", "mat files", "mzXML files", and "rgb map files" to use the interface.

Launch the file mapping_APP_7.mlapp trough matlab to launch the interface.

Requirements: 
Matlab Toolbox : Bioinformatics Toolbox (To use the .mzXML file format)

Version Prism 

Created by Paul Chaillou - 2021 / 2023

pchaillo - paul.chaillou@inria.fr

Contributeurs : Adel Guiot (adel.guiot.etu@univ-lille.fr) / Thibaud Picinalli / Yanis Zirem (yanis.zirem@univ-lille.fr)


# TODO :
P :
- arduino en startup => peu elegant... (Faire un truc plus robuste est necessaire)
- Change trigger_sprectro_time function name
- unify connexion/initilisation in hardawre component (from connect() to init() ? )
- sensor => self (coller a la typo python pour etre plus comprehensible)
	- Impacter les templates apres le debug hardware
	- Mettre en place la connexion propre entre arduino pour capteur et pour trigger spectro => OK ?
- deiso_fusion_reccur() => ?
- list_fold_reccur() => ?
- Repasser sur les #TODO dans le code

Vendredi : 
- Arrêt du laser continu => Arrêt total de l'imagerie 
- verifier que la variable globale state est bien fonctionelle + test de la fonction de securite

- csv_spectra_recorder => n'existe pas pour extraire une zone de l'image en .csv => voir export_spectra_zone

A :
- Remove useless "code_" in folder name (code_for_segmentation; code_python; code_java)
- Remove useless "file" in "map files" etc. (C'est redondant, c'est deja dans le dossier files)
- Move .ply to file folder
- faire un choix pour l'ajout des fichier au workspace
- remplacer les diodes par quelquechose de plus elegant

Y :
- automatic mzML generation
- imzML generation pipeline as clear as possible
- remove code_for_segmentation ?

Globalement, traduire tout le francais

Aussi deporter ce qui peut l'etre dans des fonctions et ne pas laisser dans mlapp => rend les merge plus faciles

Supprimer les egalites inutiles ? 
Exemple :
a = B + c
a_final = a
return a_final
=>
return b + C

# TOCHOOSE : (Repasser sur ceux du code) 
- Rectification de l'acquisition par defaut avant l'enregistrement ? (plutot non, risque de generer des bugs ?)
- Garder commentees des variables utiles pour le debug ? (Peak Picking ligne 77)
- Robot => Effector ?


# Cleaned :
- Le format BioMap sert encore a quelquechose ? => Non

Variables :
- Laser => Source
- tab_qsw_0 => msg_qsw_0
- bio_dat => pixels_scans
- carte => map
- tab => array / list
- alls_scans => all_scans
