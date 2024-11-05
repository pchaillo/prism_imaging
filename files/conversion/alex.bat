xcopy /I /Y "D:\OMG_MSI\prism_imaging\files\raw files\20241011_TAGMASS_CEREBELLUM_125_FRAC_POS_glycerol.raw" "C:\Users\Administrator\AppData\Local\Apps\ProteoWizard 3.0.24143.8381ed5 64-bit\20241011_TAGMASS_CEREBELLUM_125_FRAC_POS_glycerol.raw" 
xcopy /Y "D:\OMG_MSI\prism_imaging\files\txt files\20241011_TAGMASS_CEREBELLUM_125_FRAC_POS_glycerol.txt" "C:\Users\Administrator\AppData\Local\Apps\ProteoWizard 3.0.24143.8381ed5 64-bit"
C:
cd "C:\Users\Administrator\AppData\Local\Apps\ProteoWizard 3.0.24143.8381ed5 64-bit"
pause
msconvert 20241011_TAGMASS_CEREBELLUM_125_FRAC_POS_glycerol.raw -c 20241011_TAGMASS_CEREBELLUM_125_FRAC_POS_glycerol.txt
xcopy "C:\Users\Administrator\AppData\Local\Apps\ProteoWizard 3.0.24143.8381ed5 64-bit\20241011_TAGMASS_CEREBELLUM_125_FRAC_POS_glycerol.mzML" "D:\MassLynxProjects\LeaL.PRO\Data\Imaging\"
echo Conversion from file succeeded
pause
