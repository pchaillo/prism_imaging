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
- Laser => Source
- sensor => self (coller a la typo python pour etre plus comprehensible)
	- Impacter les templates apres le debug hardware
	- Mettre en place la connexion propre entre arduino pour capteur et pour trigger spectro => OK ?
- verifier que la variable globale state est bien fonctionelle
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

# Noms a revoir (Faire des suggestions ici ?)
Fonctions :
- deiso_fusion_reccur() => ?
- list_fold_reccur() => ?
Variables :
- tab_qsw_0 

# Cleaned :
Variables :
- tab_qsw_0 => msg_qsw_0
- bio_dat => pixels_scans
- carte => map
- tab => array / list
- alls_scans => all_scans
