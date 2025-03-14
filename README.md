# prism_imaging

STORM_MSI: Open-Source Software for 3D Mass Spectrometry Imaging

STORM_MSI enables the synchronization of a positioning platform, a desorption source, a topographic sensor (measuring distance (height of sample) at each point), and a mass spectrometer to reconstruct 3D images with biometric information. The software also includes essential tools for basic data processing, such as m/z selection, noise filtering, and normalization.
For spectral data import, STORM_MSI supports the mzXML format. For data export and reuse in other software, it provides compatibility with mzML, imzML, PLY, and CSV formats, ensuring flexibility and interoperability across different analytical platforms.

## En français :
STORM_MSI permet de synchroniser une plateforme de positionnement, une source de désorption, un capteur topographique (distance, hauteur de chaque point) et un spcetromètre de masse, afin de pouvoir reconstruire des images 3D avec les informations biométriques. Le logiciel comprend aussi le nécessaire pour réaliser le processing basique des données (selection des m/z, filtrage du bruit, normalisation, etc.). Le format mzXML est utilisé pour importer les données spectrométriques, et les formats mzML, imzMl, ply et csv peuvent être utiliser pour l'export et la réutilisation de ces données dans d'autres logiciels.


Attention, penser à créer les répertoires "csv files", "map files", "mat files", "mzXML files", and "rgb map files" to use the interface.

Launch the file mapping_APP_7.mlapp trough matlab to launch the interface.

Requirements: 
Matlab Toolbox : Bioinformatics Toolbox (To use the .mzXML file format)

Version Prism 

Created by Paul Chaillou - 2021 / 2023

pchaillo - paul.chaillou@inria.fr / paul.chaillou@tutanota.com

Contributeurs : Adel Guiot (adel.guiot.etu@univ-lille.fr) / Thibaud Picinalli / Yanis Zirem (yanis.zirem@univ-lille.fr) / Oumaima Hamhoum


# TODO FOR CLEAN SHARING :

## Essential :
- Ecrire la doc
- traduire tout le francais
- Selectionner un jeu de données test, présent dans le dépot, autant pour pouvoir tester les fonctionnalités que pour donner un exemple aux utilisateurs
- Déclaration HAL et BIL
- Remove all OMG_MSI and rename into STORM_MSI

## Details to clean :
- remove code_for_segmentation
- arduino en startup => peu elegant... (Faire un truc plus robuste est necessaire) + trigerring du spectrometre pour partage
- Impacter les templates apres le debug hardware
- Repasser sur les #TODO dans le code
- csv_spectra_recorder => n'existe pas pour extraire une zone de l'image en .csv => voir export_spectra_zone
- Remove useless "code_" in folder name (code_for_segmentation; code_python; code_java)
- Remove useless "file" in "map files" etc. (C'est redondant, c'est deja dans le dossier files)
- Move .ply to file folder
- Refactor interface => retirer biomap
- remplacer les diodes par quelquechose de plus elegant


# Long-term additions (Todo) :

## Generate an executable ?

## Cleaning :
- Aussi deporter ce qui peut l'etre dans des fonctions et ne pas laisser dans mlapp => rend les merge plus faciles
- Supprimer les egalites inutiles ? 
Exemple :
a = B + c
a_final = a
return a_final
=>
return b + C
- Robot => Effector ?
- Garder commentees des variables utiles pour le debug ? (Peak Picking ligne 77)


## Add utility comment (input/output) and volontee :
- utils/find_closest_point
- utils/for_casting/clean_fusion_list

## utils :
- Merge extract_num, extract_TIC and extract_time to improve perfomances ? (see usage of this funtions)
- Merge find_folders_and_subfolders, folder_scan, folder_scan_withtout_extension and sort_folder_and_files ? Refactor ? (call each others ?)

## New features ? :
- WatchDog : On supprime ou on fait remonter dans l'interface
- Rendre la modalite d'acquisition modulaire ? Ou juste le pattern de balayage ?
- Rectification de l'acquisition par defaut avant l'enregistrement ? (plutot non, risque de generer des bugs ?)


# Changes history

Could be deleted if not useful anymore

## Done :
- automatic mzML generation
- imzML generation pipeline as clear as possible

## Cleaned :
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