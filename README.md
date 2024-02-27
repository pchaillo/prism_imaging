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
- Ecrire la doc
- csv_spectra_recorder => n'existe pas pour extraire une zone de l'image en .csv => voir export_spectra_zone
- traduire tout le francais

P :
- arduino en startup => peu elegant... (Faire un truc plus robuste est necessaire) + trigerring du spectrometre pour partage
- Impacter les templates apres le debug hardware
- Repasser sur les #TODO dans le code

A :
- Remove useless "code_" in folder name (code_for_segmentation; code_python; code_java)
- Remove useless "file" in "map files" etc. (C'est redondant, c'est deja dans le dossier files)
- Move .ply to file folder
- Refactor interface => retirer biomap
- remplacer les diodes par quelquechose de plus elegant

Y :
- automatic mzML generation
- imzML generation pipeline as clear as possible
- remove code_for_segmentation ?


# TOCHOOSE : (Repasser sur ceux du code) + Long terme
- WatchDog : On supprime ou on fait remonter dans l'interface
- Rendre la modalite d'acquisition modulaire ? Ou juste le pattern de balayage ?
- Rectification de l'acquisition par defaut avant l'enregistrement ? (plutot non, risque de generer des bugs ?)
- Garder commentees des variables utiles pour le debug ? (Peak Picking ligne 77)
- Robot => Effector ?

- Aussi deporter ce qui peut l'etre dans des fonctions et ne pas laisser dans mlapp => rend les merge plus faciles

- Supprimer les egalites inutiles ? 
Exemple :
a = B + c
a_final = a
return a_final
=>
return b + C


# Cleaned :
- faire un choix pour l'ajout des fichier au workspace
- list_fold_reccur() => ? J'ai pas trouve mieux pour l'instant
- Mettre en place la connexion propre entre arduino pour capteur et pour trigger spectro => OK ?
- Mettre en place la connexion propre entre arduino pour capteur et pour trigger spectro => OK ?
- unify connexion/initilisation in hardawre component (from connect() to init() ? )
- Le format BioMap sert encore a quelquechose ? => Non
Variables :
- Laser => Source
- tab_qsw_0 => msg_qsw_0
- bio_dat => pixels_scans
- carte => map
- tab => array / list
- alls_scans => all_scans
- Change trigger_sprectro_time function name
- deiso_fusion_reccur() => process_fusion_list
- Arrêt du laser continu => Arrêt total de l'imagerie 
- verifier que la variable globale state est bien fonctionelle + test de la fonction de securite
