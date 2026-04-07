projectRoot = "C:\Users\Adel\Documents\PRISM\prism_imaging";

% Create target build options object, set build properties and build.
buildOpts = compiler.build.StandaloneApplicationOptions(fullfile(projectRoot, "STORM_MSI.mlapp"));
buildOpts.AdditionalFiles = fullfile(projectRoot, "code");
buildOpts.AutoDetectDataFiles = true;
buildOpts.OutputDir = fullfile(projectRoot, "STORM_MSI", "build");
buildOpts.SupportPackages = "none";
buildOpts.ObfuscateArchive = false;
buildOpts.Verbose = true;
buildOpts.EmbedArchive = true;
buildOpts.ExecutableIcon = fullfile(projectRoot, "STORM-MSI_Logo.png");
buildOpts.ExecutableName = "STORM_MSI";
buildOpts.ExecutableVersion = "2.5";
buildOpts.TreatInputsAsNumeric = false;
buildResult = compiler.build.standaloneApplication(buildOpts);

% Download the MATLAB Runtime to include in the installer.
compiler.runtime.download;

% Create package options object, set package properties and package.
packageOpts = compiler.package.InstallerOptions(buildResult);
packageOpts.ApplicationName = "STORM-MSI";
packageOpts.AuthorName = "Paul CHAILLOU, Adel GUIOT";
packageOpts.AuthorEmail = "adel.guiot@univ-lille.fr";
packageOpts.AuthorCompany = "U1192 PRISM";
packageOpts.DefaultInstallationDir = "%ProgramFiles%/STORM_MSI";
packageOpts.InstallerIcon = fullfile(projectRoot, "STORM-MSI_Logo.png");
packageOpts.InstallerName = "STORM_MSI_Installer";
packageOpts.OutputDir = fullfile(projectRoot, "STORM_MSI", "output", "package");
packageOpts.RuntimeDelivery = "installer";
packageOpts.Verbose = true;
packageOpts.Version = "2.5";
compiler.package.installer(buildResult, "Options", packageOpts);