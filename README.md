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
- source.t_b => truc mieux
- Change trigger_sprectro_time function name
- unify connexion/initilisation in hardawre component (from connect() to init() )
- csv_spectra_recorder => n'existe pas pour extraire une zone de l'image en .csv => voir export_spectra_zone
- Le format BioMap sert encore a quelquechose ?
- Remove useles "code_" in folder name (code_for_segmentation; code_python; code_java)
- Repasser sur les #TODO dans le code
- sensor => self (coller a la typo python pour etre plus comprehensible)
	- Impacter les templates apres le debug hardware
	- Mettre en place la connexion propre entre arduino pour capteur et pour trigger spectro => OK ?
- verifier que la variable globale state est bien fonctionelle + test de la fonction de securite
- faire un choix pour l'ajout des fichier au workspace
- remplacer les diodes par quelquechose de plus elegant
- Robot => Effector ?

Globalement, traduire tout le francais

Aussi deporter ce aui peut l'etre dans des fonctions et ne pas laisser dans mlapp => rend les merge plus faciles

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


# Noms a revoir (Faire des suggestions ici ?)
Fonctions :
- deiso_fusion_reccur() => ?
- list_fold_reccur() => ?
Variables :
- tab_qsw_0 

# Cleaned :
Variables :
- Laser => Source
- tab_qsw_0 => msg_qsw_0
- bio_dat => pixels_scans
- carte => map
- tab => array / list
- alls_scans => all_scans
