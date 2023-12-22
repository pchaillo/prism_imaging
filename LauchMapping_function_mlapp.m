classdef mapping_APP_7 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        TabGroup                        matlab.ui.container.TabGroup
        AcquisitionTab                  matlab.ui.container.Tab
        ConnectSensorButton             matlab.ui.control.Button
        SensorDropDown                  matlab.ui.control.DropDown
        SensorDropDownLabel             matlab.ui.control.Label
        ImagingLabel                    matlab.ui.control.Label
        LaserConnexionLabel             matlab.ui.control.Label
        SensorConnexionLabel            matlab.ui.control.Label
        RobotConnexionLabel             matlab.ui.control.Label
        AcquisitionPropertiesLabel      matlab.ui.control.Label
        RobotDropDown                   matlab.ui.control.DropDown
        RobotDropDownLabel              matlab.ui.control.Label
        STOPCONTINUOUSLASERButton_2     matlab.ui.control.Button
        ContinuousLaserCheckBox         matlab.ui.control.CheckBox
        LaserDropDown                   matlab.ui.control.DropDown
        LaserDropDownLabel              matlab.ui.control.Label
        EstimationofmappingtimeLabel    matlab.ui.control.Label
        NoMappingLabel                  matlab.ui.control.Label
        mapLabel                        matlab.ui.control.Label
        ZPositionEditField              matlab.ui.control.NumericEditField
        ZPositionEditFieldLabel         matlab.ui.control.Label
        YPositionEditField              matlab.ui.control.NumericEditField
        YPositionEditFieldLabel         matlab.ui.control.Label
        XPositionEditField              matlab.ui.control.NumericEditField
        XPositionEditFieldLabel         matlab.ui.control.Label
        SensorCalibrationstateLamp      matlab.ui.control.Lamp
        CalibrationstateLabel           matlab.ui.control.Label
        FisrtmappingpointXpositionmmEditField  matlab.ui.control.NumericEditField
        FisrtmappingpointXpositionmmEditFieldLabel  matlab.ui.control.Label
        EnergylevelVSpinner             matlab.ui.control.Spinner
        EnergylevelVSpinnerLabel        matlab.ui.control.Label
        NumberoflasershotburstmodeEditField  matlab.ui.control.NumericEditField
        NumberoflasershotburstmodeEditFieldLabel  matlab.ui.control.Label
        TimebetweentwolasershotsecondEditField  matlab.ui.control.NumericEditField
        TimebetweentwolasershotsecondEditFieldLabel  matlab.ui.control.Label
        MicroprobefocaldistanceinZaxismmEditField  matlab.ui.control.NumericEditField
        MicroprobefocaldistanceinZaxismmEditFieldLabel  matlab.ui.control.Label
        SurfaceoffestmmEditField        matlab.ui.control.NumericEditField
        SurfaceoffestmmEditFieldLabel   matlab.ui.control.Label
        ZonesizeYaxismmEditField        matlab.ui.control.NumericEditField
        ZonesizeYaxismmEditFieldLabel   matlab.ui.control.Label
        ZonesizeXaxismmEditField        matlab.ui.control.NumericEditField
        ZonesizeXaxismmEditFieldLabel   matlab.ui.control.Label
        MaximumheightmmofthesampleEditField  matlab.ui.control.NumericEditField
        MaximumheightmmofthesampleEditFieldLabel  matlab.ui.control.Label
        MappingStepmmEditField          matlab.ui.control.NumericEditField
        MappingStepmmEditFieldLabel     matlab.ui.control.Label
        MapNameEditField                matlab.ui.control.EditField
        MapNameEditFieldLabel           matlab.ui.control.Label
        ButtonGroupMappingSpeed         matlab.ui.container.ButtonGroup
        FastMappingButton               matlab.ui.control.RadioButton
        WithrepositioningButton         matlab.ui.control.RadioButton
        ClearMapButton                  matlab.ui.control.Button
        LampVoltageSet                  matlab.ui.control.Lamp
        GetStateButton                  matlab.ui.control.Button
        GOTOButton                      matlab.ui.control.Button
        GetTempButton                   matlab.ui.control.Button
        DisconnectButton                matlab.ui.control.Button
        AffichageState                  matlab.ui.control.Label
        DisconnectRobotButton           matlab.ui.control.Button
        AffichageTemperature            matlab.ui.control.Label
        Lamp_LampONorOFF                matlab.ui.control.Lamp
        TurnLampOffButton               matlab.ui.control.Button
        TurnLampOnButton                matlab.ui.control.Button
        GotoPositionButton              matlab.ui.control.Button
        LaunchBurstButton               matlab.ui.control.Button
        LaunchSensorCalibrationButton   matlab.ui.control.Button
        StateLampOpotek                 matlab.ui.control.Lamp
        ConnectLaserButton              matlab.ui.control.Button
        StateLampRobot                  matlab.ui.control.Lamp
        RobotConnexionB                 matlab.ui.control.Button
        MappingChoiceButtonGroup        matlab.ui.container.ButtonGroup
        LampWithSpectro_2D              matlab.ui.control.Lamp
        DMassSpectometryButton          matlab.ui.control.RadioButton
        LampWithSpectro                 matlab.ui.control.Lamp
        LampOnlyTopo                    matlab.ui.control.Lamp
        WithMassSpectometryButton       matlab.ui.control.RadioButton
        OnlyTopographicButton           matlab.ui.control.RadioButton
        LaunchMappingButton             matlab.ui.control.Button
        ProcessingTab                   matlab.ui.container.Tab
        AdditionnalDataExtractionFeaturesLabel  matlab.ui.control.Label
        ReconstructionLabel             matlab.ui.control.Label
        PreprocessingLabel              matlab.ui.control.Label
        ScanSelectionLabel              matlab.ui.control.Label
        mzXMLLoadingLabel               matlab.ui.control.Label
        ScanSelectionMethodDropDown     matlab.ui.control.DropDown
        ScanSelectionMethodDropDownLabel  matlab.ui.control.Label
        ScanSelectionButton             matlab.ui.control.Button
        MinEditField                    matlab.ui.control.NumericEditField
        MinEditFieldLabel               matlab.ui.control.Label
        MaxEditField                    matlab.ui.control.NumericEditField
        MaxEditFieldLabel               matlab.ui.control.Label
        LoadmzXMLButton                 matlab.ui.control.Button
        LouddataonthemapSwitch          matlab.ui.control.Switch
        LouddataonthemapSwitchLabel     matlab.ui.control.Label
        MapfilenameEditField_2          matlab.ui.control.EditField
        MapfilenameEditField_2Label     matlab.ui.control.Label
        mapLabel_5                      matlab.ui.control.Label
        FusionpercentSlider             matlab.ui.control.Slider
        FusionpercentSliderLabel        matlab.ui.control.Label
        MapFromSpectraButton            matlab.ui.control.Button
        InternalTriggeringSwitch        matlab.ui.control.Switch
        InternalTriggeringSwitchLabel   matlab.ui.control.Label
        PlotChromatogramButton          matlab.ui.control.Button
        TimeValue                       matlab.ui.control.Label
        ExtractSpectraZoneButton        matlab.ui.control.Button
        ExtractOneSpectraButton         matlab.ui.control.Button
        LaunchTimeEstimationButton      matlab.ui.control.Button
        LoudthresholdEditField          matlab.ui.control.NumericEditField
        LoudthresholdEditFieldLabel     matlab.ui.control.Label
        Timebetween2lasershotsecondEditField  matlab.ui.control.NumericEditField
        Timebetween2lasershotsecondEditFieldLabel  matlab.ui.control.Label
        LaunchReconstructionButton      matlab.ui.control.Button
        MapfilenameEditField            matlab.ui.control.EditField
        MapfilenameEditFieldLabel       matlab.ui.control.Label
        mapLabel_2                      matlab.ui.control.Label
        biomapLabel                     matlab.ui.control.Label
        NameofthegeneratedbiomapfileEditField  matlab.ui.control.EditField
        NameofthegeneratedbiomapfileEditFieldLabel  matlab.ui.control.Label
        maximumEditField                matlab.ui.control.NumericEditField
        maximumEditFieldLabel           matlab.ui.control.Label
        MasslimitsminimumEditField      matlab.ui.control.NumericEditField
        MasslimitsminimumEditFieldLabel  matlab.ui.control.Label
        matLabel_2                      matlab.ui.control.Label
        MatfilenameEditField            matlab.ui.control.EditField
        MatfilenameEditFieldLabel       matlab.ui.control.Label
        LaunchPreprocessingButton       matlab.ui.control.Button
        BiningwindowsizeEditField       matlab.ui.control.NumericEditField
        BiningwindowsizeEditFieldLabel  matlab.ui.control.Label
        BeginThresholdEditField         matlab.ui.control.NumericEditField
        BeginThresholdEditFieldLabel    matlab.ui.control.Label
        matLabel                        matlab.ui.control.Label
        mzXMLLabel                      matlab.ui.control.Label
        NameofthegeneratedmatfileEditField  matlab.ui.control.EditField
        NameofthegeneratedmatfileEditFieldLabel  matlab.ui.control.Label
        mzXMLfilenameEditField          matlab.ui.control.EditField
        mzXMLfilenameEditFieldLabel     matlab.ui.control.Label
        PostProcessingTab               matlab.ui.container.Tab
        BiometricDataInterpolationLabel  matlab.ui.control.Label
        TopographicInterpolationLabel   matlab.ui.control.Label
        TopographicCorrectionLabel      matlab.ui.control.Label
        PointMultiplierEditField_2      matlab.ui.control.NumericEditField
        PointMultiplierEditField_2Label  matlab.ui.control.Label
        NameoftheinterpolatedbiomapEditField  matlab.ui.control.EditField
        NameoftheinterpolatedbiomapEditFieldLabel  matlab.ui.control.Label
        NameofthebiomapEditField        matlab.ui.control.EditField
        NameofthebiomapEditFieldLabel   matlab.ui.control.Label
        biomapLabel_3                   matlab.ui.control.Label
        biomapLabel_2                   matlab.ui.control.Label
        LaunchBiomapInterpolationButton  matlab.ui.control.Button
        PointMultiplierEditField        matlab.ui.control.NumericEditField
        PointMultiplierEditFieldLabel   matlab.ui.control.Label
        NameoftheinterpolatedmapEditField  matlab.ui.control.EditField
        NameoftheinterpolatedmapEditFieldLabel  matlab.ui.control.Label
        NameofthemapEditField_22        matlab.ui.control.EditField
        NameofthemapEditField_2Label    matlab.ui.control.Label
        mapLabel_7                      matlab.ui.control.Label
        mapLabel_6                      matlab.ui.control.Label
        LaunchInterpolationButton       matlab.ui.control.Button
        MaximumthresholdmmEditField     matlab.ui.control.NumericEditField
        MaximumthresholdmmEditFieldLabel  matlab.ui.control.Label
        MinimumthresholdmmEditField     matlab.ui.control.NumericEditField
        MinimumthresholdmmEditFieldLabel  matlab.ui.control.Label
        mapLabel_4                      matlab.ui.control.Label
        mapLabel_3                      matlab.ui.control.Label
        LaunchRectificationButton       matlab.ui.control.Button
        NameofthecorrectedmapEditField  matlab.ui.control.EditField
        NameofthecorrectedmapEditFieldLabel  matlab.ui.control.Label
        NameofthemapEditField           matlab.ui.control.EditField
        NameofthemapEditFieldLabel      matlab.ui.control.Label
        DIsplayfromexternaldataTab      matlab.ui.container.Tab
        Label                           matlab.ui.control.Label
        ColorDropDown_6                 matlab.ui.control.DropDown
        ColorDropDown_6Label            matlab.ui.control.Label
        ColorDropDown_5                 matlab.ui.control.DropDown
        ColorDropDown_5Label            matlab.ui.control.Label
        Class06EditField                matlab.ui.control.EditField
        Class06EditFieldLabel           matlab.ui.control.Label
        Class05EditField                matlab.ui.control.EditField
        Class05EditFieldLabel           matlab.ui.control.Label
        Class04EditField                matlab.ui.control.EditField
        Class04EditFieldLabel           matlab.ui.control.Label
        ColorDropDown_4                 matlab.ui.control.DropDown
        ColorDropDown_4Label            matlab.ui.control.Label
        ColorDropDown_3                 matlab.ui.control.DropDown
        ColorDropDown_3Label            matlab.ui.control.Label
        ColorDropDown_2                 matlab.ui.control.DropDown
        ColorDropDown_2Label            matlab.ui.control.Label
        BackgroundColorDropDown         matlab.ui.control.DropDown
        BackgroundColorDropDownLabel    matlab.ui.control.Label
        LaunchLDAReconstructionButton   matlab.ui.control.Button
        Class03EditField                matlab.ui.control.EditField
        Class03EditFieldLabel           matlab.ui.control.Label
        Class02EditField                matlab.ui.control.EditField
        Class02EditFieldLabel           matlab.ui.control.Label
        Class01EditField                matlab.ui.control.EditField
        Class01EditFieldLabel           matlab.ui.control.Label
        NameofthecsvfileEditField       matlab.ui.control.EditField
        NameofthecsvfileEditFieldLabel  matlab.ui.control.Label
        csvLabel                        matlab.ui.control.Label
        NameofthemapfileEditField       matlab.ui.control.EditField
        NameofthemapfileEditFieldLabel  matlab.ui.control.Label
        mapLabel_8                      matlab.ui.control.Label
        matLabel_4                      matlab.ui.control.Label
        NameofthematfileEditField       matlab.ui.control.EditField
        NameofthematfileEditFieldLabel  matlab.ui.control.Label
        ColorDropDown                   matlab.ui.control.DropDown
        ColorDropDownLabel              matlab.ui.control.Label
        Scils_Extraction                matlab.ui.container.Tab
        ExportandcoregisterCSVButton    matlab.ui.control.Button
        ExportrawCSVButton              matlab.ui.control.Button
        NormalizeCSVTICButton           matlab.ui.control.Button
        ExporttoCSVButton               matlab.ui.control.Button
        mapLabel_9                      matlab.ui.control.Label
        matLabel_6                      matlab.ui.control.Label
        InputmapfileEditField           matlab.ui.control.EditField
        InputmapfileEditFieldLabel      matlab.ui.control.Label
        InputmatfileEditField           matlab.ui.control.EditField
        InputmatfileEditFieldLabel      matlab.ui.control.Label
        BinningEditField                matlab.ui.control.NumericEditField
        BinningEditFieldLabel           matlab.ui.control.Label
        MaxMzEditField                  matlab.ui.control.NumericEditField
        MaxMzEditFieldLabel             matlab.ui.control.Label
        MinMzEditField                  matlab.ui.control.NumericEditField
        MinMzEditFieldLabel             matlab.ui.control.Label
        ExporttoCSVfileLabel            matlab.ui.control.Label
        ExportandcoregisterBiomapButton  matlab.ui.control.Button
        ExportrawBioMapButton           matlab.ui.control.Button
        Exportto3DfileplyLabel          matlab.ui.control.Label
        ExporttoSCILSImzmlLabel         matlab.ui.control.Label
        LaunchExtractionButton          matlab.ui.control.Button
        txtLabel                        matlab.ui.control.Label
        OutputnameofthecreatedtxtfileEditField  matlab.ui.control.EditField
        OutputnameofthecreatedtxtfileEditFieldLabel  matlab.ui.control.Label
        InputMatfilenameEditField_scils  matlab.ui.control.EditField
        InputMatfilenameEditFieldLabel  matlab.ui.control.Label
        matLabel_5                      matlab.ui.control.Label
    end


    properties (Access = private)
        valmin = 0; % Minimum M/z for 'Map from spectra'
        valmax = 2000; % Maximum M/z for 'Map from spectra'
    end


    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            
            % Add folders to the workspace

            path(path,"code/utils");
            path(path,'to add'); % Sert à qqch ?

            list_folders_to_import = [find_folders_and_subfolders("code");find_folders_and_subfolders("files")];
            si=size(list_folders_to_import);
            for i = 1 : si(1)
                path(path,list_folders_to_import(i));
            end
            
            % Variables initialisation

            global state; % Global variable that contains all the state of the system
            state.arret = 0; % security flag => the system will stop itself if state.stop_flag == 1 #TODO -> update new state names everywhere
            state.opo = 0; % laser connexion => if connected state.laser == 1
            state.etal = 0; % calibration state => if the calibration is done state.calibration == 1
            state.robot = 0;  % robot connexion => if connected state.robot == 1

            global old_name;
            old_name = "";

            global mzXML; % contain all data related to mass spectra
            mzXML.is_loaded = 0; % flag to know if there is any mass spectra data loaded

            %% Automatic workspace exemple 

            Folder_path = './code/hardware/robot/*.m';
            OptionNameTab = folder_scan_without_extension(Folder_path);
            % On retire les templates dans le menu déroulant
            OptionName=[];
            for i = OptionNameTab
                if i ~= "_template_(name_MUST_be_changed)"
                    OptionName=[OptionName;i];
                end
            end
            app.RobotDropDown.Items = OptionName;

            Folder_path = './code/hardware/laser/*.m';
            OptionNameTab = folder_scan_without_extension(Folder_path);
            % On retire les templates dans le menu déroulant
            OptionName=[];
            for i = OptionNameTab
                if i ~= "_template_(name_MUST_be_changed)"
                    OptionName=[OptionName;i];
                end
            end
            app.LaserDropDown.Items = OptionName;

            Folder_path = './code/hardware/sensor/*.m';
            OptionNameTab = folder_scan_without_extension(Folder_path);
            % On retire les templates dans le menu déroulant
            OptionName=[];
            for i = OptionNameTab
                if i ~= "_template_(name_MUST_be_changed)"
                    OptionName=[OptionName;i];
                end
            end
            app.SensorDropDown.Items = OptionName;

            Folder_path = './code/method/scan_selection/*.m';
            OptionNameTab = folder_scan_without_extension(Folder_path);
            % On retire les templates dans le menu déroulant
            OptionName=[];
            for i = OptionNameTab
                if i ~= "_template_(name_MUST_be_changed)"
                    OptionName=[OptionName;i];
                end
            end
            app.ScanSelectionMethodDropDown.Items = OptionName;

            % CODE A DECOMMENTER POUR AJOUTER LA CORRECTION DE WORKSPACE
%             dest = '/home/pchaillo/Documents/prism'; % chemin en dur, à bien choisir avant de décommenter cette partie
%             cd(dest);
        end

        % Button pushed function: LaunchMappingButton
        function LaunchMappingButtonPushed(app, event)


            app.NoMappingLabel.Text = 'Mapping in progress...';

            % Variables initialisation
            global scan;
            global zone;
            global state;

            state.arret = 0; % permet arret securité total en cas de soucis

            global carte;
            carte.x = 0;
            carte.y = 0;
            carte.i = 0;
            carte.r = 0;
            carte.time = 0;
        
            global laser;

             %   global t; % obsolete, remplace par robot.connexion
            global robot;
            global sensor;

            %% Parameters => Import user parameters from the GUI
            nom_1 = app.MapNameEditField.Value;
            check_isempty(nom_1,'.map');
            nom = strcat(nom_1,'.map');
            scan.pas = app.MappingStepmmEditField.Value;         % mapping step (mm)
            scan.hmax = app.MaximumheightmmofthesampleEditField.Value;         % maximum height (mm) of the sample you want to map, add a little bit more than real height
            zone.dec = app.FisrtmappingpointXpositionmmEditField.Value;         % x offset (mm) between the robot base and the robot head
            zone.dim_x = app.ZonesizeXaxismmEditField.Value;        % dimension of the mapping zone in the x axis, should be an even value % Even value only ???? #TODO
            zone.dim_y = app.ZonesizeYaxismmEditField.Value;        % dimension of the mapping zone in the y axis, should be an even value
            scan.s_offset = app.SurfaceoffestmmEditField.Value;        % surface offset in mm
            scan.dh = app.MicroprobefocaldistanceinZaxismmEditField.Value + scan.s_offset;          % z offset between the robot arm and the sample to be analysed

            scan.voltage_value = app.EnergylevelVSpinner.Value; % With some laser, you may set the voltage you want in order to tune the intensity of the laser
            scan.t_b = app.TimebetweentwolasershotsecondEditField.Value; % pause time between two laser shot, in second
            scan.nb_shot = app.NumberoflasershotburstmodeEditField.Value; % number of shot for the burst mode
            %             biometrical_scanning = 1; % 0 only topographical / 1 total scanning % useless ? #TODO

            % Mapping Variable %
            scan.etal = 0.25; % pas d'étallonage => 0.25 mm recommandé / step of the camera calibration
            scan.pre = 2; % multiplier for the number of point in the map from the scanning : if scanning step=1mm then a factor of 1 will keep this resolution, a factor of two will create a map with point every 0.5mm

            laser.continuous_flag = app.ContinuousLaserCheckBox.Value; % 0 => no continuous / 1 => continuous

            seuil = 0; % used in record_map4 => useful ? #TODO

            scan.fast = app.FastMappingButton.Value; % I think it's a variable to not do repositionning if it's difficult to get height data from depth sensor

            ard = sensor.connexion; % connect the arduino for spectro triggering) 

            pos_i= [zone.dec  2  scan.dh 180 0 180]; % initial position
            robot.class.set_position(robot.connexion,pos_i);  % send the mapping initial position of the robot

            %% To select and launch the mapping code
            if app.WithMassSpectometryButton.Value %% For 3D imaging with Mass Spectrometry
                time_ref = trigger_spectro_time(ard);
                real_time_mapping_scanning_2(robot,sensor,laser,scan.t_b,scan.nb_shot,time_ref); % do the mapping step
            elseif app.OnlyTopographicButton.Value %% For 3D acquisition only (without mass spectrometry)
                topographic_mapping(robot,sensor);
            elseif app.DMassSpectometryButton.Value  %% For 2D imaging with Mass Spectrometry
                time_ref = trigger_spectro_time(ard);
                scanning_2d_2(robot,laser,scan.nb_shot,scan.t_b,time_ref);
            else
                disp('ERROR - Mapping choice problem');
            end

            %[ carte.r, nb_err ] = recti(carte.i); % correction of the map %%( delete impossible values ) #TODO
            carte.r = carte.i; % two time the same ! #TODO
            figure(4)
            subplot(2,4,[1,2,5,6]), mesh(carte.x,carte.y,carte.i); % initial map
            axis equal
            subplot(2,4,[3,4,7,8]), mesh(carte.x,carte.y,carte.r); % rectified map
            axis equal

            time_rec = record_map(carte.x,carte.y,carte.r,nom,seuil,false,carte.time);

            time_text = strcat('Map finished. Recommended reconstruction time : ',time_rec);
            app.NoMappingLabel.Text = time_text;

            % once the map is done, go back to the 1st point position
            pos_d_i= [zone.dec  2  scan.dh 180 0 180];
            robot.class.set_position(robot.connexion,pos_d_i);  % send the mapping initial position of the robot

            % hugh_to_sleep(t);

        end

        % Button pushed function: RobotConnexionB
        function RobotConnexionBButtonPushed(app, event)
        
            app.StateLampRobot.Color = [0 0 1];
        
            global robot; % ou fermeture de la connexion

            robot.type = app.RobotDropDown.Value;

            robot.class = eval(robot.type);

            robot.connexion = robot.class.connect();
            app.StateLampRobot.Color = [0 1 0];
            app.LampOnlyTopo.Color = [0 1 0];

            global state;
            state.robot = 1 ;

        end

        % Button pushed function: ConnectLaserButton
        function ConnectLaserButtonPushed(app, event)
            app.StateLampOpotek.Color = [0 0 1];
            
            global scan;
            global laser

            scan.voltage_value = app.EnergylevelVSpinner.Value; % put on laser variable instead ?  % #TODO
            laser.type = app.LaserDropDown.Value;

            app.StateLampOpotek.Color = [0 0 1];

            disp("Laser Energy Level : " + scan.voltage_value)
            disp("Laser Type : " + laser.type)

            laser.class = eval(laser.type);

            laser.connexion = laser.class.init();

            [state_string, state_double] = laser.class.get_state(laser.connexion);

            % State double : describe the state of the laser => 
            % 0 - Not connected
            % 1 - Connected - Ready to turn the lamp on
            % 2 - Lamp on - Ready for shooting
            % -1 - Emergency - Problem during communication
    
            if state_double == 1 || state_double == 2
                app.StateLampOpotek.Color = [0 1 0];
            end

            app.AffichageState.Text = state_string;

            if laser.type == "Opotek IR Radiant"
                wdog_loop = 1; % there is a watchdog on Opotek laser (also on Opolette ?) that put the laser in security mode if there is no message for 4 seconds. So I send message each 2 seconds. If the laser is in security mode, you should restart it in order to be able to command it again.
                while wdog_loop == 1
                    [state_string, state_double]= laser.class.get_state(laser.connexion);
                    if state_string == -1
                        wdog_loop = 0;
                        disp('Loose connexion : no more Opotek feedback')
                    end
                    app.AffichageState.Text = state_string;
                    pause(2);
                end
            end

        end

        % Button pushed function: LaunchSensorCalibrationButton
        function LaunchSensorCalibrationButtonPushed(app, event)
            app.SensorCalibrationstateLamp.Color = [0 0 1];

            
            global etal;
            global robot;
            global scan;
            global zone;
            global state;
            global sensor;

            scan.etal = 0.25; % pas d'étallonage => 0.25 mm recommandé / step for the camera calibration % variable dans l'interface % #TODO
            zone.dec = app.FisrtmappingpointXpositionmmEditField.Value;         % x offset (mm) between the robot base and the robot head
            scan.s_offset = app.SurfaceoffestmmEditField.Value;        % surface offset in mm
            scan.hmax = app.MaximumheightmmofthesampleEditField.Value;         % maximum height (mm) of the sample you want to map, add a little bit more than real height

            % ard = arduino(); % connect the arduino (sensor acquisition and spectro triggering)

            if sensor.class.need_calibration == 1
                calibration_array = sensor.class.calibration(robot,sensor); % calibration of the sensor (ILD1320-25)
                sensor.calibration_array = fix_calibration_array(calibration_array); % correction of the calibration ( delete false values )
            
                % Show the calibration graph
                figure()
                hold on
                for i = 1 : length(sensor.calibration_array)
                    scatter(sensor.calibration_array(1,i),sensor.calibration_array(2,i))
                end
                xlabel('Hauteur de mesure, en mm')
                ylabel('Tension mesuree')
                hold off
                app.SensorCalibrationstateLamp.Color = [0 1 0];
                app.LampOnlyTopo.Color = [0 1 0];
                state.etal = 1;
                if state.opo == 1
                    app.LampWithSpectro.Color = [0 1 0];
                end
            else 
                disp("No calibration needed for this sensor")
            end
        end

        % Button pushed function: LaunchBurstButton
        function LaunchBurstButtonPushed(app, event)
            global laser;
            global scan;
            scan.nb_shot = app.NumberoflasershotburstmodeEditField.Value; % number of shot for the burst mode

            laser.class.tir(laser.connexion,scan.nb_shot)

        end

        % Button pushed function: GotoPositionButton
        function GotoPositionButtonPushed(app, event)

            global scan;
            global robot;
            global zone;

            %for security check
            scan.hmax = app.MaximumheightmmofthesampleEditField.Value;         % maximum height (mm) of the sample you want to map, add a little bit more than real height
            scan.s_offset = app.SurfaceoffestmmEditField.Value;        % surface offset in mm

            zone.dec = app.FisrtmappingpointXpositionmmEditField.Value;         % x offset (mm) between the robot base and the robot head

            scan.s_offset = app.SurfaceoffestmmEditField.Value;        % surface offset in mm
            scan.dh = app.MicroprobefocaldistanceinZaxismmEditField.Value + scan.s_offset;          % z offset between the robot arm and the sample to be analysed

            pos_i = [zone.dec  2  scan.dh 180 0 180]; % Initial position 
            robot.class.current_x = zone.dec;
            robot.class.current_y = 2;
            robot.class.current_z = scan.dh;
            robot.class.set_position(robot.connexion,pos_i);  % send the initial position to the robot

        end

        % Callback function
        function LoadCalibrationFileButtonPushed(app, event)
            global etal;

            nom_1 = app.EtalfilenameEditField.Value;
            nom = strcat(nom_1,'.etal');

            etal.tab_etal = load_etal_fcn(nom);

            app.SensorCalibrationstateLamp.Color = [0 1 0];

        end

        % Callback function
        function LaunchPolynomialInterpolationButtonPushed(app, event)
            global carte;
            global scan;
            scan.pre = 2;

            poly_appro_top()
            figure()
            mesh(carte.x_o,carte.y_o,carte.o);
            %colormap(autumn);
            axis equal
            grid off
            axis off
        end

        % Callback function
        function RecordInterpolatedMapButtonPushed(app, event)
            global carte
            seuil = 0;
            nom_1 = app.MapNameEditField.Value;
            nom = strcat(nom_1,'_2.map');
            record_map2(carte.x_o,carte.y_o,carte.o,nom,seuil)
        end

        % Button pushed function: TurnLampOnButton
        function TurnLampOnButtonPushed(app, event)
            app.Lamp_LampONorOFF.Color = [0 0 1];
            global laser;

            temp = laser.class.get_temp(laser.connexion);
            text_temp = strcat('Temperature : ', num2str(temp),'°C');
            app.AffichageTemperature.Text = text_temp;

            state_string = laser.class.lamp_on(laser.connexion);
            [state_string, state_double] = laser.class.get_state(laser.connexion);
            app.AffichageState.Text = state_string;

            if state_double == 2
                app.Lamp_LampONorOFF.Color = [0 1 0];
            else
                app.Lamp_LampONorOFF.Color = [ 1 0 0];
            end

            global state;
            if state.etal == 1
                app.LampWithSpectro.Color = [0 1 0];
            end
            if state.robot == 1
                app.LampWithSpectro_2D.Color = [0 1 0];
            end
            state.opo = 1;
        end

        % Button pushed function: TurnLampOffButton
        function TurnLampOffButtonPushed(app, event)
            global laser;
            state_string = laser.class.lamp_off(laser.connexion);
            [state_text, state_double] = laser.class.get_state(laser.connexion);
            if state_double == 1
                app.Lamp_LampONorOFF.Color = [1 0 0];
            else
                app.Lamp_LampONorOFF.Color = [0 1 1];
            end
            app.AffichageState.Text = state_text;

            %app.Lamp_LampONorOFF.Color = [0 1 1];
        end

        % Button pushed function: DisconnectRobotButton
        function DisconnectRobotButtonPushed(app, event)
            global robot;
            global scan;
            %for security check
            scan.hmax = app.MaximumheightmmofthesampleEditField.Value;         % maximum height (mm) of the sample you want to map, add a little bit more than real height
            scan.s_offset = app.SurfaceoffestmmEditField.Value;        % surface offset in mm

            robot.class.go_to_rest_position(robot.connexion);

            app.StateLampRobot.Color = [1 0 0];

            global state;
            state.robot = 0;
            app.LampWithSpectro.Color = [1 0 0];
            app.LampWithSpectro_2D.Color = [1 0 0];
            app.LampOnlyTopo.Color = [1 0 0];
        end

        % Button pushed function: DisconnectButton
        function DisconnectButtonPushed(app, event)
            global laser; 
            laser.class.disconnect(laser.connexion);
            app.StateLampOpotek.Color = [1 0 0];
        end

        % Button pushed function: GetTempButton
        function GetTempButtonPushed(app, event)
            global laser; % #TODO
            temp = laser.class.get_temp(laser.connexion);
            text_temp = strcat('Temperature :  ', num2str(temp),'°C');
            app.AffichageTemperature.Text = text_temp;
        end

        % Button pushed function: GOTOButton
        function GOTOButtonPushed(app, event)
            global robot;
            global scan;

            %for security check
            scan.hmax = app.MaximumheightmmofthesampleEditField.Value;         % maximum height (mm) of the sample you want to map, add a little bit more than real height
            scan.s_offset = app.SurfaceoffestmmEditField.Value;        % surface offset in mm

            x = app.XPositionEditField.Value;
            y = app.YPositionEditField.Value;
            z = app.ZPositionEditField.Value;
            pos_d_i= [x  y  z 180 0 180];
            robot.class.set_position(robot.connexion,pos_d_i);  % send the mapping initial position of the robot

        end

        % Button pushed function: GetStateButton
        function GetStateButtonPushed(app, event)
            global laser;
            global state;
            [state_text, state_double] = laser.class.get_state(laser.connexion);
            % state_text = choose_state_text(state_double);
            if state_double == -1
                app.Lamp_LampONorOFF.Color = [1 0 0];
                app.LampWithSpectro.Color = [1 0 0];
                app.StateLampOpotek.Color = [1 0 0];
                state.opo = 0;
            elseif state_double == 0
                app.Lamp_LampONorOFF.Color = [1 0 0];
                app.LampWithSpectro.Color = [1 0 0];
                app.StateLampOpotek.Color = [1 0 0];
                state.opo = 0;
            elseif state_double == 1
                app.Lamp_LampONorOFF.Color = [1 0 0];
                app.StateLampOpotek.Color = [0 1 0];
                state.opo = 1;
            elseif state_double == 1
                app.Lamp_LampONorOFF.Color = [1 0 0];
                app.StateLampOpotek.Color = [0 1 0];
                state.opo = 1;
            end

%             if state_double ~= 2
%                 app.Lamp_LampONorOFF.Color = [1 0 0];
%                 app.LampWithSpectro.Color = [1 0 0];
%                 state.opo = 0;
%             end
            app.AffichageState.Text = state_text;

        end

        % Value changed function: EnergylevelVSpinner
        function EnergylevelVSpinnerValueChanged(app, event)
            global scan;
            global laser;

            app.LampVoltageSet.Color = [0 0 1];

            scan.voltage_value = app.EnergylevelVSpinner.Value;
            real_voltage = laser.class.set_voltage(laser.connexion,scan.voltage_value);
            if real_voltage ~= scan.voltage_value
                app.LampVoltageSet.Color = [1 0 0];
            else
                app.LampVoltageSet.Color = [0 1 0];
            end

        end

        % Button pushed function: ClearMapButton
        function ClearMapButtonPushed(app, event)
            global carte;
            %             global zone;
            %             global scan;
            %             scan.pas = app.MappingStepmmEditField.Value;         % mapping step (mm)
            %             zone.dec = app.FisrtmappingpointXpositionmmEditField.Value;         % x offset (mm) between the robot base and the robot head
            %             zone.dim_x = app.ZonesizeXaxismmEditField.Value;        % dimension of the mapping zone in the x axis, should be an even value
            %             zone.dim_y = app.ZonesizeYaxismmEditField.Value;        % dimension of the mapping zone in the y axis, should be an even value
            carte.x = 0;
            carte.y = 0;
            carte.i = 0;
            carte.r = 0;


        end

        % Selection changed function: ButtonGroupMappingSpeed
        function ButtonGroupMappingSpeedSelectionChanged(app, event)
            global scan;
            scan.fast = app.FastMappingButton.Value;
        end

        % Close request function: UIFigure
        function UIFigureCloseRequest(app, event)
            %% deconnecte le robot
            global robot;
            global scan;
            %for security check
            scan.hmax = app.MaximumheightmmofthesampleEditField.Value;         % maximum height (mm) of the sample you want to map, add a little bit more than real height
            scan.s_offset = app.SurfaceoffestmmEditField.Value;        % surface offset in mm

            global state;
            if isfield(state,'robot')
                if state.robot == 1
                    robot.class.disconnect(robot.connexion);
                end
            end
            app.StateLampRobot.Color = [1 0 0];

            global state;
            state.robot = 0;
            app.LampWithSpectro.Color = [1 0 0];
            app.LampWithSpectro_2D.Color = [1 0 0];
            app.LampOnlyTopo.Color = [1 0 0];

            %% Close the app
            delete(app)

        end

        % Callback function
        function LaunchPeakDetectionButtonPushed(app, event)
%% Code encore utilise ?
disp("FONCTION COMMENTE => REPRENDRE DANS MLAPP (Peak Detection)")

%             global mzXML;
% 
%             threshold_begin = app.BeginThresholdEditField.Value;
%             t_b = app.Timebetween2lasershotsecondEditField.Value;
%             min_threshold = app.LoudthresholdEditField.Value;
% 
%             tolerance = app.FusionpercentSlider.Value;
% 
%             intern_trig = app.InternalTriggeringSwitch.Value;
% 
%             nom_map_r = app.MapfilenameEditField_2.Value;
%             nom_map = strcat(nom_map_r,'.map');
%             %out = load(nom_map); % load topographical map. Remove any dot in the file name
%             carte = load_map_fcn(nom_map);
% 
%             if isfield(carte,'time')
%                 carte_time = carte.time;
%             else
%                 carte_time = 0;
%             end
% 
%             fprintf('(%s) - Filtering the mzXML file to keep only the image related spectra\n', datestr(now,'HH:MM:SS'));
% 
%             if intern_trig(1:2) == 'On'
%                 intern_flag = 1;
%             else
%                 intern_flag = 0;
%             end
% 
%             disp(threshold_begin)
%             disp(t_b)
%             disp(min_threshold)
%             disp(tolerance)
%             disp(intern_trig)
% 
%             [pixels_scans ,time] = Peak_picking(mzXML.Struct,threshold_begin,t_b,min_threshold,intern_flag,tolerance,carte_time); % take only the usefull informations
%             % pixels_scans => scan, that contains one mass spectra, that is relative to one laser shot, one pixel on the image
%             mzXML.pixels_scans = pixels_scans;
% 
%             time_str = num2str(time);
%             time_str2 = strcat(time_str, ' seconds');
%             app.TimeValue.Text = time_str2;
% 
%             disp(length(pixels_scans));
        end

        % Button pushed function: LaunchPreprocessingButton
        function LaunchPreprocessingButtonPushed(app, event)

            global mzXML;
            pixels_scans = mzXML.pixels_scans;

            win = app.BiningwindowsizeEditField.Value;

            mat_r = app.NameofthegeneratedmatfileEditField.Value;
            check_isempty(mat_r,'.mat')
            nom = strcat(mat_r,'.mat');

            l = length(pixels_scans);

            fprintf('(%s) - Preprocessing data \n', datestr(now,'HH:MM:SS'));
            for i = 1 : l
                pixels_scans_processed(i) = preprocess(pixels_scans(i),win); % pixels_scans_processed
                X = sprintf('Preprocessing : %d / %d',i,l);
                disp(X)
            end

            threshold_begin = app.BeginThresholdEditField.Value;
            t_b = app.Timebetween2lasershotsecondEditField.Value;
            min_threshold = app.LoudthresholdEditField.Value;

            tolerance = app.FusionpercentSlider.Value;

            intern_trig = app.InternalTriggeringSwitch.Value;
            if intern_trig(1:2) == 'On'
                intern_flag = 1;
            else
                intern_flag = 0;
            end

            pixels_scans = pixels_scans_processed; % Vraiment utile ? C'est pas mieux de differencier les 2 ? #TODO

            pixels_scans(1).comment = [threshold_begin, min_threshold, t_b,tolerance,intern_flag ]; % to stock the parameters somewhere with the data

            save('pixels_scans.mat', 'pixels_scans')
            folder_name = 'files/mat files';
            chemin  = choix_chemin(folder_name,nom);
            movefile('pixels_scans.mat',chemin);
        end

        % Value changed function: MapfilenameEditField
        function MapfilenameEditFieldValueChanged(app, event)
            nom_map = app.MapfilenameEditField.Value;
            limits = app.MasslimitsminimumEditField.Value;

            limi = round(limits(1));
            mass_str = num2str(limi);
            nom = strcat( nom_map,'_',mass_str);%,'.biomap');

            app.NameofthegeneratedbiomapfileEditField.Value = nom;
        end

        % Value changed function: MasslimitsminimumEditField
        function MasslimitsminimumEditFieldValueChanged(app, event)
            limits = app.MasslimitsminimumEditField.Value;
            nom_map = app.MapfilenameEditField.Value;

            limi = round(limits(1));
            mass_str = num2str(limi);
            nom = strcat( nom_map,'_',mass_str);%,'.biomap');

            dec = 0.25; % ussual difference between the mass limits

            app.maximumEditField.Value = limits + 0.25;
            app.NameofthegeneratedbiomapfileEditField.Value = nom;
        end

        % Button pushed function: LaunchReconstructionButton
        function LaunchReconstructionButtonPushed(app, event)

%             clearvars map % utile ?

            nom_mat_r = app.MatfilenameEditField.Value;
            nom_mat = strcat(nom_mat_r,'.mat');
            load(nom_mat);

            nom_map_r = app.MapfilenameEditField.Value;
            nom_map = strcat(nom_map_r,'.map');
            map = load_map_fcn(nom_map);

            nom_r = app.NameofthegeneratedbiomapfileEditField.Value;
            nom = strcat(nom_r,'.biomap');

            % seuil = 6; % if the threshold is recorded in the map
            seuil = -1; % #TODO

            l_min = app.MasslimitsminimumEditField.Value;
            l_max = app.maximumEditField.Value;
            limits = [l_min l_max];

            fprintf('(%s) - The map file is loaded \n', datestr(now,'HH:MM:SS'));
            fprintf('(%s) - Starting to build the intensity matrix\n', datestr(now,'HH:MM:SS'));

            loud_data = app.LouddataonthemapSwitch.Value;
            if loud_data(1:2) == 'On'
                loud_flag = 1;
            else
                loud_flag = 0;
            end

            if isfield(map,'time')
                time_flag = 1;
            else
                time_flag = 0;
                carte_time = 0;
            end

             [ pixels_ind, scans_ind, pixels_mz, fusion_tab] = data_on_map(pixels_scans,map,limits,map.time,time_flag,loud_flag);
            %   bio_ind_debug(bio_ind,bio_map,pixels_scans);

            [ map.x,map.y,map.z,pixels_mz  ] = fix_border(map.x,map.y,map.z,pixels_mz,pixels_ind);

             title_str = strcat( "biometric map, mass limits : ", num2str(limits(1)) ,"   ",num2str(limits(2)) ) ;
            display_mz_map(map,pixels_mz,title_str)

%             record_BIOmap(carte_x,carte_y,carte_z,pixels_mz,nom,limits) %
%             #TODO
        end

        % Callback function
        function CreateRGBmapButtonPushed(app, event)
            nom_biomap = app.BiomapfilenameEditField.Value;
            m1 = app.Mass01EditField.Value;
            m2 = app.Mass02EditField.Value;
            m3 = app.Mass03EditField.Value;

            m_1 = num2str(m1);
            m_2 = num2str(m2);
            m_3 = num2str(m3);

            nom_1 = strcat( nom_biomap,'_',m_1,'.biomap');
            nom_2 = strcat( nom_biomap,'_',m_2,'.biomap');
            nom_3 = strcat( nom_biomap,'_',m_3,'.biomap');

            out = load(nom_1);
            out2 = load(nom_2);
            out3 = load(nom_3);

            file_name_r = app.NameofthegeneratedRGBmapEditField.Value;
            file_name = strcat(file_name_r,'.rgbmap');

            %% CODE

            si = size(out);

            %%% Récupération des dimensions %%%
            si_1 = out(1,1);
            si_2 = out(1,2);
            import_limits(1) = out(1,3);
            import_limits(2) = out(1,4);

            i_1 = (import_limits(1)+import_limits(2))/2;

            i_l_2(1) = out2(1,3);
            i_l_2(2) = out2(1,4);

            i_2 = ( i_l_2(1) + i_l_2(2) ) /2;

            i_l_3(1) = out3(1,3);
            i_l_3(2) = out3(1,4);

            i_3 = ( i_l_3(1) + i_l_3(2) ) /2;


            u = 1;

            for i = 1 : si_1
                for j = 1 : si_2
                    u = u + 1;
                    carte_x(i,j) = out(u,1);
                    carte_y(i,j) = out(u,2);
                    carte_z(i,j) = out(u,3);
                    bio_map1(i,j) = out(u,4);
                    bio_map2(i,j) = out2(u,4);
                    bio_map3(i,j) = out3(u,4);
                end
            end

            m1 = max(max(bio_map1));
            m2 = max(max(bio_map2));
            m3 = max(max(bio_map3));

            % mmax = max( max(m1,m2), max(m2,m3) ); %method 1
            %
            % bio_map1_r = bio_map1/mmax;
            % bio_map2_g = bio_map2/mmax;
            % bio_map3_b = bio_map3/mmax; %

            % normalisation des valeurs
            bio_map1_r = bio_map1/m1; %method 2
            bio_map2_g = bio_map2/m2;
            bio_map3_b = bio_map3/m3; %

            bio_map(:,:,1) = bio_map1_r ;
            bio_map(:,:,2) = bio_map2_g ;
            bio_map(:,:,3) = bio_map3_b ;


            figure()
            s = surf(carte_x,carte_y,carte_z,bio_map);
            s.FaceAlpha=0.9; % niveau de tranparence
            s.FaceColor = 'flat'; % set color interpolqtion
            s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
            title(['biometric map, mass limits : ', num2str(i_1),'  ',num2str(i_2),' ',num2str(i_3)]);
            axis equal

            % figure()
            % s = surf(carte_x,carte_y,carte_z,bio_map);
            % s.FaceAlpha=0.9; % niveau de tranparence
            % s.FaceColor = 'interp'; % set color interpolqtion
            % s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
            % title(['biometric map, mass limits : ', num2str(i_1),'  ',num2str(i_2),' ',num2str(i_3)]);
            % axis equal

            data.b1 = bio_map(:,:,1);
            data.b2 = bio_map(:,:,2);
            data.b3 = bio_map(:,:,3);
            data.x = carte_x;
            data.y= carte_y;
            data.z = carte_z;
            data.i1 = i_1;
            data.i2 = i_2;
            data.i3 = i_3;


            record_rgb_map(data,file_name);

        end

        % Callback function
        function LaunchMapPCAAnalysisButtonPushed(app, event)


            a = app.MassesEditField.Value;
            aConverted=str2double(strsplit(a,','));
            mass = aConverted';

            name_int_r = app.BiomapfilenameEditField_2.Value;
            name_int = strcat(name_int_r,'_');


            l = length(mass);
            mass_char = num2str(mass);
            for i = 1 : l % recuperation des informations

                B = convertCharsToStrings(mass_char(i,:));
                nom = strcat(name_int,B,'.biomap');
                [carte_x,carte_y,carte_z,bio_map] = load_BIOmap_fcn_pca(nom);
                bio_map_tab(:,:,i) = bio_map;

            end

            si = size(carte_x);

            ind = 0;
            for x = 1 : si(1) % mise en format ligne de longueur n*m d'un tableau de dimension n par m
                for y = 1 : si(2)

                    ind = ind + 1;

                    pca_ingredients(ind,:) = [bio_map_tab(x,y,1:l)];

                end
            end

            [vect_propres,scores,val_propres,t2] = pca(pca_ingredients);

            % Cette commande permet de réaliser le cercle des corrélations variables
            % sur les deux axes principaux.

            figure('Name','Cercle des corrélations','NumberTitle','off');
            plot(vect_propres(:,1),vect_propres(:,2),'.');
            text(vect_propres(:,1),vect_propres(:,2),mass_char);
            hold on
            [x,y,z] = cylinder(1,200);
            plot(x(1,:),y(1,:))
            hold on
            line([-1 1],[0 0])
            line([0 0],[-1 1])
            axis equal


            % Cette commande permet de réaliser la carte factorielle des individus sur
            % les deux axes principaux.
            Individus_num = [1 : si(1)*si(2)]';
            Individus = num2str(Individus_num);
            %Individus = Individus';

            bande_point = [ 100: 200]';

            figure('Name','Carte factorielle des différents points','NumberTitle','off');
            plot(scores(bande_point,1),scores(bande_point,2),'r+');
            text(scores(bande_point,1),scores(bande_point,2),Individus(bande_point,:));
            a  = axis;
            xl = a(1);xu = a(2);yl = a(3);yu = a(4);
            xlabel('1ère Composante Principale')
            ylabel('2nde Composante Principale')
            hold on
            line([xl xu],[0 0])
            line([0 0],[yl yu])

            ind = 0;
            for x = 1 : si(1)
                for y = 1 : si(2)

                    ind = ind + 1;

                    %pca_ingredients(ind,:) = [bio_map_tab(x,y,1:l)];
                    bio_map_score(x,y) = scores(ind,1);
                    bio_map_score_g(x,y) = scores(ind,2);
                    bio_map_score_b(x,y) = scores(ind,3);

                end
            end

            %% For displaying
            figure('Name','Principal Component Map')
            s = surf(carte_x,carte_y,carte_z,bio_map_score);
            s.FaceAlpha=0.9; % niveau de tranparence
            s.FaceColor = 'flat'; % set color interpolqtion
            s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
            %title(['biometric map, mass limits : ', num2str(import_limits(1)),'  ',num2str(import_limits(2))]);
            axis equal
            %grid off
            axis off

            %
            % bio_map(:,:,1) = bio_map_score ;
            % bio_map(:,:,2) = bio_map_score_g  ;
            % bio_map(:,:,3) = bio_map_score_b  ;
            %
            % figure('Name','3 Principals Component')
            % s = surf(carte_x,carte_y,carte_z,bio_map);
            % s.FaceAlpha=0.9; % niveau de tranparence
            % s.FaceColor = 'flat'; % set color interpolqtion
            % s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
            % %title(['biometric map, mass limits : ', num2str(i_1),'  ',num2str(i_2),' ',num2str(i_3)]);
            % axis equal


            m1 = max(max(bio_map_score));
            m2 = max(max(bio_map_score_g));
            m3 = max(max(bio_map_score_b));
            % normalisation des valeurs
            bio_map1_r = bio_map_score/m1; %method 2
            bio_map2_g = bio_map_score_g/m2;
            bio_map3_b = bio_map_score_b/m3; %

            bio_map(:,:,1) = bio_map1_r ;
            bio_map(:,:,2) = bio_map2_g ;
            bio_map(:,:,3) = bio_map3_b ;

            figure('Name','3 Principals Component RGB map, with normalisation')
            s = surf(carte_x,carte_y,carte_z,bio_map);
            s.FaceAlpha=0.9; % niveau de tranparence
            s.FaceColor = 'flat'; % set color interpolqtion
            s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
            %title(['biometric map, mass limits : ', num2str(i_1),'  ',num2str(i_2),' ',num2str(i_3)]);
            axis equal
        end

        % Value changed function: MatfilenameEditField
        function MatfilenameEditFieldValueChanged(app, event)
            value = app.MatfilenameEditField.Value;
            app.MapfilenameEditField. Value = value;
        end

        % Value changing function: MapfilenameEditField
        function MapfilenameEditFieldValueChanging(app, event)
changingValue = event.Value;

        end

        % Callback function
        function LaunchmatPCAAnalysisButtonPushed(app, event)

            b1 = app.MassbandminEditField.Value;
            b2 = app.maxEditField.Value;
            band = [b1 b2];
            nb_point = app.NumberofpointonthecorrelationcirclemaximummzEditField.Value;
            win = app.BiningwindowmassEditField.Value;
            nom_r = app.MatfilenameEditField_2.Value;
            nom = strcat(nom_r,'.mat');
            load(nom);
            tlp = app.ShowalsoallmassesonanothercorrelationcircleCheckBox.Value;
            mat_pca_circle2(win,band,nb_point,pixels_scans,tlp)


        end

        % Callback function
        function MainmassesonthemapButtonPushed(app, event)

            mat_name_r = app.MatfilenameEditField.Value;
            mat_name = strcat(mat_name_r,'.mat');
            load(mat_name);

            map_name_r = app.MapfilenameEditField.Value;
            map_name = strcat(map_name_r,'.map');
            out = load(map_name);

            seuil = -1;
            %seuil = 6; % for tests

            win = app.BiningwindowEditField.Value;
            l1 = app.MassbandminEditField_2.Value;
            l2 = app.maxEditField_2.Value;
            limits= [l1 l2];

            %% CODE
            %%% Récupération des dimensions %%%
            si = size(out);
            si_1 = out(1,1);
            si_2 = out(1,2);

            u = 1;

            clearvars carte_x
            clearvars carte_y
            clearvars carte_z

            for i = 1 : si_1
                for j = 1 : si_2
                    u = u + 1;
                    carte_x(i,j) = out(u,1);
                    carte_y(i,j) = out(u,2);
                    carte_z(i,j) = out(u,3);
                end
            end
            fprintf('(%s) - The map file is loaded \n', datestr(now,'HH:MM:SS'));


            l = length(pixels_scans);
            for i = 1 : l
                peak_tab4 = bining_2(pixels_scans(i).peaks.mz,win,limits);
                pixels_scans(i).peaks.mz = peak_tab4;
                a = i/l
            end


            fprintf('(%s) - Starting to build the maximum matrix\n', datestr(now,'HH:MM:SS'));
            [ max_ind ,max_map ] = max_on_map(pixels_scans,carte_z,seuil,limits); % put the information on the map

            [ carte_x,carte_y,carte_z,max_map  ] = add_border(carte_x,carte_y,carte_z,max_map);

            fprintf('(%s) - Done, displaying the image\n', datestr(now,'HH:MM:SS'));

            %max_map = max_map - limits(1);

            max_map2 = max_map - limits(1);

            figure()
            %mesh(carte_x,carte_y,carte_z,bio_map);
            s = surf(carte_x,carte_y,carte_z,max_map2);
            s.FaceAlpha = 0.9; % niveau de transparence
            s.FaceColor = 'flat'; % set color interpolation or not
            s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
            axis equal
            title(['maximum map']);

            mass_max_list = unique(max_map);
            for i = 1 : length(mass_max_list)
                ind_v_max = find(max_map == mass_max_list(i));
                tab_nb_max(i) = length(ind_v_max);
            end
            tab_nb_max = tab_nb_max';
            tab_t(:,1) = mass_max_list;
            tab_t(:,2) = tab_nb_max;

            tab_t(1,:) = [];

            tab_t( isnan(tab_t(:,1)) ,:) = []; % supprime les valeurs nulles (NaN)
            max_tri = sort(tab_t(:,2), 'descend');

            nb_point = 3;

            %for i = 1 : nb_point
            mass_max_tab = 0;
            i = 0;
            while length(mass_max_tab) < nb_point % récupère les 1nb_point masses les plus ionisés
                i = i+1
                max_v = max_tri(i);
                loca_ion = find (tab_t(:,2) == max_v);
                if length(loca_ion) ~= 1
                    loca_ion = max(loca_ion);
                end
                mass_max_tab_r(i) = tab_t(loca_ion,1);
                mass_max_tab  = unique(mass_max_tab_r);
            end

            max_map_3 = find_max_zone(max_map,mass_max_tab);

            figure()
            s = surf(carte_x,carte_y,carte_z,max_map_3);
            s.FaceAlpha=0.9; % niveau de tranparence
            s.FaceColor = 'flat'; % set color interpolqtion
            s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
            title(['Mass max zone map, mass (RGB) : R : ', num2str(mass_max_tab(1)),' G : ', num2str(mass_max_tab(2)),' B : ', num2str(mass_max_tab(3))]);
            axis equal
        end

        % Button pushed function: LaunchTimeEstimationButton
        function LaunchTimeEstimationButtonPushed(app, event)

            global mzXML;

            threshold_begin = app.BeginThresholdEditField.Value;
            t_b = app.Timebetween2lasershotsecondEditField.Value;
            min_threshold = app.LoudthresholdEditField.Value;

            fprintf('(%s) - Filtering the mzXML file to keep only the image related spectra\n', datestr(now,'HH:MM:SS'));

            time = time_from_peaks(mzXML.contents,threshold_begin,min_threshold); % take only the usefull informations

            time_str = num2str(time);
            time_str2 = strcat(time_str, ' seconds');
            app.TimeValue.Text = time_str2;

        end

        % Button pushed function: ExtractOneSpectraButton
        function ExtractOneSpectraButtonPushed(app, event)

            nom_mat_r = app.MatfilenameEditField.Value;
            nom_mat = strcat(nom_mat_r,'.mat');
            load(nom_mat)

            nom_map_r = app.MapfilenameEditField.Value;
            nom_map = strcat(nom_map_r,'.map');
            %out = load(nom_map); % load topographical map. Remove any dot in the file name
            carte = load_map_fcn(nom_map);

            l_min = app.MasslimitsminimumEditField.Value;
            l_max = app.maximumEditField.Value;

            limits = [l_min l_max];

            extract_one_spectra(pixels_scans,carte,nom_mat,limits)
        end

        % Button pushed function: ExtractSpectraZoneButton
        function ExtractSpectraZoneButtonPushed(app, event)

            nom_mat_r = app.MatfilenameEditField.Value; % creer une routine de chargement des donnees ? => factoriser aussi pour n'avoir que 3 lignes de chargement ici ? fonction load and load ma
            check_isempty(nom_mat_r,'.mat')
            nom_mat = strcat(nom_mat_r,'.mat');
            load(nom_mat)

            nom_map_r = app.MapfilenameEditField.Value;
            check_isempty(nom_map_r,'.map')
            nom_map = strcat(nom_map_r,'.map');
            %out = load(nom_map); % load topographical map. Remove any dot in the file name
            carte = load_map_fcn(nom_map);
            
%             nom_r = app.NameofthegeneratedbiomapfileEditField.Value; %    inutile ? %TODO ?       
%             check_isempty(nom_r,'.biomap you want to edit')
%             nom = strcat(nom_r,'.biomap');

            % seuil = 6; % if the threshold is recorded in the map
            seuil = -1;

            l_min = app.MasslimitsminimumEditField.Value;
            l_max = app.maximumEditField.Value;

            limits = [l_min l_max];

            extract_spectra_zone(pixels_scans,carte,limits)

        end

        % Button pushed function: PlotChromatogramButton
        function PlotChromatogramButtonPushed(app, event)
            
            global mzXML;


            %             fprintf('(%s) - Loading the mzXML file\n', datestr(now,'HH:MM:SS'));
            %             mzxml_r = app.mzXMLfilenameEditField.Value;
            %             nom_mzxml = strcat(mzxml_r,'.mzXML');
            %             mzXMLStruct = mzxmlread(nom_mzxml);

            if mzXML.is_loaded == 1
                figure()
                plot_chromatogram(mzXML.contents)
            else
                disp("There is no Mass Spectra file loaded : Impossible to plot chromatogram") % ERROR_MESSAGE
            end
        end

        % Value changed function: MappingStepmmEditField
        function MappingStepmmEditFieldValueChanged(app, event)

            size_x = app.ZonesizeXaxismmEditField.Value;
            step_size = app.MappingStepmmEditField.Value;
            size_y = app.ZonesizeYaxismmEditField.Value;
            nb_shot = app.NumberoflasershotburstmodeEditField.Value;
            t_b = app.TimebetweentwolasershotsecondEditField.Value;

            [mapping_time_min, mapping_time_sec] = mapping_time_estimation(size_x,size_y,t_b,step_size,nb_shot);

            mapping_time_text = strcat('Estimation of mapping time :',32, num2str(mapping_time_min), ' min ',32,num2str(mapping_time_sec), '  sec ');
            app.EstimationofmappingtimeLabel.Text = mapping_time_text;
        end

        % Value changed function: ZonesizeXaxismmEditField
        function ZonesizeXaxismmEditFieldValueChanged(app, event)

            size_x = app.ZonesizeXaxismmEditField.Value;
            step_size = app.MappingStepmmEditField.Value;
            size_y = app.ZonesizeYaxismmEditField.Value;
            nb_shot = app.NumberoflasershotburstmodeEditField.Value;
            t_b = app.TimebetweentwolasershotsecondEditField.Value;

            [mapping_time_min, mapping_time_sec] = mapping_time_estimation(size_x,size_y,t_b,step_size,nb_shot);

            mapping_time_text = strcat('Estimation of mapping time :',32, num2str(mapping_time_min), ' min ',32,num2str(mapping_time_sec), '  sec ');
            app.EstimationofmappingtimeLabel.Text = mapping_time_text;
        end

        % Value changed function: ZonesizeYaxismmEditField
        function ZonesizeYaxismmEditFieldValueChanged(app, event)

            size_x = app.ZonesizeXaxismmEditField.Value;
            step_size = app.MappingStepmmEditField.Value;
            size_y = app.ZonesizeYaxismmEditField.Value;
            nb_shot = app.NumberoflasershotburstmodeEditField.Value;
            t_b = app.TimebetweentwolasershotsecondEditField.Value;

            [mapping_time_min, mapping_time_sec] = mapping_time_estimation(size_x,size_y,t_b,step_size,nb_shot);

            mapping_time_text = strcat('Estimation of mapping time :',32, num2str(mapping_time_min), ' min ',32,num2str(mapping_time_sec), '  sec ');
            app.EstimationofmappingtimeLabel.Text = mapping_time_text;
        end

        % Value changed function: TimebetweentwolasershotsecondEditField
        function TimebetweentwolasershotsecondEditFieldValueChanged(app, event)

            size_x = app.ZonesizeXaxismmEditField.Value;
            step_size = app.MappingStepmmEditField.Value;
            size_y = app.ZonesizeYaxismmEditField.Value;
            nb_shot = app.NumberoflasershotburstmodeEditField.Value;
            t_b = app.TimebetweentwolasershotsecondEditField.Value;

            [mapping_time_min, mapping_time_sec] = mapping_time_estimation(size_x,size_y,t_b,step_size,nb_shot);

            mapping_time_text = strcat('Estimation of mapping time :',32, num2str(mapping_time_min), ' min ',32,num2str(mapping_time_sec), '  sec ');
            app.EstimationofmappingtimeLabel.Text = mapping_time_text;
        end

        % Value changed function: NumberoflasershotburstmodeEditField
        function NumberoflasershotburstmodeEditFieldValueChanged(app, event)

            size_x = app.ZonesizeXaxismmEditField.Value;
            step_size = app.MappingStepmmEditField.Value;
            size_y = app.ZonesizeYaxismmEditField.Value;
            nb_shot = app.NumberoflasershotburstmodeEditField.Value;
            t_b = app.TimebetweentwolasershotsecondEditField.Value;

            [mapping_time_min, mapping_time_sec] = mapping_time_estimation(size_x,size_y,t_b,step_size,nb_shot);

            mapping_time_text = strcat('Estimation of mapping time :',32, num2str(mapping_time_min), ' min ',32,num2str(mapping_time_sec), '  sec ');
            app.EstimationofmappingtimeLabel.Text = mapping_time_text;
        end

        % Button pushed function: MapFromSpectraButton
        function MapFromSpectraButtonPushed(app, event)

            valmin = app.valmin
            valmax = app.valmax

            disp([valmin,valmax])

            global all_peaks;
            global old_name;

            nom_mat_r = app.MatfilenameEditField.Value;
            nom_mat = strcat(nom_mat_r,'.mat');
            load(nom_mat) % Load pixels_scans variable // Charge la variable pixels_scans

            nom_map_r = app.MapfilenameEditField.Value;
            nom_map = strcat(nom_map_r,'.map');
            % out = load(nom_map); % load topographical map. Remove any dot in the file name
            carte = load_map_fcn(nom_map);

            %             disp(nom_mat_r)
            %             disp(old_name)

            if nom_mat_r == old_name
                compute_flag = 1;
            else
                compute_flag = 0;
            end

            all_peaks = plot_all_spectra(pixels_scans,compute_flag,all_peaks,valmin,valmax);

            map_from_spectra(pixels_scans,carte);

            old_name = nom_mat_r;
        end

        % Button pushed function: LaunchRectificationButton
        function LaunchRectificationButtonPushed(app, event)

            nom_map_r = app.NameofthemapEditField.Value;
            check_isempty(nom_map_r,'.map')
            nom_map = strcat(nom_map_r,'.map');
            %out = load(nom_map); % load topographical map. Remove any dot in the file name
            map = load_map_fcn(nom_map);

            nom_new_map_r = app.NameofthecorrectedmapEditField.Value;
            nom_map_new = strcat(nom_new_map_r,'.map');

            min_threshold = app.MinimumthresholdmmEditField.Value;
            max_threshold = app.MaximumthresholdmmEditField.Value;

            map_height = map.z;

            [corrected_map_height, nb_err ]= map_rectification(map_height,min_threshold,max_threshold);

            map_out = click_loop_multi(map,corrected_map_height,min_threshold,max_threshold);

            threshold = 0;

            if isfield(map,'time')
                time_diff_med = record_map(map.x,map.y,map_out,nom_map_new,threshold,true,map.time);
            else
                record_map(map.x,map.y,map_out,nom_map_new,threshold);
            end

            %     close all; % fermer au fur et à mesure plutot
        end

        % Button pushed function: LaunchInterpolationButton
        function LaunchInterpolationButtonPushed(app, event)

            nom_map_r = app.NameofthemapEditField_22.Value;
            nom_map = strcat(nom_map_r,'.map');
            %out = load(nom_map); % load topographical map. Remove any dot in the file name
            carte = load_map4_fcn(nom_map);

            nom_new_map_r = app.NameoftheinterpolatedmapEditField.Value;
            nom_map_new = strcat(nom_new_map_r,'.map');

            scan_pre = app.PointMultiplierEditField.Value ;

            [carte_o, carte_x_o, carte_y_o, carte_time_o] = polynomial_interpolation_2(carte,scan_pre);

            seuil = 0;

            if isfield(carte,'time')
                time_diff_med = record_map4(carte_x_o,carte_y_o,carte_o,nom_map_new,seuil,carte_time_o);
            else
                record_map2(carte.x,carte.y,carte_f,nom_map_new,seuil);
            end


        end

        % Button pushed function: LaunchBiomapInterpolationButton
        function LaunchBiomapInterpolationButtonPushed(app, event)

            nom_map_r = app.NameofthebiomapEditField.Value;
            nom_map = strcat(nom_map_r,'.biomap');
            %out = load(nom_map); % load topographical map. Remove any dot in the file name

            [carte,bio_map,limits] = load_biomap_fcn(nom_map);

            nom_new_map_r = app.NameoftheinterpolatedbiomapEditField.Value;
            nom_map_new = strcat(nom_new_map_r,'.biomap');

            scan_pre = app.PointMultiplierEditField_2.Value ;

            si = size(carte.x)-1;

            carte2.x = carte.x(1:si(1),1:si(2));
            carte2.y = carte.y(1:si(1),1:si(2));
            carte2.z = carte.z(1:si(1),1:si(2));
            bio_map2 = bio_map(1:si(1),1:si(2));


            [carte_o, carte_x_o, carte_y_o, carte_time_o, bio_map_o] = polynomial_interpolation_bio3(carte2,scan_pre,bio_map2);

            %           [ carte_x_o,carte_y_o,carte_o,bio_map_o  ] = fix_border_2(carte_x_o,carte_y_o,carte_o,bio_map_o,bio_ind);

            seuil = 0;

            if isfield(carte,'time')
                record_BIOmap_time(carte_x_o,carte_y_o,carte_o,bio_map_o,nom_map_new,limits,carte_time_o,time_diff_med)
            else
                record_BIOmap2(carte_x_o,carte_y_o,carte_o,bio_map_o,nom_map_new,limits)
            end

            figure()
            s = surf(carte_x_o,carte_y_o,carte_o,bio_map_o);
            s.FaceAlpha = 0.9; % niveau de transparence
            s.FaceColor = 'flat'; % set color interpolation or not
            s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
            axis equal
            title(['biometric map, mass limits : ', num2str(limits(1)),'  ',num2str(limits(2))]);

        end

        % Callback function
        function LoadBiomapButtonPushed(app, event)
            nom_r = app.NamebiomapfileEditField.Value;
            nom = strcat(nom_r,'.biomap');

            [carte,bio_map,import_limits] = load_biomap_fcn(nom);

            figure()
            s = surf(carte.x,carte.y,carte.z,bio_map);
            s.FaceAlpha = 0.9; % niveau de transparence
            s.FaceColor = 'flat'; % set color interpolation or not
            s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
            axis equal
            title(['biometric map, mass limits : ', num2str(limits(1)),'  ',num2str(limits(2))]);
        end

        % Button pushed function: LaunchLDAReconstructionButton
        function LaunchLDAReconstructionButtonPushed(app, event)
            
            nom_map_r = app.NameofthemapfileEditField.Value;
            nom_map = strcat(nom_map_r,'.map');
            carte = load_map4_fcn(nom_map);

            nom_mat_r = app.NameofthematfileEditField.Value;
            nom_mat = strcat(nom_mat_r,'.mat');
            load(nom_mat);

            nom_csv_r = app.NameofthecsvfileEditField.Value;
            nom_csv = strcat(nom_csv_r,'.csv');
            T = readtable(nom_csv,'NumHeaderLines',5);  % skips the first three rows of data

            scan.num = T.StartScan;
            scan.num_end = T.EndScan;
            scan.class = T.ClassName;
            scan.prob = T.Probability;

            class(1) = string(app.Class01EditField.Value);
            class(2) = app.Class02EditField.Value;
            class(3) = app.Class03EditField.Value;
            class(4) = app.Class04EditField.Value;
            class(5) = app.Class05EditField.Value;
            class(6) = app.Class06EditField.Value;

            couleur_n(1) = string(app.ColorDropDown.Value);
            couleur_n(2) = app.ColorDropDown_2.Value;
            couleur_n(3) = app.ColorDropDown_3.Value;
            couleur_n(4) = app.ColorDropDown_4.Value;
            couleur_n(5) = app.ColorDropDown_5.Value;
            couleur_n(6) = app.ColorDropDown_6.Value;

            for i = 1 : length(couleur_n)
                if couleur_n(i) == "Red"
                    color(i,:) = [0.9 0 0];
                elseif couleur_n(i) == "Green"
                    color(i,:) = [0 0.8 0];
                elseif couleur_n(i) == "Blue"
                    color(i,:) = [0 0 1];
                elseif couleur_n(i) == "Orange"
                    color(i,:) = [1 0.5 0];
                elseif couleur_n(i) == "Yellow"
                    color(i,:) = [0.9 0.9 0];
                elseif couleur_n(i) == "Violet"
                    color(i,:) = [0.9 0 0.9];
                elseif couleur_n(i) == "None"
                    color(i,:) = [0 0 0];
                end
            end

            if isfield(carte,'time')
                time_flag = 1;
                carte_time = carte.time;
            else
                time_flag = 0;
                carte_time = 0;
            end

            limits = [885 886]; % totalement arbitraire, ces valeurs ne sont pas utiles pour la suite

            [ bio_ind, bio_num, bio_map , fusion_tab] = mzXML_on_map_norm16(pixels_scans,carte.z,limits,carte_time,time_flag);

            si = size(carte.z);
            bio_map_class = zeros(si(1),si(2),3);

            back_color = app.BackgroundColorDropDown.Value;
            if back_color == "White"
                bio_map_class(:,:,:) = 1;
            elseif back_color == "Grey"
                bio_map_class(:,:,:) = 0.5;
            end

            bio_map_class = bio_class_builder3(scan,bio_num,class,color,fusion_tab,bio_ind,bio_map_class);

            [ carte.x,carte.y,carte.z,bio_map_class  ] = fix_border_3(carte.x,carte.y,carte.z,bio_map_class,bio_ind);

            fprintf('(%s) - Done, displaying the image\n', datestr(now,'HH:MM:SS'));
            figure()
            s = surf(carte.x,carte.y,carte.z,bio_map_class);
            s.FaceAlpha = 0.9; % niveau de transparence
            s.FaceColor = 'flat'; % set color interpolation or not
            s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
            axis equal
            title(['Biometric Class Map']);
            legend(class);


        end

        % Button pushed function: LoadmzXMLButton
        function LoadmzXMLButtonPushed(app, event)

            disp("Loading of mzXML file in progress...")

            global mzXML

            mzxml_r = app.mzXMLfilenameEditField.Value;
            nom_mzxml = strcat(mzxml_r,'.mzXML');
            mzXML.contents = mzxmlread(nom_mzxml);

            mzXML.is_loaded = 1;

            disp("Loading of mzXML file finished !")

        end

        % Button pushed function: LaunchExtractionButton
        function LaunchExtractionButtonPushed(app, event)

            nom_mat_r = app.InputMatfilenameEditField_scils.Value;
            nom_mat = strcat(nom_mat_r,'.mat');
            load(nom_mat);

            nom_txt_r = app.OutputnameofthecreatedtxtfileEditField.Value;
            nom_txt = strcat(nom_txt_r,'.txt');

            folder_name = 'txt files';

            nom  = choix_chemin(folder_name,nom_txt)

            fid = fopen(nom,'wt');
            fprintf(fid, 'mzML=true\n');
            fprintf(fid, 'zlib=false\n');
            fprintf(fid, 'filter="scanNumber');

            l = length(pixels_scans);

            for i = 1 : l
                num = abs(pixels_scans(i).num);
                fprintf(fid,' [%d,%d]',num,num);
            end
            fprintf(fid,'"');

            fclose(fid);

        end

        % Value changed function: InputMatfilenameEditField_scils
        function InputMatfilenameEditField_scilsValueChanged(app, event)
            value = app.InputMatfilenameEditField_scils.Value;
            app.OutputnameofthecreatedtxtfileEditField.Value = value;
        end

        % Button pushed function: ExportrawBioMapButton
        function ExportrawBioMapButtonPushed(app, event)
            pyrunfile('3-PLY-Converter.py')
        end

        % Callback function
        function ExportinterpolatedBioMaptoplyfileButtonPushed(app, event)
            pyrunfile('3-PLY-Converter.py')
        end

        % Button pushed function: ExportandcoregisterBiomapButton
        function ExportandcoregisterBiomapButtonPushed(app, event)
            pyrunfile('1-Biomap_to_PNG.py')
            pyrunfile('2-Picture_Manual_Registration.py')
            pyrunfile('3-PLY-Converter.py')
        end

        % Callback function
        function ExportBioMaptoPNGButtonPushed(app, event)
            pyrunfile('1-Biomap_to_PNG.py')
        end

        % Value changed function: NameofthemapEditField
        function NameofthemapEditFieldValueChanged(app, event)
            value = app.NameofthemapEditField.Value;
            app.NameofthecorrectedmapEditField.Value = strcat(value,"_corrected");
        end

        % Callback function
        function MinEditField_2ValueChanged(app, event)

        end

        % Value changed function: MaxEditField
        function MaxEditFieldValueChanged(app, event)
            app.valmax = app.MaxEditField.Value;

        end

        % Value changed function: MinEditField
        function MinEditFieldValueChanged(app, event)
            app.valmin = app.MinEditField.Value;

        end

        % Callback function
        function DataImportationButtonPushed(app, event)

            global imzML;
            %clear imzML

            % Set the path to the imzMLConverter.jar file
            javaclasspath('code/code_java/imzMLConverter.jar');

            % Select imzML file
            [filename, path] = uigetfile('*.imzML');
            imzml_file = fullfile(path, filename);

            % Parse imzML file
            data = imzMLConverter.ImzMLHandler.parseimzML(imzml_file);

            % Get dimensions of data set
            nColumns = data.getWidth();
            nRows = data.getHeight();

            % Localize pixels containing data
            mask_ini = false(nColumns, nRows);
            for i = 1:nColumns
                for j = 1:nRows
                    mask_ini(i,j) = ~isempty(data.getSpectrum(i,j));
                end
            end

            % Get mz values

            spectrum = data.getSpectrum(1,1);
            class(spectrum)  % display the class of the spectrum variable
            %mzs = spectrum.getmzArray().getDoubleArray();  % square brackets instead of dot indexing
            mzs = spectrum.getmzArray();


            % Initialize data cube
            data_cube = zeros(nColumns, nRows, numel(mzs));

            % Populate data cube
            for i = 1:nColumns
                for j = 1:nRows
                    if mask_ini(i, j)
                        spectrum = data.getSpectrum(i, j);
                        data_cube(i, j, :) = spectrum.getIntensityArray();
                    end
                end
            end

            imzML.data_cube = data_cube;
            imzML.mzs = mzs;
            imzML.mask_ini = mask_ini;
            imzML.nColumns = nColumns;
            imzML.nRows = nRows;

            disp("Importation des donnes imzML OK")
        end

        % Callback function
        function DisplaySumofIntensitiesButtonPushed(app, event)
            global imzML;

            % Check if data cube exists
            if isempty(imzML.data_cube)
                disp('Error: Data cube is empty or not defined.');
                return;
            end

            % Compute sum of intensities across spectral channels
            tot = sum(imzML.data_cube, 3);

            % Display image
            imagesc(tot');colormap('jet');colorbar;axis image;

            % Create mask
            mask_corner = find(tot == 0);
            mask_corner = setdiff(1:(imzML.nColumns * imzML.nRows), mask_corner);
            imzML.mask_corner = mask_corner;
        end

        % Callback function
        function DataReductionButtonPushed(app, event)

            global imzML
            %% unfolded datacube
            all_spectra=reshape(imzML.data_cube,imzML.nColumns*imzML.nRows,numel(imzML.mzs));
            selected_spectra=all_spectra(imzML.mask_corner,:);
            %% Reduction
            [U,S,V]=svds(selected_spectra,5);

            imzML.selected_spectra = selected_spectra;
            imzML.U = U;
            disp("Reduction OK")
        end

        % Callback function
        function SegmentationButtonPushed(app, event)
            global imzML
            nb_cluster = app.ClusternumberEditField.Value;
            pool = parpool;                      % Invokes workers
            stream = RandStream('mlfg6331_64');  % Random number stream
            options = statset('UseParallel',1,'UseSubstreams',1,'Streams',stream);
            distance='cosine';

            for num_clusters = 2:nb_cluster
                [idx, C] = kmeans(imzML.U,num_clusters,'Replicates',10,'OnlinePhase','on','Display','final','MaxIter',200,'Distance',distance,'Options',options);
                varname = sprintf('idx_%d', num_clusters); % generates 'idx_2', 'idx_3', etc.
                imzML.(varname) = idx; % stores the result in 'imzML.idx_2', 'imzML.idx_3', etc.
                eval(sprintf('C_%d = C;', num_clusters));
            end
        end

        % Callback function
        function DisplayclusterButtonPushed(app, event)

            global imzML
            value = app.ClusterindexEditField.Value;

            % Check if idx variable exists
            varname = sprintf('idx_%d', value); % generates 'idx_4', etc.
            if ~isfield(imzML, varname)
                errordlg(sprintf('Cluster %d not found',value), 'Error');
                return;
            end

            % display clusters
            cluster = value;
            imzML.idx = imzML.(varname); % evaluates 'imzML.idx_4' and stores the result in 'imzML.idx'
            generate_cluster_map(imzML.nColumns, imzML.nRows, imzML.mask_corner,imzML.idx, cluster)
        end

        % Callback function
        function STOPCONTINUOUSLASERButtonValueChanged(app, event)
%             value = app.STOPCONTINUOUSLASERButton.Value; % CE BOUTON A
%             ETE SUPPRIME !
%             global laser;
% 
%             laser.class.tir_continu_OFF(laser.connexion);
        end

        % Callback function
        function ContinuousprocessingButtonValueChanged(app, event)
%% Code encore utilis2 ?
disp("FONCTION COMMENTE => REPRENDRE DANS MLAPP (Continuous Processing)")
%             global mzXML;
% 
%             path(path,'to add')
%             path(path,'mzXML files')
%             path(path,'code/code_for_preprocessing')
%             path(path,'code/code_for_recording')
% 
% %             threshold_begin = app.BeginThresholdEditField.Value;
% %             t_b = app.Timebetween2lasershotsecondEditField.Value;
% %             min_threshold = app.LoudthresholdEditField.Value;
% %             tolerance = app.FusionpercentSlider.Value;
% 
%             intern_trig = app.InternalTriggeringSwitch.Value;
% 
%             nom_map_r = app.MapfilenameEditField_2.Value;
%             nom_map = strcat(nom_map_r,'.map');
%             %out = load(nom_map); % load topographical map. Remove any dot in the file name
%             carte = load_map4_fcn(nom_map);
% 
%             if isfield(carte,'time')
%                 carte_time = carte.time;
%             else
%                 carte_time = 0;
%             end
% 
%             fprintf('(%s) - Filtering the mzXML file to keep only the image related spectra\n', datestr(now,'HH:MM:SS'));
% 
%             if intern_trig(1:2) == 'On'
%                 intern_flag = 1;
%             else
%                 intern_flag = 0;
%             end
% 
%             [pixels_scans ,time,g] = continuous_detection(mzXML.Struct,carte_time); % take only the usefull informations
% 
%             mzXML.pixels_scans = pixels_scans;
%             % bio.time = time;
%             % bio.g = g;
% 
%             time_str = num2str(time);
%             time_str2 = strcat(time_str, ' seconds');
%             app.TimeValue.Text = time_str2;
% 
%             disp(length(pixels_scans));
        end

        % Button pushed function: STOPCONTINUOUSLASERButton_2
        function STOPCONTINUOUSLASERButton_2Pushed(app, event)
            global laser;

            laser.class.tir_continu_OFF(laser.connexion);
        end

        % Button pushed function: ScanSelectionButton
        function ScanSelectionButtonPushed(app, event)

            global mzXML;

            nom_map_r = app.MapfilenameEditField_2.Value;
            nom_map = strcat(nom_map_r,'.map');
            %out = load(nom_map); % load topographical map. Remove any dot in the file name
            carte = load_map_fcn(nom_map);

            if isfield(carte,'time')
                carte_time = carte.time;
            else
                carte_time = 0;
            end

            fprintf('(%s) - Filtering the mzXML file to keep only the image related spectra\n', datestr(now,'HH:MM:SS'));

            method.type = app.ScanSelectionMethodDropDown.Value;
            method.class = eval(method.type);
            method.class.init(app)
            
            if isfield(mzXML,'contents')
                [pixels_scans ,time] =  method.class.selection(mzXML.contents,carte_time); % take only the usefull informations
            else 
                message_error="Attention : no mzXML file loaded = Impossible to do scan selection"
                disp(message_error)
                msgbox(message_error)
            end

            mzXML.pixels_scans = pixels_scans;

        end

        % Button pushed function: ExporttoCSVButton
        function ExporttoCSVButtonPushed(app, event)

            mz_min = app.MinMzEditField.Value
            mz_max = app.MaxMzEditField.Value
            band = [mz_min, mz_max]

            win = app.BinningEditField.Value
            map = strcat(app.InputmapfileEditField.Value, '.map')

            mat = strcat(app.InputmatfileEditField.Value, '.mat')
            
            csv_extractor(map, mat, band, win)
        end

        % Button pushed function: NormalizeCSVTICButton
        function NormalizeCSVTICButtonPushed(app, event)
            pyrunfile('CSV_TIC_norm.py')
        end

        % Button pushed function: ExportrawCSVButton
        function ExportrawCSVButtonPushed(app, event)
            pyrunfile('CSV_to_PLY.py')
        end

        % Button pushed function: ExportandcoregisterCSVButton
        function ExportandcoregisterCSVButtonPushed(app, event)
            pyrunfile('CSV_to_PNG.py')
            pyrunfile('2-Picture_Manual_Registration.py')
            pyrunfile('CSV_to_PLY.py')
        end

        % Button pushed function: ConnectSensorButton
        function ConnectSensorButtonPushed(app, event)
            disp("Sensor Connexion... ")
            
            % app.StateLampRobot.Color = [0 0 1];
            global sensor; % ou fermeture de la connexion

            sensor.type = app.SensorDropDown.Value;

            sensor.class = eval(sensor.type);

            sensor.connexion = sensor.class.connect();

            disp("Sensor Connected ")
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 598 883];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.CloseRequestFcn = createCallbackFcn(app, @UIFigureCloseRequest, true);

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [-2 0 603 884];

            % Create AcquisitionTab
            app.AcquisitionTab = uitab(app.TabGroup);
            app.AcquisitionTab.Title = 'Acquisition';

            % Create LaunchMappingButton
            app.LaunchMappingButton = uibutton(app.AcquisitionTab, 'push');
            app.LaunchMappingButton.ButtonPushedFcn = createCallbackFcn(app, @LaunchMappingButtonPushed, true);
            app.LaunchMappingButton.Interruptible = 'off';
            app.LaunchMappingButton.FontWeight = 'bold';
            app.LaunchMappingButton.Position = [221 34 163 22];
            app.LaunchMappingButton.Text = 'Launch Mapping';

            % Create MappingChoiceButtonGroup
            app.MappingChoiceButtonGroup = uibuttongroup(app.AcquisitionTab);
            app.MappingChoiceButtonGroup.Title = 'Mapping Choice';
            app.MappingChoiceButtonGroup.Position = [214 65 228 95];

            % Create OnlyTopographicButton
            app.OnlyTopographicButton = uiradiobutton(app.MappingChoiceButtonGroup);
            app.OnlyTopographicButton.Text = 'Only Topographic';
            app.OnlyTopographicButton.Position = [11 49 115 22];

            % Create WithMassSpectometryButton
            app.WithMassSpectometryButton = uiradiobutton(app.MappingChoiceButtonGroup);
            app.WithMassSpectometryButton.Text = 'With Mass Spectometry';
            app.WithMassSpectometryButton.Position = [11 27 149 22];
            app.WithMassSpectometryButton.Value = true;

            % Create LampOnlyTopo
            app.LampOnlyTopo = uilamp(app.MappingChoiceButtonGroup);
            app.LampOnlyTopo.Position = [191 51 20 20];
            app.LampOnlyTopo.Color = [1 0 0];

            % Create LampWithSpectro
            app.LampWithSpectro = uilamp(app.MappingChoiceButtonGroup);
            app.LampWithSpectro.Position = [191 26 20 20];
            app.LampWithSpectro.Color = [1 0 0];

            % Create DMassSpectometryButton
            app.DMassSpectometryButton = uiradiobutton(app.MappingChoiceButtonGroup);
            app.DMassSpectometryButton.Text = '2D Mass Spectometry';
            app.DMassSpectometryButton.Position = [10 6 140 22];

            % Create LampWithSpectro_2D
            app.LampWithSpectro_2D = uilamp(app.MappingChoiceButtonGroup);
            app.LampWithSpectro_2D.Position = [192 1 20 20];
            app.LampWithSpectro_2D.Color = [1 0 0];

            % Create RobotConnexionB
            app.RobotConnexionB = uibutton(app.AcquisitionTab, 'push');
            app.RobotConnexionB.ButtonPushedFcn = createCallbackFcn(app, @RobotConnexionBButtonPushed, true);
            app.RobotConnexionB.FontWeight = 'bold';
            app.RobotConnexionB.Position = [129 599 101 22];
            app.RobotConnexionB.Text = 'Connect Robot';

            % Create StateLampRobot
            app.StateLampRobot = uilamp(app.AcquisitionTab);
            app.StateLampRobot.Position = [286 600 20 20];
            app.StateLampRobot.Color = [1 0 0];

            % Create ConnectLaserButton
            app.ConnectLaserButton = uibutton(app.AcquisitionTab, 'push');
            app.ConnectLaserButton.ButtonPushedFcn = createCallbackFcn(app, @ConnectLaserButtonPushed, true);
            app.ConnectLaserButton.FontWeight = 'bold';
            app.ConnectLaserButton.Position = [296 437 100 22];
            app.ConnectLaserButton.Text = 'Connect Laser';

            % Create StateLampOpotek
            app.StateLampOpotek = uilamp(app.AcquisitionTab);
            app.StateLampOpotek.Position = [422 438 20 20];
            app.StateLampOpotek.Color = [1 0 0];

            % Create LaunchSensorCalibrationButton
            app.LaunchSensorCalibrationButton = uibutton(app.AcquisitionTab, 'push');
            app.LaunchSensorCalibrationButton.ButtonPushedFcn = createCallbackFcn(app, @LaunchSensorCalibrationButtonPushed, true);
            app.LaunchSensorCalibrationButton.Interruptible = 'off';
            app.LaunchSensorCalibrationButton.FontWeight = 'bold';
            app.LaunchSensorCalibrationButton.Position = [413 515 168 22];
            app.LaunchSensorCalibrationButton.Text = 'Launch Sensor Calibration';

            % Create LaunchBurstButton
            app.LaunchBurstButton = uibutton(app.AcquisitionTab, 'push');
            app.LaunchBurstButton.ButtonPushedFcn = createCallbackFcn(app, @LaunchBurstButtonPushed, true);
            app.LaunchBurstButton.Interruptible = 'off';
            app.LaunchBurstButton.FontWeight = 'bold';
            app.LaunchBurstButton.Position = [423 250 100 22];
            app.LaunchBurstButton.Text = 'Launch Burst ';

            % Create GotoPositionButton
            app.GotoPositionButton = uibutton(app.AcquisitionTab, 'push');
            app.GotoPositionButton.ButtonPushedFcn = createCallbackFcn(app, @GotoPositionButtonPushed, true);
            app.GotoPositionButton.Interruptible = 'off';
            app.GotoPositionButton.FontWeight = 'bold';
            app.GotoPositionButton.Position = [416 210 100 22];
            app.GotoPositionButton.Text = 'Go to Position';

            % Create TurnLampOnButton
            app.TurnLampOnButton = uibutton(app.AcquisitionTab, 'push');
            app.TurnLampOnButton.ButtonPushedFcn = createCallbackFcn(app, @TurnLampOnButtonPushed, true);
            app.TurnLampOnButton.Interruptible = 'off';
            app.TurnLampOnButton.FontWeight = 'bold';
            app.TurnLampOnButton.Position = [301 370 100 22];
            app.TurnLampOnButton.Text = 'Turn Lamp On ';

            % Create TurnLampOffButton
            app.TurnLampOffButton = uibutton(app.AcquisitionTab, 'push');
            app.TurnLampOffButton.ButtonPushedFcn = createCallbackFcn(app, @TurnLampOffButtonPushed, true);
            app.TurnLampOffButton.Interruptible = 'off';
            app.TurnLampOffButton.FontWeight = 'bold';
            app.TurnLampOffButton.Position = [465 370 100 22];
            app.TurnLampOffButton.Text = 'Turn Lamp Off';

            % Create Lamp_LampONorOFF
            app.Lamp_LampONorOFF = uilamp(app.AcquisitionTab);
            app.Lamp_LampONorOFF.Position = [420 371 20 20];
            app.Lamp_LampONorOFF.Color = [1 0 0];

            % Create AffichageTemperature
            app.AffichageTemperature = uilabel(app.AcquisitionTab);
            app.AffichageTemperature.Position = [421 402 138 22];
            app.AffichageTemperature.Text = 'Temperature : NO_DATA';

            % Create DisconnectRobotButton
            app.DisconnectRobotButton = uibutton(app.AcquisitionTab, 'push');
            app.DisconnectRobotButton.ButtonPushedFcn = createCallbackFcn(app, @DisconnectRobotButtonPushed, true);
            app.DisconnectRobotButton.Interruptible = 'off';
            app.DisconnectRobotButton.FontWeight = 'bold';
            app.DisconnectRobotButton.Position = [347 599 118 22];
            app.DisconnectRobotButton.Text = 'Disconnect Robot';

            % Create AffichageState
            app.AffichageState = uilabel(app.AcquisitionTab);
            app.AffichageState.Position = [131 336 462 31];
            app.AffichageState.Text = 'State : NO_DATA';

            % Create DisconnectButton
            app.DisconnectButton = uibutton(app.AcquisitionTab, 'push');
            app.DisconnectButton.ButtonPushedFcn = createCallbackFcn(app, @DisconnectButtonPushed, true);
            app.DisconnectButton.Interruptible = 'off';
            app.DisconnectButton.FontWeight = 'bold';
            app.DisconnectButton.Position = [475 437 100 22];
            app.DisconnectButton.Text = 'Disconnect ';

            % Create GetTempButton
            app.GetTempButton = uibutton(app.AcquisitionTab, 'push');
            app.GetTempButton.ButtonPushedFcn = createCallbackFcn(app, @GetTempButtonPushed, true);
            app.GetTempButton.Interruptible = 'off';
            app.GetTempButton.FontWeight = 'bold';
            app.GetTempButton.Position = [316 402 100 22];
            app.GetTempButton.Text = 'Get Temp';

            % Create GOTOButton
            app.GOTOButton = uibutton(app.AcquisitionTab, 'push');
            app.GOTOButton.ButtonPushedFcn = createCallbackFcn(app, @GOTOButtonPushed, true);
            app.GOTOButton.Interruptible = 'off';
            app.GOTOButton.FontWeight = 'bold';
            app.GOTOButton.Position = [468 566 100 22];
            app.GOTOButton.Text = 'GO TO';

            % Create GetStateButton
            app.GetStateButton = uibutton(app.AcquisitionTab, 'push');
            app.GetStateButton.ButtonPushedFcn = createCallbackFcn(app, @GetStateButtonPushed, true);
            app.GetStateButton.Interruptible = 'off';
            app.GetStateButton.FontWeight = 'bold';
            app.GetStateButton.Position = [18 340 100 22];
            app.GetStateButton.Text = 'Get State';

            % Create LampVoltageSet
            app.LampVoltageSet = uilamp(app.AcquisitionTab);
            app.LampVoltageSet.Position = [369 310 20 20];

            % Create ClearMapButton
            app.ClearMapButton = uibutton(app.AcquisitionTab, 'push');
            app.ClearMapButton.ButtonPushedFcn = createCallbackFcn(app, @ClearMapButtonPushed, true);
            app.ClearMapButton.FontWeight = 'bold';
            app.ClearMapButton.Position = [464 32 100 22];
            app.ClearMapButton.Text = 'Clear Map';

            % Create ButtonGroupMappingSpeed
            app.ButtonGroupMappingSpeed = uibuttongroup(app.AcquisitionTab);
            app.ButtonGroupMappingSpeed.SelectionChangedFcn = createCallbackFcn(app, @ButtonGroupMappingSpeedSelectionChanged, true);
            app.ButtonGroupMappingSpeed.Position = [59 96 134 53];

            % Create WithrepositioningButton
            app.WithrepositioningButton = uiradiobutton(app.ButtonGroupMappingSpeed);
            app.WithrepositioningButton.Text = 'With repositioning';
            app.WithrepositioningButton.Position = [11 26 117 22];
            app.WithrepositioningButton.Value = true;

            % Create FastMappingButton
            app.FastMappingButton = uiradiobutton(app.ButtonGroupMappingSpeed);
            app.FastMappingButton.Text = 'Fast Mapping';
            app.FastMappingButton.Position = [11 4 95 22];

            % Create MapNameEditFieldLabel
            app.MapNameEditFieldLabel = uilabel(app.AcquisitionTab);
            app.MapNameEditFieldLabel.HorizontalAlignment = 'right';
            app.MapNameEditFieldLabel.FontWeight = 'bold';
            app.MapNameEditFieldLabel.Position = [200 827 66 22];
            app.MapNameEditFieldLabel.Text = 'Map Name';

            % Create MapNameEditField
            app.MapNameEditField = uieditfield(app.AcquisitionTab, 'text');
            app.MapNameEditField.FontWeight = 'bold';
            app.MapNameEditField.Position = [281 827 100 22];

            % Create MappingStepmmEditFieldLabel
            app.MappingStepmmEditFieldLabel = uilabel(app.AcquisitionTab);
            app.MappingStepmmEditFieldLabel.HorizontalAlignment = 'right';
            app.MappingStepmmEditFieldLabel.Position = [46 800 114 22];
            app.MappingStepmmEditFieldLabel.Text = 'Mapping Step  (mm)';

            % Create MappingStepmmEditField
            app.MappingStepmmEditField = uieditfield(app.AcquisitionTab, 'numeric');
            app.MappingStepmmEditField.ValueChangedFcn = createCallbackFcn(app, @MappingStepmmEditFieldValueChanged, true);
            app.MappingStepmmEditField.Position = [175 800 100 22];
            app.MappingStepmmEditField.Value = 0.5;

            % Create MaximumheightmmofthesampleEditFieldLabel
            app.MaximumheightmmofthesampleEditFieldLabel = uilabel(app.AcquisitionTab);
            app.MaximumheightmmofthesampleEditFieldLabel.HorizontalAlignment = 'right';
            app.MaximumheightmmofthesampleEditFieldLabel.Position = [138 717 205 22];
            app.MaximumheightmmofthesampleEditFieldLabel.Text = 'Maximum height (mm)  of the sample';

            % Create MaximumheightmmofthesampleEditField
            app.MaximumheightmmofthesampleEditField = uieditfield(app.AcquisitionTab, 'numeric');
            app.MaximumheightmmofthesampleEditField.Position = [356 717 100 22];
            app.MaximumheightmmofthesampleEditField.Value = 10;

            % Create ZonesizeXaxismmEditFieldLabel
            app.ZonesizeXaxismmEditFieldLabel = uilabel(app.AcquisitionTab);
            app.ZonesizeXaxismmEditFieldLabel.HorizontalAlignment = 'right';
            app.ZonesizeXaxismmEditFieldLabel.Position = [304 799 125 22];
            app.ZonesizeXaxismmEditFieldLabel.Text = 'Zone size X axis (mm)';

            % Create ZonesizeXaxismmEditField
            app.ZonesizeXaxismmEditField = uieditfield(app.AcquisitionTab, 'numeric');
            app.ZonesizeXaxismmEditField.ValueChangedFcn = createCallbackFcn(app, @ZonesizeXaxismmEditFieldValueChanged, true);
            app.ZonesizeXaxismmEditField.Position = [444 799 100 22];
            app.ZonesizeXaxismmEditField.Value = 16;

            % Create ZonesizeYaxismmEditFieldLabel
            app.ZonesizeYaxismmEditFieldLabel = uilabel(app.AcquisitionTab);
            app.ZonesizeYaxismmEditFieldLabel.HorizontalAlignment = 'right';
            app.ZonesizeYaxismmEditFieldLabel.Position = [304 773 125 22];
            app.ZonesizeYaxismmEditFieldLabel.Text = 'Zone size Y axis (mm)';

            % Create ZonesizeYaxismmEditField
            app.ZonesizeYaxismmEditField = uieditfield(app.AcquisitionTab, 'numeric');
            app.ZonesizeYaxismmEditField.ValueChangedFcn = createCallbackFcn(app, @ZonesizeYaxismmEditFieldValueChanged, true);
            app.ZonesizeYaxismmEditField.Position = [444 773 100 22];
            app.ZonesizeYaxismmEditField.Value = 16;

            % Create SurfaceoffestmmEditFieldLabel
            app.SurfaceoffestmmEditFieldLabel = uilabel(app.AcquisitionTab);
            app.SurfaceoffestmmEditFieldLabel.HorizontalAlignment = 'right';
            app.SurfaceoffestmmEditFieldLabel.Position = [49 772 111 22];
            app.SurfaceoffestmmEditFieldLabel.Text = 'Surface offest (mm)';

            % Create SurfaceoffestmmEditField
            app.SurfaceoffestmmEditField = uieditfield(app.AcquisitionTab, 'numeric');
            app.SurfaceoffestmmEditField.Position = [175 772 100 22];

            % Create MicroprobefocaldistanceinZaxismmEditFieldLabel
            app.MicroprobefocaldistanceinZaxismmEditFieldLabel = uilabel(app.AcquisitionTab);
            app.MicroprobefocaldistanceinZaxismmEditFieldLabel.HorizontalAlignment = 'right';
            app.MicroprobefocaldistanceinZaxismmEditFieldLabel.Position = [109 210 227 22];
            app.MicroprobefocaldistanceinZaxismmEditFieldLabel.Text = 'Microprobe focal distance in Z axis (mm) ';

            % Create MicroprobefocaldistanceinZaxismmEditField
            app.MicroprobefocaldistanceinZaxismmEditField = uieditfield(app.AcquisitionTab, 'numeric');
            app.MicroprobefocaldistanceinZaxismmEditField.Position = [360 210 43 22];
            app.MicroprobefocaldistanceinZaxismmEditField.Value = 80;

            % Create TimebetweentwolasershotsecondEditFieldLabel
            app.TimebetweentwolasershotsecondEditFieldLabel = uilabel(app.AcquisitionTab);
            app.TimebetweentwolasershotsecondEditFieldLabel.HorizontalAlignment = 'right';
            app.TimebetweentwolasershotsecondEditFieldLabel.Position = [78 279 209 22];
            app.TimebetweentwolasershotsecondEditFieldLabel.Text = 'Time between two laser shot (second)';

            % Create TimebetweentwolasershotsecondEditField
            app.TimebetweentwolasershotsecondEditField = uieditfield(app.AcquisitionTab, 'numeric');
            app.TimebetweentwolasershotsecondEditField.ValueChangedFcn = createCallbackFcn(app, @TimebetweentwolasershotsecondEditFieldValueChanged, true);
            app.TimebetweentwolasershotsecondEditField.Position = [302 279 100 22];
            app.TimebetweentwolasershotsecondEditField.Value = 3;

            % Create NumberoflasershotburstmodeEditFieldLabel
            app.NumberoflasershotburstmodeEditFieldLabel = uilabel(app.AcquisitionTab);
            app.NumberoflasershotburstmodeEditFieldLabel.HorizontalAlignment = 'right';
            app.NumberoflasershotburstmodeEditFieldLabel.Position = [96 250 188 22];
            app.NumberoflasershotburstmodeEditFieldLabel.Text = 'Number of laser shot (burst mode)';

            % Create NumberoflasershotburstmodeEditField
            app.NumberoflasershotburstmodeEditField = uieditfield(app.AcquisitionTab, 'numeric');
            app.NumberoflasershotburstmodeEditField.ValueChangedFcn = createCallbackFcn(app, @NumberoflasershotburstmodeEditFieldValueChanged, true);
            app.NumberoflasershotburstmodeEditField.Position = [299 250 100 22];
            app.NumberoflasershotburstmodeEditField.Value = 3;

            % Create EnergylevelVSpinnerLabel
            app.EnergylevelVSpinnerLabel = uilabel(app.AcquisitionTab);
            app.EnergylevelVSpinnerLabel.HorizontalAlignment = 'right';
            app.EnergylevelVSpinnerLabel.Position = [160 310 91 22];
            app.EnergylevelVSpinnerLabel.Text = 'Energy level (V)';

            % Create EnergylevelVSpinner
            app.EnergylevelVSpinner = uispinner(app.AcquisitionTab);
            app.EnergylevelVSpinner.ValueChangedFcn = createCallbackFcn(app, @EnergylevelVSpinnerValueChanged, true);
            app.EnergylevelVSpinner.Position = [266 310 100 22];
            app.EnergylevelVSpinner.Value = 682;

            % Create FisrtmappingpointXpositionmmEditFieldLabel
            app.FisrtmappingpointXpositionmmEditFieldLabel = uilabel(app.AcquisitionTab);
            app.FisrtmappingpointXpositionmmEditFieldLabel.HorizontalAlignment = 'right';
            app.FisrtmappingpointXpositionmmEditFieldLabel.Position = [145 692 196 22];
            app.FisrtmappingpointXpositionmmEditFieldLabel.Text = 'Fisrt mapping point X position (mm)';

            % Create FisrtmappingpointXpositionmmEditField
            app.FisrtmappingpointXpositionmmEditField = uieditfield(app.AcquisitionTab, 'numeric');
            app.FisrtmappingpointXpositionmmEditField.Position = [356 692 100 22];
            app.FisrtmappingpointXpositionmmEditField.Value = 150;

            % Create CalibrationstateLabel
            app.CalibrationstateLabel = uilabel(app.AcquisitionTab);
            app.CalibrationstateLabel.HorizontalAlignment = 'right';
            app.CalibrationstateLabel.Position = [407 481 140 22];
            app.CalibrationstateLabel.Text = 'Sensor Calibration state :';

            % Create SensorCalibrationstateLamp
            app.SensorCalibrationstateLamp = uilamp(app.AcquisitionTab);
            app.SensorCalibrationstateLamp.Position = [562 483 20 20];
            app.SensorCalibrationstateLamp.Color = [1 0 0];

            % Create XPositionEditFieldLabel
            app.XPositionEditFieldLabel = uilabel(app.AcquisitionTab);
            app.XPositionEditFieldLabel.HorizontalAlignment = 'right';
            app.XPositionEditFieldLabel.Position = [36 566 60 22];
            app.XPositionEditFieldLabel.Text = 'X Position';

            % Create XPositionEditField
            app.XPositionEditField = uieditfield(app.AcquisitionTab, 'numeric');
            app.XPositionEditField.Position = [111 566 47 22];
            app.XPositionEditField.Value = 150;

            % Create YPositionEditFieldLabel
            app.YPositionEditFieldLabel = uilabel(app.AcquisitionTab);
            app.YPositionEditFieldLabel.HorizontalAlignment = 'right';
            app.YPositionEditFieldLabel.Position = [169 566 60 22];
            app.YPositionEditFieldLabel.Text = 'Y Position';

            % Create YPositionEditField
            app.YPositionEditField = uieditfield(app.AcquisitionTab, 'numeric');
            app.YPositionEditField.Position = [244 566 51 22];
            app.YPositionEditField.Value = 2;

            % Create ZPositionEditFieldLabel
            app.ZPositionEditFieldLabel = uilabel(app.AcquisitionTab);
            app.ZPositionEditFieldLabel.HorizontalAlignment = 'right';
            app.ZPositionEditFieldLabel.Position = [314 566 59 22];
            app.ZPositionEditFieldLabel.Text = 'Z Position';

            % Create ZPositionEditField
            app.ZPositionEditField = uieditfield(app.AcquisitionTab, 'numeric');
            app.ZPositionEditField.Position = [388 566 58 22];
            app.ZPositionEditField.Value = 100;

            % Create mapLabel
            app.mapLabel = uilabel(app.AcquisitionTab);
            app.mapLabel.FontWeight = 'bold';
            app.mapLabel.Position = [386 827 34 22];
            app.mapLabel.Text = '.map';

            % Create NoMappingLabel
            app.NoMappingLabel = uilabel(app.AcquisitionTab);
            app.NoMappingLabel.Position = [11 34 199 22];
            app.NoMappingLabel.Text = 'No Mapping';

            % Create EstimationofmappingtimeLabel
            app.EstimationofmappingtimeLabel = uilabel(app.AcquisitionTab);
            app.EstimationofmappingtimeLabel.Position = [138 743 319 22];
            app.EstimationofmappingtimeLabel.Text = 'Estimation of mapping time : ';

            % Create LaserDropDownLabel
            app.LaserDropDownLabel = uilabel(app.AcquisitionTab);
            app.LaserDropDownLabel.HorizontalAlignment = 'right';
            app.LaserDropDownLabel.Position = [69 437 36 22];
            app.LaserDropDownLabel.Text = 'Laser';

            % Create LaserDropDown
            app.LaserDropDown = uidropdown(app.AcquisitionTab);
            app.LaserDropDown.Items = {'Opotek IR Radiant', 'Opolette'};
            app.LaserDropDown.Position = [120 437 146 22];
            app.LaserDropDown.Value = 'Opotek IR Radiant';

            % Create ContinuousLaserCheckBox
            app.ContinuousLaserCheckBox = uicheckbox(app.AcquisitionTab);
            app.ContinuousLaserCheckBox.Text = 'Continuous Laser';
            app.ContinuousLaserCheckBox.Position = [27 405 116 22];

            % Create STOPCONTINUOUSLASERButton_2
            app.STOPCONTINUOUSLASERButton_2 = uibutton(app.AcquisitionTab, 'push');
            app.STOPCONTINUOUSLASERButton_2.ButtonPushedFcn = createCallbackFcn(app, @STOPCONTINUOUSLASERButton_2Pushed, true);
            app.STOPCONTINUOUSLASERButton_2.FontWeight = 'bold';
            app.STOPCONTINUOUSLASERButton_2.FontColor = [1 0 0];
            app.STOPCONTINUOUSLASERButton_2.Position = [14 368 131 38];
            app.STOPCONTINUOUSLASERButton_2.Text = {'STOP CONTINUOUS'; 'LASER'};

            % Create RobotDropDownLabel
            app.RobotDropDownLabel = uilabel(app.AcquisitionTab);
            app.RobotDropDownLabel.HorizontalAlignment = 'right';
            app.RobotDropDownLabel.Position = [186 632 41 22];
            app.RobotDropDownLabel.Text = 'Robot ';

            % Create RobotDropDown
            app.RobotDropDown = uidropdown(app.AcquisitionTab);
            app.RobotDropDown.Position = [242 632 231 22];

            % Create AcquisitionPropertiesLabel
            app.AcquisitionPropertiesLabel = uilabel(app.AcquisitionTab);
            app.AcquisitionPropertiesLabel.FontWeight = 'bold';
            app.AcquisitionPropertiesLabel.Position = [5 828 141 22];
            app.AcquisitionPropertiesLabel.Text = 'Acquisition Properties :';

            % Create RobotConnexionLabel
            app.RobotConnexionLabel = uilabel(app.AcquisitionTab);
            app.RobotConnexionLabel.FontWeight = 'bold';
            app.RobotConnexionLabel.Position = [5 632 113 22];
            app.RobotConnexionLabel.Text = 'Robot Connexion :';

            % Create SensorConnexionLabel
            app.SensorConnexionLabel = uilabel(app.AcquisitionTab);
            app.SensorConnexionLabel.FontWeight = 'bold';
            app.SensorConnexionLabel.Position = [5 506 119 22];
            app.SensorConnexionLabel.Text = 'Sensor Connexion :';

            % Create LaserConnexionLabel
            app.LaserConnexionLabel = uilabel(app.AcquisitionTab);
            app.LaserConnexionLabel.FontWeight = 'bold';
            app.LaserConnexionLabel.Position = [5 458 110 22];
            app.LaserConnexionLabel.Text = 'Laser Connexion :';

            % Create ImagingLabel
            app.ImagingLabel = uilabel(app.AcquisitionTab);
            app.ImagingLabel.FontWeight = 'bold';
            app.ImagingLabel.Position = [12 157 59 22];
            app.ImagingLabel.Text = 'Imaging :';

            % Create SensorDropDownLabel
            app.SensorDropDownLabel = uilabel(app.AcquisitionTab);
            app.SensorDropDownLabel.HorizontalAlignment = 'right';
            app.SensorDropDownLabel.Position = [127 508 43 22];
            app.SensorDropDownLabel.Text = 'Sensor';

            % Create SensorDropDown
            app.SensorDropDown = uidropdown(app.AcquisitionTab);
            app.SensorDropDown.Position = [185 508 211 22];

            % Create ConnectSensorButton
            app.ConnectSensorButton = uibutton(app.AcquisitionTab, 'push');
            app.ConnectSensorButton.ButtonPushedFcn = createCallbackFcn(app, @ConnectSensorButtonPushed, true);
            app.ConnectSensorButton.Interruptible = 'off';
            app.ConnectSensorButton.FontWeight = 'bold';
            app.ConnectSensorButton.Position = [204 480 168 23];
            app.ConnectSensorButton.Text = 'Connect Sensor';

            % Create ProcessingTab
            app.ProcessingTab = uitab(app.TabGroup);
            app.ProcessingTab.Title = 'Processing';

            % Create mzXMLfilenameEditFieldLabel
            app.mzXMLfilenameEditFieldLabel = uilabel(app.ProcessingTab);
            app.mzXMLfilenameEditFieldLabel.HorizontalAlignment = 'right';
            app.mzXMLfilenameEditFieldLabel.FontWeight = 'bold';
            app.mzXMLfilenameEditFieldLabel.Position = [77 804 110 22];
            app.mzXMLfilenameEditFieldLabel.Text = 'mzXML file name :';

            % Create mzXMLfilenameEditField
            app.mzXMLfilenameEditField = uieditfield(app.ProcessingTab, 'text');
            app.mzXMLfilenameEditField.Position = [202 804 239 22];
            app.mzXMLfilenameEditField.Value = '20200724_SMSI_RATBAIN_TESTNEG2';

            % Create NameofthegeneratedmatfileEditFieldLabel
            app.NameofthegeneratedmatfileEditFieldLabel = uilabel(app.ProcessingTab);
            app.NameofthegeneratedmatfileEditFieldLabel.HorizontalAlignment = 'right';
            app.NameofthegeneratedmatfileEditFieldLabel.FontWeight = 'bold';
            app.NameofthegeneratedmatfileEditFieldLabel.Position = [87 445 184 22];
            app.NameofthegeneratedmatfileEditFieldLabel.Text = 'Name of the generated mat file ';

            % Create NameofthegeneratedmatfileEditField
            app.NameofthegeneratedmatfileEditField = uieditfield(app.ProcessingTab, 'text');
            app.NameofthegeneratedmatfileEditField.Position = [286 445 138 22];

            % Create mzXMLLabel
            app.mzXMLLabel = uilabel(app.ProcessingTab);
            app.mzXMLLabel.FontWeight = 'bold';
            app.mzXMLLabel.Position = [472 804 51 22];
            app.mzXMLLabel.Text = '.mzXML';

            % Create matLabel
            app.matLabel = uilabel(app.ProcessingTab);
            app.matLabel.FontWeight = 'bold';
            app.matLabel.Position = [454 444 30 22];
            app.matLabel.Text = '.mat';

            % Create BeginThresholdEditFieldLabel
            app.BeginThresholdEditFieldLabel = uilabel(app.ProcessingTab);
            app.BeginThresholdEditFieldLabel.HorizontalAlignment = 'right';
            app.BeginThresholdEditFieldLabel.Position = [361 645 93 22];
            app.BeginThresholdEditFieldLabel.Text = 'Begin Threshold';

            % Create BeginThresholdEditField
            app.BeginThresholdEditField = uieditfield(app.ProcessingTab, 'numeric');
            app.BeginThresholdEditField.Position = [469 645 100 22];
            app.BeginThresholdEditField.Value = 10000;

            % Create BiningwindowsizeEditFieldLabel
            app.BiningwindowsizeEditFieldLabel = uilabel(app.ProcessingTab);
            app.BiningwindowsizeEditFieldLabel.HorizontalAlignment = 'right';
            app.BiningwindowsizeEditFieldLabel.Position = [198 411 107 22];
            app.BiningwindowsizeEditFieldLabel.Text = 'Bining window size';

            % Create BiningwindowsizeEditField
            app.BiningwindowsizeEditField = uieditfield(app.ProcessingTab, 'numeric');
            app.BiningwindowsizeEditField.Position = [320 411 100 22];
            app.BiningwindowsizeEditField.Value = 0.1;

            % Create LaunchPreprocessingButton
            app.LaunchPreprocessingButton = uibutton(app.ProcessingTab, 'push');
            app.LaunchPreprocessingButton.ButtonPushedFcn = createCallbackFcn(app, @LaunchPreprocessingButtonPushed, true);
            app.LaunchPreprocessingButton.FontWeight = 'bold';
            app.LaunchPreprocessingButton.Position = [241 379 145 22];
            app.LaunchPreprocessingButton.Text = 'Launch Preprocessing';

            % Create MatfilenameEditFieldLabel
            app.MatfilenameEditFieldLabel = uilabel(app.ProcessingTab);
            app.MatfilenameEditFieldLabel.HorizontalAlignment = 'right';
            app.MatfilenameEditFieldLabel.FontWeight = 'bold';
            app.MatfilenameEditFieldLabel.Position = [50 278 82 22];
            app.MatfilenameEditFieldLabel.Text = 'Mat file name';

            % Create MatfilenameEditField
            app.MatfilenameEditField = uieditfield(app.ProcessingTab, 'text');
            app.MatfilenameEditField.ValueChangedFcn = createCallbackFcn(app, @MatfilenameEditFieldValueChanged, true);
            app.MatfilenameEditField.Position = [147 278 155 22];

            % Create matLabel_2
            app.matLabel_2 = uilabel(app.ProcessingTab);
            app.matLabel_2.FontWeight = 'bold';
            app.matLabel_2.Position = [312 278 30 22];
            app.matLabel_2.Text = '.mat';

            % Create MasslimitsminimumEditFieldLabel
            app.MasslimitsminimumEditFieldLabel = uilabel(app.ProcessingTab);
            app.MasslimitsminimumEditFieldLabel.HorizontalAlignment = 'right';
            app.MasslimitsminimumEditFieldLabel.Position = [77 206 127 22];
            app.MasslimitsminimumEditFieldLabel.Text = 'Mass limits, minimum :';

            % Create MasslimitsminimumEditField
            app.MasslimitsminimumEditField = uieditfield(app.ProcessingTab, 'numeric');
            app.MasslimitsminimumEditField.ValueDisplayFormat = '%.3f';
            app.MasslimitsminimumEditField.ValueChangedFcn = createCallbackFcn(app, @MasslimitsminimumEditFieldValueChanged, true);
            app.MasslimitsminimumEditField.Position = [219 206 100 22];
            app.MasslimitsminimumEditField.Value = 600;

            % Create maximumEditFieldLabel
            app.maximumEditFieldLabel = uilabel(app.ProcessingTab);
            app.maximumEditFieldLabel.HorizontalAlignment = 'right';
            app.maximumEditFieldLabel.Position = [339 205 58 22];
            app.maximumEditFieldLabel.Text = 'maximum';

            % Create maximumEditField
            app.maximumEditField = uieditfield(app.ProcessingTab, 'numeric');
            app.maximumEditField.ValueDisplayFormat = '%.3f';
            app.maximumEditField.Position = [412 205 100 22];
            app.maximumEditField.Value = 600.25;

            % Create NameofthegeneratedbiomapfileEditFieldLabel
            app.NameofthegeneratedbiomapfileEditFieldLabel = uilabel(app.ProcessingTab);
            app.NameofthegeneratedbiomapfileEditFieldLabel.HorizontalAlignment = 'right';
            app.NameofthegeneratedbiomapfileEditFieldLabel.FontWeight = 'bold';
            app.NameofthegeneratedbiomapfileEditFieldLabel.Position = [86 178 203 22];
            app.NameofthegeneratedbiomapfileEditFieldLabel.Text = 'Name of the generated biomap file';

            % Create NameofthegeneratedbiomapfileEditField
            app.NameofthegeneratedbiomapfileEditField = uieditfield(app.ProcessingTab, 'text');
            app.NameofthegeneratedbiomapfileEditField.Position = [300 178 157 22];

            % Create biomapLabel
            app.biomapLabel = uilabel(app.ProcessingTab);
            app.biomapLabel.FontWeight = 'bold';
            app.biomapLabel.Position = [467 178 52 22];
            app.biomapLabel.Text = '.biomap';

            % Create mapLabel_2
            app.mapLabel_2 = uilabel(app.ProcessingTab);
            app.mapLabel_2.FontWeight = 'bold';
            app.mapLabel_2.Position = [311 249 34 22];
            app.mapLabel_2.Text = '.map';

            % Create MapfilenameEditFieldLabel
            app.MapfilenameEditFieldLabel = uilabel(app.ProcessingTab);
            app.MapfilenameEditFieldLabel.HorizontalAlignment = 'right';
            app.MapfilenameEditFieldLabel.FontWeight = 'bold';
            app.MapfilenameEditFieldLabel.Position = [55 249 85 22];
            app.MapfilenameEditFieldLabel.Text = 'Map file name';

            % Create MapfilenameEditField
            app.MapfilenameEditField = uieditfield(app.ProcessingTab, 'text');
            app.MapfilenameEditField.ValueChangedFcn = createCallbackFcn(app, @MapfilenameEditFieldValueChanged, true);
            app.MapfilenameEditField.ValueChangingFcn = createCallbackFcn(app, @MapfilenameEditFieldValueChanging, true);
            app.MapfilenameEditField.Position = [155 249 146 22];

            % Create LaunchReconstructionButton
            app.LaunchReconstructionButton = uibutton(app.ProcessingTab, 'push');
            app.LaunchReconstructionButton.ButtonPushedFcn = createCallbackFcn(app, @LaunchReconstructionButtonPushed, true);
            app.LaunchReconstructionButton.FontWeight = 'bold';
            app.LaunchReconstructionButton.Position = [217 146 150 22];
            app.LaunchReconstructionButton.Text = 'Launch Reconstruction';

            % Create Timebetween2lasershotsecondEditFieldLabel
            app.Timebetween2lasershotsecondEditFieldLabel = uilabel(app.ProcessingTab);
            app.Timebetween2lasershotsecondEditFieldLabel.HorizontalAlignment = 'right';
            app.Timebetween2lasershotsecondEditFieldLabel.Position = [24 645 197 22];
            app.Timebetween2lasershotsecondEditFieldLabel.Text = 'Time between 2 laser shot (second)';

            % Create Timebetween2lasershotsecondEditField
            app.Timebetween2lasershotsecondEditField = uieditfield(app.ProcessingTab, 'numeric');
            app.Timebetween2lasershotsecondEditField.Position = [236 645 100 22];
            app.Timebetween2lasershotsecondEditField.Value = 3;

            % Create LoudthresholdEditFieldLabel
            app.LoudthresholdEditFieldLabel = uilabel(app.ProcessingTab);
            app.LoudthresholdEditFieldLabel.HorizontalAlignment = 'right';
            app.LoudthresholdEditFieldLabel.Position = [30 608 85 22];
            app.LoudthresholdEditFieldLabel.Text = 'Loud threshold';

            % Create LoudthresholdEditField
            app.LoudthresholdEditField = uieditfield(app.ProcessingTab, 'numeric');
            app.LoudthresholdEditField.Position = [130 608 100 22];
            app.LoudthresholdEditField.Value = 5000;

            % Create LaunchTimeEstimationButton
            app.LaunchTimeEstimationButton = uibutton(app.ProcessingTab, 'push');
            app.LaunchTimeEstimationButton.ButtonPushedFcn = createCallbackFcn(app, @LaunchTimeEstimationButtonPushed, true);
            app.LaunchTimeEstimationButton.FontWeight = 'bold';
            app.LaunchTimeEstimationButton.Position = [65 746 154 22];
            app.LaunchTimeEstimationButton.Text = 'Launch Time Estimation';

            % Create ExtractOneSpectraButton
            app.ExtractOneSpectraButton = uibutton(app.ProcessingTab, 'push');
            app.ExtractOneSpectraButton.ButtonPushedFcn = createCallbackFcn(app, @ExtractOneSpectraButtonPushed, true);
            app.ExtractOneSpectraButton.FontWeight = 'bold';
            app.ExtractOneSpectraButton.Position = [139 86 130 22];
            app.ExtractOneSpectraButton.Text = 'Extract One Spectra';

            % Create ExtractSpectraZoneButton
            app.ExtractSpectraZoneButton = uibutton(app.ProcessingTab, 'push');
            app.ExtractSpectraZoneButton.ButtonPushedFcn = createCallbackFcn(app, @ExtractSpectraZoneButtonPushed, true);
            app.ExtractSpectraZoneButton.FontWeight = 'bold';
            app.ExtractSpectraZoneButton.Position = [299 85 136 22];
            app.ExtractSpectraZoneButton.Text = 'Extract Spectra Zone';

            % Create TimeValue
            app.TimeValue = uilabel(app.ProcessingTab);
            app.TimeValue.Position = [234 746 115 22];
            app.TimeValue.Text = 'NO DATA';

            % Create PlotChromatogramButton
            app.PlotChromatogramButton = uibutton(app.ProcessingTab, 'push');
            app.PlotChromatogramButton.ButtonPushedFcn = createCallbackFcn(app, @PlotChromatogramButtonPushed, true);
            app.PlotChromatogramButton.FontWeight = 'bold';
            app.PlotChromatogramButton.Position = [389 746 136 22];
            app.PlotChromatogramButton.Text = 'Plot Chromatogram';

            % Create InternalTriggeringSwitchLabel
            app.InternalTriggeringSwitchLabel = uilabel(app.ProcessingTab);
            app.InternalTriggeringSwitchLabel.HorizontalAlignment = 'center';
            app.InternalTriggeringSwitchLabel.Position = [368 599 102 22];
            app.InternalTriggeringSwitchLabel.Text = 'Internal Triggering';

            % Create InternalTriggeringSwitch
            app.InternalTriggeringSwitch = uiswitch(app.ProcessingTab, 'slider');
            app.InternalTriggeringSwitch.Position = [404 573 45 20];
            app.InternalTriggeringSwitch.Value = 'On';

            % Create MapFromSpectraButton
            app.MapFromSpectraButton = uibutton(app.ProcessingTab, 'push');
            app.MapFromSpectraButton.ButtonPushedFcn = createCallbackFcn(app, @MapFromSpectraButtonPushed, true);
            app.MapFromSpectraButton.FontWeight = 'bold';
            app.MapFromSpectraButton.Position = [290 42 172 22];
            app.MapFromSpectraButton.Text = 'Map From Spectra';

            % Create FusionpercentSliderLabel
            app.FusionpercentSliderLabel = uilabel(app.ProcessingTab);
            app.FusionpercentSliderLabel.HorizontalAlignment = 'right';
            app.FusionpercentSliderLabel.Position = [18 558 98 42];
            app.FusionpercentSliderLabel.Text = ' Fusion percent';

            % Create FusionpercentSlider
            app.FusionpercentSlider = uislider(app.ProcessingTab);
            app.FusionpercentSlider.Position = [137 587 136 3];
            app.FusionpercentSlider.Value = 50;

            % Create mapLabel_5
            app.mapLabel_5 = uilabel(app.ProcessingTab);
            app.mapLabel_5.FontWeight = 'bold';
            app.mapLabel_5.Position = [407 678 34 22];
            app.mapLabel_5.Text = '.map';

            % Create MapfilenameEditField_2Label
            app.MapfilenameEditField_2Label = uilabel(app.ProcessingTab);
            app.MapfilenameEditField_2Label.HorizontalAlignment = 'right';
            app.MapfilenameEditField_2Label.FontWeight = 'bold';
            app.MapfilenameEditField_2Label.Position = [142 678 85 22];
            app.MapfilenameEditField_2Label.Text = 'Map file name';

            % Create MapfilenameEditField_2
            app.MapfilenameEditField_2 = uieditfield(app.ProcessingTab, 'text');
            app.MapfilenameEditField_2.Position = [242 678 146 22];

            % Create LouddataonthemapSwitchLabel
            app.LouddataonthemapSwitchLabel = uilabel(app.ProcessingTab);
            app.LouddataonthemapSwitchLabel.HorizontalAlignment = 'center';
            app.LouddataonthemapSwitchLabel.Position = [414 275 122 22];
            app.LouddataonthemapSwitchLabel.Text = 'Loud data on the map';

            % Create LouddataonthemapSwitch
            app.LouddataonthemapSwitch = uiswitch(app.ProcessingTab, 'slider');
            app.LouddataonthemapSwitch.Position = [449 251 45 20];

            % Create LoadmzXMLButton
            app.LoadmzXMLButton = uibutton(app.ProcessingTab, 'push');
            app.LoadmzXMLButton.ButtonPushedFcn = createCallbackFcn(app, @LoadmzXMLButtonPushed, true);
            app.LoadmzXMLButton.FontWeight = 'bold';
            app.LoadmzXMLButton.Position = [262 773 100 22];
            app.LoadmzXMLButton.Text = 'Load mzXML';

            % Create MaxEditFieldLabel
            app.MaxEditFieldLabel = uilabel(app.ProcessingTab);
            app.MaxEditFieldLabel.HorizontalAlignment = 'right';
            app.MaxEditFieldLabel.Position = [183 43 28 22];
            app.MaxEditFieldLabel.Text = 'Max';

            % Create MaxEditField
            app.MaxEditField = uieditfield(app.ProcessingTab, 'numeric');
            app.MaxEditField.ValueChangedFcn = createCallbackFcn(app, @MaxEditFieldValueChanged, true);
            app.MaxEditField.Position = [226 41 43 25];
            app.MaxEditField.Value = 2000;

            % Create MinEditFieldLabel
            app.MinEditFieldLabel = uilabel(app.ProcessingTab);
            app.MinEditFieldLabel.HorizontalAlignment = 'right';
            app.MinEditFieldLabel.Position = [89 44 27 22];
            app.MinEditFieldLabel.Text = 'Min';

            % Create MinEditField
            app.MinEditField = uieditfield(app.ProcessingTab, 'numeric');
            app.MinEditField.ValueChangedFcn = createCallbackFcn(app, @MinEditFieldValueChanged, true);
            app.MinEditField.Position = [125 42 44 25];

            % Create ScanSelectionButton
            app.ScanSelectionButton = uibutton(app.ProcessingTab, 'push');
            app.ScanSelectionButton.ButtonPushedFcn = createCallbackFcn(app, @ScanSelectionButtonPushed, true);
            app.ScanSelectionButton.FontWeight = 'bold';
            app.ScanSelectionButton.Position = [411 524 157 20];
            app.ScanSelectionButton.Text = 'Scan Selection';

            % Create ScanSelectionMethodDropDownLabel
            app.ScanSelectionMethodDropDownLabel = uilabel(app.ProcessingTab);
            app.ScanSelectionMethodDropDownLabel.HorizontalAlignment = 'right';
            app.ScanSelectionMethodDropDownLabel.Position = [38 522 128 22];
            app.ScanSelectionMethodDropDownLabel.Text = 'Scan Selection Method';

            % Create ScanSelectionMethodDropDown
            app.ScanSelectionMethodDropDown = uidropdown(app.ProcessingTab);
            app.ScanSelectionMethodDropDown.Position = [181 522 203 22];

            % Create mzXMLLoadingLabel
            app.mzXMLLoadingLabel = uilabel(app.ProcessingTab);
            app.mzXMLLoadingLabel.FontWeight = 'bold';
            app.mzXMLLoadingLabel.Position = [6 828 243 22];
            app.mzXMLLoadingLabel.Text = 'mzXML Loading :';

            % Create ScanSelectionLabel
            app.ScanSelectionLabel = uilabel(app.ProcessingTab);
            app.ScanSelectionLabel.FontWeight = 'bold';
            app.ScanSelectionLabel.Position = [5 697 243 22];
            app.ScanSelectionLabel.Text = 'Scan Selection :';

            % Create PreprocessingLabel
            app.PreprocessingLabel = uilabel(app.ProcessingTab);
            app.PreprocessingLabel.FontWeight = 'bold';
            app.PreprocessingLabel.Position = [5 465 243 22];
            app.PreprocessingLabel.Text = 'Preprocessing :';

            % Create ReconstructionLabel
            app.ReconstructionLabel = uilabel(app.ProcessingTab);
            app.ReconstructionLabel.FontWeight = 'bold';
            app.ReconstructionLabel.Position = [5 302 243 22];
            app.ReconstructionLabel.Text = 'Reconstruction :';

            % Create AdditionnalDataExtractionFeaturesLabel
            app.AdditionnalDataExtractionFeaturesLabel = uilabel(app.ProcessingTab);
            app.AdditionnalDataExtractionFeaturesLabel.FontWeight = 'bold';
            app.AdditionnalDataExtractionFeaturesLabel.Position = [5 111 243 22];
            app.AdditionnalDataExtractionFeaturesLabel.Text = 'Additionnal Data Extraction Features :';

            % Create PostProcessingTab
            app.PostProcessingTab = uitab(app.TabGroup);
            app.PostProcessingTab.Title = 'Post Processing';

            % Create NameofthemapEditFieldLabel
            app.NameofthemapEditFieldLabel = uilabel(app.PostProcessingTab);
            app.NameofthemapEditFieldLabel.HorizontalAlignment = 'right';
            app.NameofthemapEditFieldLabel.Position = [129 796 98 22];
            app.NameofthemapEditFieldLabel.Text = 'Name of the map';

            % Create NameofthemapEditField
            app.NameofthemapEditField = uieditfield(app.PostProcessingTab, 'text');
            app.NameofthemapEditField.ValueChangedFcn = createCallbackFcn(app, @NameofthemapEditFieldValueChanged, true);
            app.NameofthemapEditField.Position = [242 796 146 22];

            % Create NameofthecorrectedmapEditFieldLabel
            app.NameofthecorrectedmapEditFieldLabel = uilabel(app.PostProcessingTab);
            app.NameofthecorrectedmapEditFieldLabel.HorizontalAlignment = 'right';
            app.NameofthecorrectedmapEditFieldLabel.Position = [73 767 154 22];
            app.NameofthecorrectedmapEditFieldLabel.Text = 'Name of the corrected map ';

            % Create NameofthecorrectedmapEditField
            app.NameofthecorrectedmapEditField = uieditfield(app.PostProcessingTab, 'text');
            app.NameofthecorrectedmapEditField.Position = [242 767 146 22];

            % Create LaunchRectificationButton
            app.LaunchRectificationButton = uibutton(app.PostProcessingTab, 'push');
            app.LaunchRectificationButton.ButtonPushedFcn = createCallbackFcn(app, @LaunchRectificationButtonPushed, true);
            app.LaunchRectificationButton.FontWeight = 'bold';
            app.LaunchRectificationButton.Position = [217 659 137 22];
            app.LaunchRectificationButton.Text = 'Launch Rectification ';

            % Create mapLabel_3
            app.mapLabel_3 = uilabel(app.PostProcessingTab);
            app.mapLabel_3.FontWeight = 'bold';
            app.mapLabel_3.Position = [390 796 34 22];
            app.mapLabel_3.Text = '.map';

            % Create mapLabel_4
            app.mapLabel_4 = uilabel(app.PostProcessingTab);
            app.mapLabel_4.FontWeight = 'bold';
            app.mapLabel_4.Position = [392 767 34 22];
            app.mapLabel_4.Text = '.map';

            % Create MinimumthresholdmmEditFieldLabel
            app.MinimumthresholdmmEditFieldLabel = uilabel(app.PostProcessingTab);
            app.MinimumthresholdmmEditFieldLabel.HorizontalAlignment = 'right';
            app.MinimumthresholdmmEditFieldLabel.Position = [143 731 142 22];
            app.MinimumthresholdmmEditFieldLabel.Text = 'Minimum threshold (mm) ';

            % Create MinimumthresholdmmEditField
            app.MinimumthresholdmmEditField = uieditfield(app.PostProcessingTab, 'numeric');
            app.MinimumthresholdmmEditField.Position = [302 730 100 22];

            % Create MaximumthresholdmmEditFieldLabel
            app.MaximumthresholdmmEditFieldLabel = uilabel(app.PostProcessingTab);
            app.MaximumthresholdmmEditFieldLabel.HorizontalAlignment = 'right';
            app.MaximumthresholdmmEditFieldLabel.Position = [142 698 145 22];
            app.MaximumthresholdmmEditFieldLabel.Text = 'Maximum threshold (mm) ';

            % Create MaximumthresholdmmEditField
            app.MaximumthresholdmmEditField = uieditfield(app.PostProcessingTab, 'numeric');
            app.MaximumthresholdmmEditField.Position = [302 698 102 22];
            app.MaximumthresholdmmEditField.Value = 20;

            % Create LaunchInterpolationButton
            app.LaunchInterpolationButton = uibutton(app.PostProcessingTab, 'push');
            app.LaunchInterpolationButton.ButtonPushedFcn = createCallbackFcn(app, @LaunchInterpolationButtonPushed, true);
            app.LaunchInterpolationButton.FontWeight = 'bold';
            app.LaunchInterpolationButton.Position = [217 460 134 22];
            app.LaunchInterpolationButton.Text = 'Launch Interpolation';

            % Create mapLabel_6
            app.mapLabel_6 = uilabel(app.PostProcessingTab);
            app.mapLabel_6.FontWeight = 'bold';
            app.mapLabel_6.Position = [400 565 34 22];
            app.mapLabel_6.Text = '.map';

            % Create mapLabel_7
            app.mapLabel_7 = uilabel(app.PostProcessingTab);
            app.mapLabel_7.FontWeight = 'bold';
            app.mapLabel_7.Position = [401 536 34 22];
            app.mapLabel_7.Text = '.map';

            % Create NameofthemapEditField_2Label
            app.NameofthemapEditField_2Label = uilabel(app.PostProcessingTab);
            app.NameofthemapEditField_2Label.HorizontalAlignment = 'right';
            app.NameofthemapEditField_2Label.Position = [139 565 98 22];
            app.NameofthemapEditField_2Label.Text = 'Name of the map';

            % Create NameofthemapEditField_22
            app.NameofthemapEditField_22 = uieditfield(app.PostProcessingTab, 'text');
            app.NameofthemapEditField_22.Position = [252 565 146 22];

            % Create NameoftheinterpolatedmapEditFieldLabel
            app.NameoftheinterpolatedmapEditFieldLabel = uilabel(app.PostProcessingTab);
            app.NameoftheinterpolatedmapEditFieldLabel.HorizontalAlignment = 'right';
            app.NameoftheinterpolatedmapEditFieldLabel.Position = [70 537 167 22];
            app.NameoftheinterpolatedmapEditFieldLabel.Text = 'Name of the interpolated map ';

            % Create NameoftheinterpolatedmapEditField
            app.NameoftheinterpolatedmapEditField = uieditfield(app.PostProcessingTab, 'text');
            app.NameoftheinterpolatedmapEditField.Position = [252 537 146 22];

            % Create PointMultiplierEditFieldLabel
            app.PointMultiplierEditFieldLabel = uilabel(app.PostProcessingTab);
            app.PointMultiplierEditFieldLabel.HorizontalAlignment = 'right';
            app.PointMultiplierEditFieldLabel.Position = [180 502 84 22];
            app.PointMultiplierEditFieldLabel.Text = 'Point Multiplier';

            % Create PointMultiplierEditField
            app.PointMultiplierEditField = uieditfield(app.PostProcessingTab, 'numeric');
            app.PointMultiplierEditField.Position = [281 501 100 22];
            app.PointMultiplierEditField.Value = 2;

            % Create LaunchBiomapInterpolationButton
            app.LaunchBiomapInterpolationButton = uibutton(app.PostProcessingTab, 'push');
            app.LaunchBiomapInterpolationButton.ButtonPushedFcn = createCallbackFcn(app, @LaunchBiomapInterpolationButtonPushed, true);
            app.LaunchBiomapInterpolationButton.FontWeight = 'bold';
            app.LaunchBiomapInterpolationButton.Position = [198 266 182 22];
            app.LaunchBiomapInterpolationButton.Text = 'Launch Biomap Interpolation';

            % Create biomapLabel_2
            app.biomapLabel_2 = uilabel(app.PostProcessingTab);
            app.biomapLabel_2.FontWeight = 'bold';
            app.biomapLabel_2.Position = [416 370 52 22];
            app.biomapLabel_2.Text = '.biomap';

            % Create biomapLabel_3
            app.biomapLabel_3 = uilabel(app.PostProcessingTab);
            app.biomapLabel_3.FontWeight = 'bold';
            app.biomapLabel_3.Position = [417 340 52 22];
            app.biomapLabel_3.Text = '.biomap';

            % Create NameofthebiomapEditFieldLabel
            app.NameofthebiomapEditFieldLabel = uilabel(app.PostProcessingTab);
            app.NameofthebiomapEditFieldLabel.HorizontalAlignment = 'right';
            app.NameofthebiomapEditFieldLabel.Position = [139 370 114 22];
            app.NameofthebiomapEditFieldLabel.Text = 'Name of the biomap';

            % Create NameofthebiomapEditField
            app.NameofthebiomapEditField = uieditfield(app.PostProcessingTab, 'text');
            app.NameofthebiomapEditField.Position = [268 370 146 22];

            % Create NameoftheinterpolatedbiomapEditFieldLabel
            app.NameoftheinterpolatedbiomapEditFieldLabel = uilabel(app.PostProcessingTab);
            app.NameoftheinterpolatedbiomapEditFieldLabel.HorizontalAlignment = 'right';
            app.NameoftheinterpolatedbiomapEditFieldLabel.Position = [71 341 183 22];
            app.NameoftheinterpolatedbiomapEditFieldLabel.Text = 'Name of the interpolated biomap ';

            % Create NameoftheinterpolatedbiomapEditField
            app.NameoftheinterpolatedbiomapEditField = uieditfield(app.PostProcessingTab, 'text');
            app.NameoftheinterpolatedbiomapEditField.Position = [269 341 146 22];

            % Create PointMultiplierEditField_2Label
            app.PointMultiplierEditField_2Label = uilabel(app.PostProcessingTab);
            app.PointMultiplierEditField_2Label.HorizontalAlignment = 'right';
            app.PointMultiplierEditField_2Label.Position = [190 309 84 22];
            app.PointMultiplierEditField_2Label.Text = 'Point Multiplier';

            % Create PointMultiplierEditField_2
            app.PointMultiplierEditField_2 = uieditfield(app.PostProcessingTab, 'numeric');
            app.PointMultiplierEditField_2.Position = [291 308 100 22];
            app.PointMultiplierEditField_2.Value = 2;

            % Create TopographicCorrectionLabel
            app.TopographicCorrectionLabel = uilabel(app.PostProcessingTab);
            app.TopographicCorrectionLabel.FontWeight = 'bold';
            app.TopographicCorrectionLabel.Position = [5 817 311 22];
            app.TopographicCorrectionLabel.Text = 'Topographic Correction :';

            % Create TopographicInterpolationLabel
            app.TopographicInterpolationLabel = uilabel(app.PostProcessingTab);
            app.TopographicInterpolationLabel.FontWeight = 'bold';
            app.TopographicInterpolationLabel.Position = [6 589 311 22];
            app.TopographicInterpolationLabel.Text = 'Topographic Interpolation :';

            % Create BiometricDataInterpolationLabel
            app.BiometricDataInterpolationLabel = uilabel(app.PostProcessingTab);
            app.BiometricDataInterpolationLabel.FontWeight = 'bold';
            app.BiometricDataInterpolationLabel.Position = [6 388 311 22];
            app.BiometricDataInterpolationLabel.Text = 'Biometric Data Interpolation :';

            % Create DIsplayfromexternaldataTab
            app.DIsplayfromexternaldataTab = uitab(app.TabGroup);
            app.DIsplayfromexternaldataTab.Title = 'DIsplay from external data';

            % Create ColorDropDownLabel
            app.ColorDropDownLabel = uilabel(app.DIsplayfromexternaldataTab);
            app.ColorDropDownLabel.HorizontalAlignment = 'right';
            app.ColorDropDownLabel.Position = [311 675 34 22];
            app.ColorDropDownLabel.Text = 'Color';

            % Create ColorDropDown
            app.ColorDropDown = uidropdown(app.DIsplayfromexternaldataTab);
            app.ColorDropDown.Items = {'Red', 'Green', 'Blue', 'Orange', 'Violet', 'Yellow', 'None'};
            app.ColorDropDown.Position = [360 675 100 22];
            app.ColorDropDown.Value = 'Red';

            % Create NameofthematfileEditFieldLabel
            app.NameofthematfileEditFieldLabel = uilabel(app.DIsplayfromexternaldataTab);
            app.NameofthematfileEditFieldLabel.HorizontalAlignment = 'right';
            app.NameofthematfileEditFieldLabel.Position = [124 786 113 22];
            app.NameofthematfileEditFieldLabel.Text = 'Name of the mat file';

            % Create NameofthematfileEditField
            app.NameofthematfileEditField = uieditfield(app.DIsplayfromexternaldataTab, 'text');
            app.NameofthematfileEditField.Position = [252 786 167 22];

            % Create matLabel_4
            app.matLabel_4 = uilabel(app.DIsplayfromexternaldataTab);
            app.matLabel_4.FontWeight = 'bold';
            app.matLabel_4.Position = [426 781 30 22];
            app.matLabel_4.Text = '.mat';

            % Create mapLabel_8
            app.mapLabel_8 = uilabel(app.DIsplayfromexternaldataTab);
            app.mapLabel_8.FontWeight = 'bold';
            app.mapLabel_8.Position = [426 752 34 22];
            app.mapLabel_8.Text = '.map';

            % Create NameofthemapfileEditFieldLabel
            app.NameofthemapfileEditFieldLabel = uilabel(app.DIsplayfromexternaldataTab);
            app.NameofthemapfileEditFieldLabel.HorizontalAlignment = 'right';
            app.NameofthemapfileEditFieldLabel.Position = [120 752 116 22];
            app.NameofthemapfileEditFieldLabel.Text = 'Name of the map file';

            % Create NameofthemapfileEditField
            app.NameofthemapfileEditField = uieditfield(app.DIsplayfromexternaldataTab, 'text');
            app.NameofthemapfileEditField.Position = [251 752 166 22];

            % Create csvLabel
            app.csvLabel = uilabel(app.DIsplayfromexternaldataTab);
            app.csvLabel.FontWeight = 'bold';
            app.csvLabel.Position = [427 718 29 22];
            app.csvLabel.Text = '.csv';

            % Create NameofthecsvfileEditFieldLabel
            app.NameofthecsvfileEditFieldLabel = uilabel(app.DIsplayfromexternaldataTab);
            app.NameofthecsvfileEditFieldLabel.HorizontalAlignment = 'right';
            app.NameofthecsvfileEditFieldLabel.Position = [125 718 111 22];
            app.NameofthecsvfileEditFieldLabel.Text = 'Name of the csv file';

            % Create NameofthecsvfileEditField
            app.NameofthecsvfileEditField = uieditfield(app.DIsplayfromexternaldataTab, 'text');
            app.NameofthecsvfileEditField.Position = [251 718 167 22];

            % Create Class01EditFieldLabel
            app.Class01EditFieldLabel = uilabel(app.DIsplayfromexternaldataTab);
            app.Class01EditFieldLabel.HorizontalAlignment = 'right';
            app.Class01EditFieldLabel.Position = [105 675 52 22];
            app.Class01EditFieldLabel.Text = 'Class 01';

            % Create Class01EditField
            app.Class01EditField = uieditfield(app.DIsplayfromexternaldataTab, 'text');
            app.Class01EditField.Position = [172 675 130 22];

            % Create Class02EditFieldLabel
            app.Class02EditFieldLabel = uilabel(app.DIsplayfromexternaldataTab);
            app.Class02EditFieldLabel.HorizontalAlignment = 'right';
            app.Class02EditFieldLabel.Position = [105 646 52 22];
            app.Class02EditFieldLabel.Text = 'Class 02';

            % Create Class02EditField
            app.Class02EditField = uieditfield(app.DIsplayfromexternaldataTab, 'text');
            app.Class02EditField.Position = [172 646 130 22];

            % Create Class03EditFieldLabel
            app.Class03EditFieldLabel = uilabel(app.DIsplayfromexternaldataTab);
            app.Class03EditFieldLabel.HorizontalAlignment = 'right';
            app.Class03EditFieldLabel.Position = [106 615 52 22];
            app.Class03EditFieldLabel.Text = 'Class 03';

            % Create Class03EditField
            app.Class03EditField = uieditfield(app.DIsplayfromexternaldataTab, 'text');
            app.Class03EditField.Position = [173 615 130 22];

            % Create LaunchLDAReconstructionButton
            app.LaunchLDAReconstructionButton = uibutton(app.DIsplayfromexternaldataTab, 'push');
            app.LaunchLDAReconstructionButton.ButtonPushedFcn = createCallbackFcn(app, @LaunchLDAReconstructionButtonPushed, true);
            app.LaunchLDAReconstructionButton.FontWeight = 'bold';
            app.LaunchLDAReconstructionButton.Position = [205 399 178 22];
            app.LaunchLDAReconstructionButton.Text = 'Launch LDA Reconstruction';

            % Create BackgroundColorDropDownLabel
            app.BackgroundColorDropDownLabel = uilabel(app.DIsplayfromexternaldataTab);
            app.BackgroundColorDropDownLabel.HorizontalAlignment = 'right';
            app.BackgroundColorDropDownLabel.Position = [187 438 102 22];
            app.BackgroundColorDropDownLabel.Text = 'Background Color';

            % Create BackgroundColorDropDown
            app.BackgroundColorDropDown = uidropdown(app.DIsplayfromexternaldataTab);
            app.BackgroundColorDropDown.Items = {'Black', 'White', 'Grey'};
            app.BackgroundColorDropDown.Position = [304 438 100 22];
            app.BackgroundColorDropDown.Value = 'Black';

            % Create ColorDropDown_2Label
            app.ColorDropDown_2Label = uilabel(app.DIsplayfromexternaldataTab);
            app.ColorDropDown_2Label.HorizontalAlignment = 'right';
            app.ColorDropDown_2Label.Position = [312 645 34 22];
            app.ColorDropDown_2Label.Text = 'Color';

            % Create ColorDropDown_2
            app.ColorDropDown_2 = uidropdown(app.DIsplayfromexternaldataTab);
            app.ColorDropDown_2.Items = {'Red', 'Green', 'Blue', 'Orange', 'Violet', 'Yellow', 'None'};
            app.ColorDropDown_2.Position = [361 645 100 22];
            app.ColorDropDown_2.Value = 'Green';

            % Create ColorDropDown_3Label
            app.ColorDropDown_3Label = uilabel(app.DIsplayfromexternaldataTab);
            app.ColorDropDown_3Label.HorizontalAlignment = 'right';
            app.ColorDropDown_3Label.Position = [313 615 34 22];
            app.ColorDropDown_3Label.Text = 'Color';

            % Create ColorDropDown_3
            app.ColorDropDown_3 = uidropdown(app.DIsplayfromexternaldataTab);
            app.ColorDropDown_3.Items = {'Red', 'Green', 'Blue', 'Orange', 'Violet', 'Yellow', 'None'};
            app.ColorDropDown_3.Position = [362 615 100 22];
            app.ColorDropDown_3.Value = 'Orange';

            % Create ColorDropDown_4Label
            app.ColorDropDown_4Label = uilabel(app.DIsplayfromexternaldataTab);
            app.ColorDropDown_4Label.HorizontalAlignment = 'right';
            app.ColorDropDown_4Label.Position = [314 584 34 22];
            app.ColorDropDown_4Label.Text = 'Color';

            % Create ColorDropDown_4
            app.ColorDropDown_4 = uidropdown(app.DIsplayfromexternaldataTab);
            app.ColorDropDown_4.Items = {'Red', 'Green', 'Blue', 'Orange', 'Violet', 'Yellow', 'None'};
            app.ColorDropDown_4.Position = [363 584 100 22];
            app.ColorDropDown_4.Value = 'None';

            % Create Class04EditFieldLabel
            app.Class04EditFieldLabel = uilabel(app.DIsplayfromexternaldataTab);
            app.Class04EditFieldLabel.HorizontalAlignment = 'right';
            app.Class04EditFieldLabel.Position = [108 584 52 22];
            app.Class04EditFieldLabel.Text = 'Class 04';

            % Create Class04EditField
            app.Class04EditField = uieditfield(app.DIsplayfromexternaldataTab, 'text');
            app.Class04EditField.Position = [175 584 130 22];

            % Create Class05EditFieldLabel
            app.Class05EditFieldLabel = uilabel(app.DIsplayfromexternaldataTab);
            app.Class05EditFieldLabel.HorizontalAlignment = 'right';
            app.Class05EditFieldLabel.Position = [108 555 52 22];
            app.Class05EditFieldLabel.Text = 'Class 05';

            % Create Class05EditField
            app.Class05EditField = uieditfield(app.DIsplayfromexternaldataTab, 'text');
            app.Class05EditField.Position = [175 555 130 22];

            % Create Class06EditFieldLabel
            app.Class06EditFieldLabel = uilabel(app.DIsplayfromexternaldataTab);
            app.Class06EditFieldLabel.HorizontalAlignment = 'right';
            app.Class06EditFieldLabel.Position = [109 524 52 22];
            app.Class06EditFieldLabel.Text = 'Class 06';

            % Create Class06EditField
            app.Class06EditField = uieditfield(app.DIsplayfromexternaldataTab, 'text');
            app.Class06EditField.Position = [176 524 130 22];

            % Create ColorDropDown_5Label
            app.ColorDropDown_5Label = uilabel(app.DIsplayfromexternaldataTab);
            app.ColorDropDown_5Label.HorizontalAlignment = 'right';
            app.ColorDropDown_5Label.Position = [315 554 34 22];
            app.ColorDropDown_5Label.Text = 'Color';

            % Create ColorDropDown_5
            app.ColorDropDown_5 = uidropdown(app.DIsplayfromexternaldataTab);
            app.ColorDropDown_5.Items = {'Red', 'Green', 'Blue', 'Orange', 'Violet', 'Yellow', 'None'};
            app.ColorDropDown_5.Position = [364 554 100 22];
            app.ColorDropDown_5.Value = 'None';

            % Create ColorDropDown_6Label
            app.ColorDropDown_6Label = uilabel(app.DIsplayfromexternaldataTab);
            app.ColorDropDown_6Label.HorizontalAlignment = 'right';
            app.ColorDropDown_6Label.Position = [316 524 34 22];
            app.ColorDropDown_6Label.Text = 'Color';

            % Create ColorDropDown_6
            app.ColorDropDown_6 = uidropdown(app.DIsplayfromexternaldataTab);
            app.ColorDropDown_6.Items = {'Red', 'Green', 'Blue', 'Orange', 'Violet', 'Yellow', 'None'};
            app.ColorDropDown_6.Position = [365 524 100 22];
            app.ColorDropDown_6.Value = 'None';

            % Create Label
            app.Label = uilabel(app.DIsplayfromexternaldataTab);
            app.Label.FontWeight = 'bold';
            app.Label.Position = [7 814 505 25];
            app.Label.Text = 'Import Classification from External Software : Display of the classification on the map';

            % Create Scils_Extraction
            app.Scils_Extraction = uitab(app.TabGroup);
            app.Scils_Extraction.Title = 'Data Extraction';

            % Create matLabel_5
            app.matLabel_5 = uilabel(app.Scils_Extraction);
            app.matLabel_5.FontWeight = 'bold';
            app.matLabel_5.Position = [432 745 30 22];
            app.matLabel_5.Text = '.mat';

            % Create InputMatfilenameEditFieldLabel
            app.InputMatfilenameEditFieldLabel = uilabel(app.Scils_Extraction);
            app.InputMatfilenameEditFieldLabel.HorizontalAlignment = 'right';
            app.InputMatfilenameEditFieldLabel.FontWeight = 'bold';
            app.InputMatfilenameEditFieldLabel.Position = [130 745 122 22];
            app.InputMatfilenameEditFieldLabel.Text = 'Input : Mat file name';

            % Create InputMatfilenameEditField_scils
            app.InputMatfilenameEditField_scils = uieditfield(app.Scils_Extraction, 'text');
            app.InputMatfilenameEditField_scils.ValueChangedFcn = createCallbackFcn(app, @InputMatfilenameEditField_scilsValueChanged, true);
            app.InputMatfilenameEditField_scils.Position = [267 745 155 22];

            % Create OutputnameofthecreatedtxtfileEditFieldLabel
            app.OutputnameofthecreatedtxtfileEditFieldLabel = uilabel(app.Scils_Extraction);
            app.OutputnameofthecreatedtxtfileEditFieldLabel.HorizontalAlignment = 'right';
            app.OutputnameofthecreatedtxtfileEditFieldLabel.FontWeight = 'bold';
            app.OutputnameofthecreatedtxtfileEditFieldLabel.Position = [102 699 209 22];
            app.OutputnameofthecreatedtxtfileEditFieldLabel.Text = 'Output : name of the created txt file';

            % Create OutputnameofthecreatedtxtfileEditField
            app.OutputnameofthecreatedtxtfileEditField = uieditfield(app.Scils_Extraction, 'text');
            app.OutputnameofthecreatedtxtfileEditField.Position = [326 699 146 22];

            % Create txtLabel
            app.txtLabel = uilabel(app.Scils_Extraction);
            app.txtLabel.FontWeight = 'bold';
            app.txtLabel.Position = [484 699 25 22];
            app.txtLabel.Text = '.txt';

            % Create LaunchExtractionButton
            app.LaunchExtractionButton = uibutton(app.Scils_Extraction, 'push');
            app.LaunchExtractionButton.ButtonPushedFcn = createCallbackFcn(app, @LaunchExtractionButtonPushed, true);
            app.LaunchExtractionButton.FontWeight = 'bold';
            app.LaunchExtractionButton.Position = [255 656 120 22];
            app.LaunchExtractionButton.Text = 'Launch Extraction';

            % Create ExporttoSCILSImzmlLabel
            app.ExporttoSCILSImzmlLabel = uilabel(app.Scils_Extraction);
            app.ExporttoSCILSImzmlLabel.HorizontalAlignment = 'center';
            app.ExporttoSCILSImzmlLabel.FontWeight = 'bold';
            app.ExporttoSCILSImzmlLabel.Position = [5 767 149 22];
            app.ExporttoSCILSImzmlLabel.Text = 'Export to SCILS (Imzml) :';

            % Create Exportto3DfileplyLabel
            app.Exportto3DfileplyLabel = uilabel(app.Scils_Extraction);
            app.Exportto3DfileplyLabel.HorizontalAlignment = 'center';
            app.Exportto3DfileplyLabel.FontWeight = 'bold';
            app.Exportto3DfileplyLabel.Position = [5 554 134 22];
            app.Exportto3DfileplyLabel.Text = 'Export to 3D file (ply) :';

            % Create ExportrawBioMapButton
            app.ExportrawBioMapButton = uibutton(app.Scils_Extraction, 'push');
            app.ExportrawBioMapButton.ButtonPushedFcn = createCallbackFcn(app, @ExportrawBioMapButtonPushed, true);
            app.ExportrawBioMapButton.FontWeight = 'bold';
            app.ExportrawBioMapButton.Position = [166 550 187 23];
            app.ExportrawBioMapButton.Text = 'Export raw BioMap';

            % Create ExportandcoregisterBiomapButton
            app.ExportandcoregisterBiomapButton = uibutton(app.Scils_Extraction, 'push');
            app.ExportandcoregisterBiomapButton.ButtonPushedFcn = createCallbackFcn(app, @ExportandcoregisterBiomapButtonPushed, true);
            app.ExportandcoregisterBiomapButton.FontWeight = 'bold';
            app.ExportandcoregisterBiomapButton.Position = [167 508 186 23];
            app.ExportandcoregisterBiomapButton.Text = 'Export and coregister Biomap';

            % Create ExporttoCSVfileLabel
            app.ExporttoCSVfileLabel = uilabel(app.Scils_Extraction);
            app.ExporttoCSVfileLabel.HorizontalAlignment = 'center';
            app.ExporttoCSVfileLabel.FontWeight = 'bold';
            app.ExporttoCSVfileLabel.Position = [4 459 134 22];
            app.ExporttoCSVfileLabel.Text = 'Export to CSV file:';

            % Create MinMzEditFieldLabel
            app.MinMzEditFieldLabel = uilabel(app.Scils_Extraction);
            app.MinMzEditFieldLabel.HorizontalAlignment = 'right';
            app.MinMzEditFieldLabel.Position = [133 459 47 22];
            app.MinMzEditFieldLabel.Text = 'Min M/z';

            % Create MinMzEditField
            app.MinMzEditField = uieditfield(app.Scils_Extraction, 'numeric');
            app.MinMzEditField.Position = [195 459 61 22];

            % Create MaxMzEditFieldLabel
            app.MaxMzEditFieldLabel = uilabel(app.Scils_Extraction);
            app.MaxMzEditFieldLabel.HorizontalAlignment = 'right';
            app.MaxMzEditFieldLabel.Position = [129 432 50 22];
            app.MaxMzEditFieldLabel.Text = 'Max M/z';

            % Create MaxMzEditField
            app.MaxMzEditField = uieditfield(app.Scils_Extraction, 'numeric');
            app.MaxMzEditField.Position = [194 432 61 22];
            app.MaxMzEditField.Value = 2000;

            % Create BinningEditFieldLabel
            app.BinningEditFieldLabel = uilabel(app.Scils_Extraction);
            app.BinningEditFieldLabel.HorizontalAlignment = 'right';
            app.BinningEditFieldLabel.Position = [134 405 45 22];
            app.BinningEditFieldLabel.Text = 'Binning';

            % Create BinningEditField
            app.BinningEditField = uieditfield(app.Scils_Extraction, 'numeric');
            app.BinningEditField.Position = [194 405 61 22];
            app.BinningEditField.Value = 0.1;

            % Create InputmatfileEditFieldLabel
            app.InputmatfileEditFieldLabel = uilabel(app.Scils_Extraction);
            app.InputmatfileEditFieldLabel.HorizontalAlignment = 'right';
            app.InputmatfileEditFieldLabel.Position = [310 459 77 22];
            app.InputmatfileEditFieldLabel.Text = 'Input .mat file';

            % Create InputmatfileEditField
            app.InputmatfileEditField = uieditfield(app.Scils_Extraction, 'text');
            app.InputmatfileEditField.Position = [397 461 95 19];

            % Create InputmapfileEditFieldLabel
            app.InputmapfileEditFieldLabel = uilabel(app.Scils_Extraction);
            app.InputmapfileEditFieldLabel.HorizontalAlignment = 'right';
            app.InputmapfileEditFieldLabel.Position = [307 422 80 22];
            app.InputmapfileEditFieldLabel.Text = 'Input .map file';

            % Create InputmapfileEditField
            app.InputmapfileEditField = uieditfield(app.Scils_Extraction, 'text');
            app.InputmapfileEditField.Position = [397 424 95 19];

            % Create matLabel_6
            app.matLabel_6 = uilabel(app.Scils_Extraction);
            app.matLabel_6.FontWeight = 'bold';
            app.matLabel_6.Position = [503 457 65 24];
            app.matLabel_6.Text = '.mat';

            % Create mapLabel_9
            app.mapLabel_9 = uilabel(app.Scils_Extraction);
            app.mapLabel_9.FontWeight = 'bold';
            app.mapLabel_9.Position = [503 421 65 24];
            app.mapLabel_9.Text = '.map';

            % Create ExporttoCSVButton
            app.ExporttoCSVButton = uibutton(app.Scils_Extraction, 'push');
            app.ExporttoCSVButton.ButtonPushedFcn = createCallbackFcn(app, @ExporttoCSVButtonPushed, true);
            app.ExporttoCSVButton.FontWeight = 'bold';
            app.ExporttoCSVButton.Position = [197 341 187 23];
            app.ExporttoCSVButton.Text = 'Export to CSV';

            % Create NormalizeCSVTICButton
            app.NormalizeCSVTICButton = uibutton(app.Scils_Extraction, 'push');
            app.NormalizeCSVTICButton.ButtonPushedFcn = createCallbackFcn(app, @NormalizeCSVTICButtonPushed, true);
            app.NormalizeCSVTICButton.FontWeight = 'bold';
            app.NormalizeCSVTICButton.Position = [197 308 187 23];
            app.NormalizeCSVTICButton.Text = 'Normalize CSV (TIC)';

            % Create ExportrawCSVButton
            app.ExportrawCSVButton = uibutton(app.Scils_Extraction, 'push');
            app.ExportrawCSVButton.ButtonPushedFcn = createCallbackFcn(app, @ExportrawCSVButtonPushed, true);
            app.ExportrawCSVButton.FontWeight = 'bold';
            app.ExportrawCSVButton.Position = [368 551 187 23];
            app.ExportrawCSVButton.Text = 'Export raw CSV';

            % Create ExportandcoregisterCSVButton
            app.ExportandcoregisterCSVButton = uibutton(app.Scils_Extraction, 'push');
            app.ExportandcoregisterCSVButton.ButtonPushedFcn = createCallbackFcn(app, @ExportandcoregisterCSVButtonPushed, true);
            app.ExportandcoregisterCSVButton.FontWeight = 'bold';
            app.ExportandcoregisterCSVButton.Position = [379 509 167 23];
            app.ExportandcoregisterCSVButton.Text = 'Export and coregister CSV';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = mapping_APP_7

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end