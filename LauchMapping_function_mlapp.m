classdef mapping_APP_7 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        OMGMSIChooseyourmodePanel       matlab.ui.container.Panel
        ProceedButton                   matlab.ui.control.Button
        InterfaceModeButtonGroup        matlab.ui.container.ButtonGroup
        DataprocessingButton            matlab.ui.control.RadioButton
        DataacquisitionButton           matlab.ui.control.RadioButton
        TabGroup2                       matlab.ui.container.TabGroup
        ModeTab                         matlab.ui.container.Tab
        ButtonGroupMappingSpeed         matlab.ui.container.ButtonGroup
        FastmappingButton               matlab.ui.control.RadioButton
        WithrepositioningButton         matlab.ui.control.RadioButton
        NextButton_6                    matlab.ui.control.Button
        MappingChoiceButtonGroup        matlab.ui.container.ButtonGroup
        LampWithSpectro_2D              matlab.ui.control.Lamp
        DmassspectometryButton          matlab.ui.control.RadioButton
        LampWithSpectro                 matlab.ui.control.Lamp
        LampOnlyTopo                    matlab.ui.control.Lamp
        DmassspectometryButton_2        matlab.ui.control.RadioButton
        OnlytopographicButton           matlab.ui.control.RadioButton
        AcquisitionPropertiesTab        matlab.ui.container.Tab
        NextButton_7                    matlab.ui.control.Button
        FisrtmappingpointXpositionmmEditField  matlab.ui.control.NumericEditField
        FisrtmappingpointXpositionmmEditFieldLabel  matlab.ui.control.Label
        MaximumheightmmofthesampleEditField  matlab.ui.control.NumericEditField
        MaximumheightmmofthesampleEditFieldLabel  matlab.ui.control.Label
        EstimationofmappingtimeLabel    matlab.ui.control.Label
        ZonesizeYaxismmEditField        matlab.ui.control.NumericEditField
        ZonesizeYaxismmEditFieldLabel   matlab.ui.control.Label
        ZonesizeXaxismmEditField        matlab.ui.control.NumericEditField
        ZonesizeXaxismmEditFieldLabel   matlab.ui.control.Label
        SurfaceoffestmmEditField        matlab.ui.control.NumericEditField
        SurfaceoffestmmEditFieldLabel   matlab.ui.control.Label
        MappingStepmmEditField          matlab.ui.control.NumericEditField
        MappingStepmmEditFieldLabel     matlab.ui.control.Label
        mapLabel                        matlab.ui.control.Label
        GeneratedmapfileEditField       matlab.ui.control.EditField
        GeneratedmapfileEditFieldLabel  matlab.ui.control.Label
        RobotTab                        matlab.ui.container.Tab
        NextButton_8                    matlab.ui.control.Button
        GOTOButton                      matlab.ui.control.Button
        ZPositionEditField              matlab.ui.control.NumericEditField
        ZPositionEditFieldLabel         matlab.ui.control.Label
        YPositionEditField              matlab.ui.control.NumericEditField
        YPositionEditFieldLabel         matlab.ui.control.Label
        XPositionEditField              matlab.ui.control.NumericEditField
        XPositionEditFieldLabel         matlab.ui.control.Label
        DisconnectRobotButton           matlab.ui.control.Button
        StateLampRobot                  matlab.ui.control.Lamp
        RobotConnexionB                 matlab.ui.control.Button
        RobotDropDown                   matlab.ui.control.DropDown
        RobotDropDownLabel              matlab.ui.control.Label
        SensorTab                       matlab.ui.container.Tab
        NextButton_9                    matlab.ui.control.Button
        ConnectSensorButton             matlab.ui.control.Button
        SensorCalibrationstateLamp      matlab.ui.control.Lamp
        CalibrationstateLabel           matlab.ui.control.Label
        LaunchSensorCalibrationButton   matlab.ui.control.Button
        SensorDropDown                  matlab.ui.control.DropDown
        SensorDropDownLabel             matlab.ui.control.Label
        LaserTab                        matlab.ui.container.Tab
        NumberoflasershotsburstmodeEditField  matlab.ui.control.NumericEditField
        NumberoflasershotsburstmodeEditFieldLabel  matlab.ui.control.Label
        TimebetweenlaserburstssecondEditField  matlab.ui.control.NumericEditField
        TimebetweenlaserburstssecondEditFieldLabel  matlab.ui.control.Label
        LaunchBurstButton               matlab.ui.control.Button
        LampVoltageSet                  matlab.ui.control.Lamp
        EnergylevelVSpinner             matlab.ui.control.Spinner
        EnergylevelVSpinnerLabel        matlab.ui.control.Label
        ContinuousLaserCheckBox         matlab.ui.control.CheckBox
        NextButton_10                   matlab.ui.control.Button
        MicroprobefocaldistanceinZaxismmEditField  matlab.ui.control.NumericEditField
        MicroprobefocaldistanceinZaxismmEditFieldLabel  matlab.ui.control.Label
        AffichageState                  matlab.ui.control.Label
        GetStateButton                  matlab.ui.control.Button
        TurnLampOffButton               matlab.ui.control.Button
        Lamp_LampONorOFF                matlab.ui.control.Lamp
        TurnLampOnButton                matlab.ui.control.Button
        AffichageTemperature            matlab.ui.control.Label
        GetTempButton                   matlab.ui.control.Button
        DisconnectButton                matlab.ui.control.Button
        StateLampOpotek                 matlab.ui.control.Lamp
        ConnectLaserButton              matlab.ui.control.Button
        LaserDropDown                   matlab.ui.control.DropDown
        LaserDropDownLabel              matlab.ui.control.Label
        RecapTab                        matlab.ui.container.Tab
        ETALabel                        matlab.ui.control.Label
        SensorStateOffLabel             matlab.ui.control.Label
        Resolutionm500Label             matlab.ui.control.Label
        YLabel                          matlab.ui.control.Label
        XLabel                          matlab.ui.control.Label
        MapDimensionsmmLabel            matlab.ui.control.Label
        MappingMode3DMassSpectrometryLabel  matlab.ui.control.Label
        LaserStateOffLabel              matlab.ui.control.Label
        RobotStateOffLabel              matlab.ui.control.Label
        QuittoMenuButton_2              matlab.ui.control.Button
        STOPCONTINUOUSLASERButton_2     matlab.ui.control.Button
        LaunchMappingButton             matlab.ui.control.Button
        NoMappingLabel                  matlab.ui.control.Label
        ClearMapButton                  matlab.ui.control.Button
        GotoPositionButton              matlab.ui.control.Button
        TabGroup                        matlab.ui.container.TabGroup
        ProcessingTab                   matlab.ui.container.Tab
        LouddataonthemapSwitch          matlab.ui.control.Switch
        LouddataonthemapSwitchLabel     matlab.ui.control.Label
        AdditionnalDataExtractionFeaturesLabel  matlab.ui.control.Label
        ReconstructionLabel             matlab.ui.control.Label
        MinEditField                    matlab.ui.control.NumericEditField
        MinEditFieldLabel               matlab.ui.control.Label
        MaxEditField                    matlab.ui.control.NumericEditField
        MaxEditFieldLabel               matlab.ui.control.Label
        MapFromSpectraButton            matlab.ui.control.Button
        ExtractSpectraZoneButton        matlab.ui.control.Button
        ExtractOneSpectrumButton        matlab.ui.control.Button
        LaunchReconstructionButton      matlab.ui.control.Button
        biomapLabel                     matlab.ui.control.Label
        BiomapOutputEditField           matlab.ui.control.EditField
        BiomapOutputEditFieldLabel      matlab.ui.control.Label
        MaximumEditField                matlab.ui.control.NumericEditField
        MaximumEditFieldLabel           matlab.ui.control.Label
        MasslimitsMinimumEditField      matlab.ui.control.NumericEditField
        MasslimitsMinimumEditFieldLabel  matlab.ui.control.Label
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
        mapLabel_7                      matlab.ui.control.Label
        LaunchInterpolationButton       matlab.ui.control.Button
        MaximumthresholdmmEditField     matlab.ui.control.NumericEditField
        MaximumthresholdmmEditFieldLabel  matlab.ui.control.Label
        MinimumthresholdmmEditField     matlab.ui.control.NumericEditField
        MinimumthresholdmmEditFieldLabel  matlab.ui.control.Label
        mapLabel_4                      matlab.ui.control.Label
        LaunchRectificationButton       matlab.ui.control.Button
        NameofthecorrectedmapEditField  matlab.ui.control.EditField
        NameofthecorrectedmapEditFieldLabel  matlab.ui.control.Label
        DisplayfromexternaldataTab      matlab.ui.container.Tab
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
        ColorDropDown                   matlab.ui.control.DropDown
        ColorDropDownLabel              matlab.ui.control.Label
        Scils_Extraction                matlab.ui.container.Tab
        ExportandcoregisterCSVButton    matlab.ui.control.Button
        ExportrawCSVButton              matlab.ui.control.Button
        NormalizeCSVTICButton           matlab.ui.control.Button
        ExporttoCSVButton               matlab.ui.control.Button
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
        OutputtextfileEditField         matlab.ui.control.EditField
        OutputtextfileEditFieldLabel    matlab.ui.control.Label
        OMGMSINewmatfilePanel           matlab.ui.container.Panel
        LoudthresholdEditField          matlab.ui.control.NumericEditField
        LoudthresholdEditFieldLabel     matlab.ui.control.Label
        BeginThresholdEditField         matlab.ui.control.NumericEditField
        BeginThresholdEditFieldLabel    matlab.ui.control.Label
        PlotChromatogramButton          matlab.ui.control.Button
        LoadmzXMLButton                 matlab.ui.control.Button
        TimeValue                       matlab.ui.control.Label
        LaunchTimeEstimationButton      matlab.ui.control.Button
        ScanSelectionMethodDropDown     matlab.ui.control.DropDown
        ScanSelectionMethodDropDownLabel  matlab.ui.control.Label
        mapLabel_5                      matlab.ui.control.Label
        MapfilenameEditField_2          matlab.ui.control.EditField
        MapfilenameEditField_2Label     matlab.ui.control.Label
        Timebetween2lasershotsecondEditField  matlab.ui.control.NumericEditField
        Timebetween2lasershotsecondEditFieldLabel  matlab.ui.control.Label
        AspirationTimesEditField        matlab.ui.control.NumericEditField
        AspirationTimesEditFieldLabel   matlab.ui.control.Label
        FusionpercentSlider             matlab.ui.control.Slider
        FusionpercentSliderLabel        matlab.ui.control.Label
        PreprocessingLabel              matlab.ui.control.Label
        InternalTriggeringSwitch        matlab.ui.control.Switch
        InternalTriggeringSwitchLabel   matlab.ui.control.Label
        ScanSelectionButton             matlab.ui.control.Button
        matLabel                        matlab.ui.control.Label
        GeneratedmatfileEditField       matlab.ui.control.EditField
        GeneratedmatfileEditFieldLabel  matlab.ui.control.Label
        BiningwindowsizeEditField       matlab.ui.control.NumericEditField
        BiningwindowsizeEditFieldLabel  matlab.ui.control.Label
        LaunchPreprocessingButton       matlab.ui.control.Button
        ScanSelectionLabel              matlab.ui.control.Label
        mzXMLLoadingLabel               matlab.ui.control.Label
        mzXMLLabel                      matlab.ui.control.Label
        mzXMLfilenameEditField          matlab.ui.control.EditField
        mzXMLfilenameEditFieldLabel     matlab.ui.control.Label
        AbortButton                     matlab.ui.control.Button
        OMGMSIHopefully10SoonPanel      matlab.ui.container.Panel
        PleaseinputavalidmatandmapfilenametostartprocessingLabel  matlab.ui.control.Label
        QuittoMenuButton                matlab.ui.control.Button
        NewMatButton                    matlab.ui.control.Button
        MapFileEditField                matlab.ui.control.EditField
        MapFileEditFieldLabel           matlab.ui.control.Label
        MatFileEditField                matlab.ui.control.EditField
        MatFileEditFieldLabel           matlab.ui.control.Label
    end


    properties (Access = private)
        valmin = 0; % Minimum M/z for 'Map from spectra'
        valmax = 2000; % Maximum M/z for 'Map from spectra'
    end


    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            % Variables initialisation

            path(path,'code/code_for_recording')

            path(path,'code/utils')
            path(path,'code/for_post_processing') % Tout mettre ici ou a chaque bouton ?

            global state; % Global variable that contains all the state of the system
            state.arret = 0; % security flag => the system will stop itself if state.stop_flag == 1 #TODO -> update new state names everywhere
            state.opo = 0; % laser connexion => if connected state.laser == 1
            state.etal = 0; % calibration state => if the calibration is done state.calibration == 1
            state.robot = 0;  % robot connexion => if connected state.robot == 1

            global old_name;
            old_name = "";

            global mzXML; % contain all data related to mass spectra
            mzXML.is_loaded = 0; % flag to know if there is any mass spectra data loaded

            %% Automatic workspace exemple #TODO
            Folder_path = './code/hardware/robot/*.m';
            OptionNameTab = folder_scan(Folder_path);
            app.RobotDropDown.Items = OptionNameTab(2:end); % On prend tous sauf le 1er pour eviter la Base

            Folder_path = './code/hardware/laser/*.m';
            OptionNameTab = folder_scan(Folder_path);
            app.LaserDropDown.Items = OptionNameTab(2:end);

            Folder_path = './code/hardware/sensor/*.m';
            OptionNameTab = folder_scan(Folder_path);
            app.SensorDropDown.Items = OptionNameTab;

            Folder_path = './code/method/scan_selection/*.m';
            OptionNameTab = folder_scan(Folder_path);
            app.ScanSelectionMethodDropDown.Items = OptionNameTab;   %(2:end);

            % CODE A DECOMMENTER POUR AJOUTER LA CORRECTION DE WORKSPACE
%             dest = '/home/pchaillo/Documents/prism'; % chemin en dur, à bien choisir avant de décommenter cette partie
%             cd(dest);
        end

        % Button pushed function: LaunchMappingButton
        function LaunchMappingButtonPushed(app, event)

            % main mapping
            path(path,'to add') % for developing only => shoould remove for release #TODO

            % add folders to workspace
            path(path,'map files')
            path(path,'code/code_for_mapping')
            path(path,'code/code_for_recording')

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
            nom_1 = app.GeneratedmapfileEditField.Value;
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
            scan.t_b = app.TimebetweenlaserburstssecondEditField.Value; % pause time between two laser shot, in second
            scan.nb_shot = app.NumberoflasershotsburstmodeEditField.Value; % number of shot for the burst mode
            %             biometrical_scanning = 1; % 0 only topographical / 1 total scanning % useless ? #TODO

            % Mapping Variable %
            scan.etal = 0.25; % pas d'étallonage => 0.25 mm recommandé / step of the camera calibration
            scan.pre = 2; % multiplier for the number of point in the map from the scanning : if scanning step=1mm then a factor of 1 will keep this resolution, a factor of two will create a map with point every 0.5mm

            laser.continuous_flag = app.ContinuousLaserCheckBox.Value; % 0 => no continuous / 1 => continuous

            seuil = 0; % used in record_map4 => useful ? #TODO

            scan.fast = app.FastmappingButton.Value; % I think it's a variable to not do repositionning if it's difficult to get height data from depth sensor

            ard = sensor.connexion; % connect the arduino for spectro triggering) 

            pos_i= [zone.dec  2  scan.dh 180 0 180]; % initial position
            robot.class.set_position(robot.connexion,pos_i);  % send the mapping initial position of the robot

            %% To select and launch the mapping code
            if app.DmassspectometryButton_2.Value %% For 3D imaging with Mass Spectrometry
                time_ref = trigger_spectro_time(ard);
                real_time_mapping_scanning_2(robot,sensor,laser,scan.t_b,scan.nb_shot,time_ref); % do the mapping step
            elseif app.OnlytopographicButton.Value %% For 3D acquisition only (without mass spectrometry)
                topographic_mapping(robot,sensor);
            elseif app.DmassspectometryButton.Value  %% For 2D imaging with Mass Spectrometry
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

            time_rec = record_map_time(carte.x,carte.y,carte.r,nom,seuil,carte.time);

            time_text = strcat('Map finished. Recommended reconstruction time : ',time_rec);
            app.NoMappingLabel.Text = time_text;

            % once the map is done, go back to the 1st point position
            pos_d_i= [zone.dec  2  scan.dh 180 0 180];
            robot.class.set_position(robot.connexion,pos_d_i);  % send the mapping initial position of the robot

            % hugh_to_sleep(t);

        end

        % Button pushed function: RobotConnexionB
        function RobotConnexionBButtonPushed(app, event)
            path(path,'code/code_for_mapping')
            path(path,'code/hardware/robot')
            global robot; % ou fermeture de la connexion

            robot.type = app.RobotDropDown.Value;

            robot.class = eval(robot.type);

            robot.connexion = robot.class.connect();
            app.StateLampRobot.Color = [0 1 0];
            app.LampOnlyTopo.Color = [0 1 0];

            global state;
            state.robot = 1 ;
            app.StateLampRobot.Color = [0 0 1];

            app.DisconnectButton.Enable = "on";
            app.XPositionEditField.Enable = "on";
            app.YPositionEditField.Enable = "on";
            app.ZPositionEditField.Enable = "on";
            app.GOTOButton.Enable = "on";

            app.RobotConnexionB.Enable = "off";
            app.NextButton_8.Enable = "on";
        end

        % Button pushed function: ConnectLaserButton
        function ConnectLaserButtonPushed(app, event)
            app.StateLampOpotek.Color = [0 0 1];
            path(path,'code/code_for_mapping')
            path(path,'code/hardware/laser')
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
            
            app.DisconnectButton.Enable = "on";
            app.GetTempButton.Enable = "on";
            app.TurnLampOnButton.Enable = "on";
            app.ConnectLaserButton.Enable = "off";
            app.LaserStateOffLabel.Text = "Laser State: On";
            app.LaserStateOffLabel.FontColor = [0.2 0.8 0.2];
        end

        % Button pushed function: LaunchSensorCalibrationButton
        function LaunchSensorCalibrationButtonPushed(app, event)
            app.SensorCalibrationstateLamp.Color = [0 0 1];

            path(path,'code/code_for_mapping')
            path(path,'code/for_acquisition')


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
                tab_e = sensor_calibration(robot,sensor); % calibration of the sensor (ILD1320-25)
                sensor.tab_etal = tab_continu(tab_e); % correction of the calibration ( delete false values )
            
                % Show the calibration graph
                figure()
                hold on
                for i = 1 : length(sensor.tab_etal)
                    scatter(sensor.tab_etal(1,i),sensor.tab_etal(2,i))
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
            app.SensorStateOffLabel.Text = "Sensor State: Calibrated";
            app.SensorStateOffLabel.FontColor = [0.2 0.8 0.2];
            end
        end

        % Button pushed function: LaunchBurstButton
        function LaunchBurstButtonPushed(app, event)
            path(path,'code/code_for_mapping')
            global laser;
            global scan;
            scan.nb_shot = app.NumberoflasershotsburstmodeEditField.Value; % number of shot for the burst mode

            laser.class.tir(laser.connexion,scan.nb_shot)

        end

        % Button pushed function: GotoPositionButton
        function GotoPositionButtonPushed(app, event)

            path(path,'code/code_for_mapping')
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
            robot.class.set_position(robot.connexion,pos_i);  % send the initial position to the robot

        end

        % Button pushed function: TurnLampOnButton
        function TurnLampOnButtonPushed(app, event)
            app.Lamp_LampONorOFF.Color = [0 0 1];
            path(path,'code/code_for_mapping')
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
            
            app.TurnLampOffButton.Enable = "on";
            app.GetStateButton.Enable = "on";
            app.MicroprobefocaldistanceinZaxismmEditField.Enable = "on";
            app.EnergylevelVSpinner.Enable = "on";
            app.LaserStateOffLabel.Text = "Laser State: Lamp Ready";
            app.LaserStateOffLabel.FontColor = [0.2 0.8 0.2]
        end

        % Button pushed function: TurnLampOffButton
        function TurnLampOffButtonPushed(app, event)
            path(path,'code/code_for_mapping')
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
            app.LaserStateOffLabel.Text = "Laser State: On";
            app.LaserStateOffLabel.FontColor = [0.8 0.3 0];
        end

        % Button pushed function: DisconnectRobotButton
        function DisconnectRobotButtonPushed(app, event)
            app.RobotConnexionB.Enable = "on";
            app.XPositionEditField.Enable = "off";
            app.YPositionEditField.Enable = "off";
            app.ZPositionEditField.Enable = "off";
            app.GOTOButton.Enable = "off";
            
            path(path,'code/code_for_mapping')
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
            
            app.DisconnectButton.Enable = "off";
            app.LaserStateOffLabel = "Disconnected";
        end

        % Button pushed function: DisconnectButton
        function DisconnectButtonPushed(app, event)
            global laser; 
            laser.class.disconnect(laser.connexion);
            app.StateLampOpotek.Color = [1 0 0];
            app.LaserStateOffLabel.Text = "Laser State: Off";
            app.LaserStateOffLabel.Color = [1 0 0];
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
            scan.fast = app.FastmappingButton.Value;
        end

        % Close request function: UIFigure
        function UIFigureCloseRequest(app, event)
            %% deconnecte le robot
            path(path,'code/code_for_mapping')
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

        % Button pushed function: LaunchPreprocessingButton
        function LaunchPreprocessingButtonPushed(app, event)
            path(path,'code/code_for_preprocessing')
            path(path,'code/code_for_recording')

            global mzXML;
            bio_dat = mzXML.bio_dat;

            win = app.BiningwindowsizeEditField.Value;

            mat_r = app.GeneratedmatfileEditField.Value;
            check_isempty(mat_r,'.mat')
            nom = strcat(mat_r,'.mat');

            l = length(bio_dat);

            fprintf('(%s) - Preprocessing data \n', datestr(now,'HH:MM:SS'));
            for i = 1 : l
                bio_dat2(i) = preprocess6(bio_dat(i),win);
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

            bio_dat = bio_dat2;

            bio_dat(1).comment = [threshold_begin, min_threshold, t_b,tolerance,intern_flag ]; % to stock the parameters somewhere with the data

            save('bio_dat.mat', 'bio_dat')
            folder_name = 'mat files';
            chemin  = choix_chemin(folder_name,nom);
            movefile('bio_dat.mat',chemin);
            app.MatFileEditField.Value = mat_r;
        end

        % Value changed function: MasslimitsMinimumEditField
        function MasslimitsMinimumEditFieldValueChanged(app, event)
            limits = app.MasslimitsMinimumEditField.Value;
            nom_map = app.MapfileEditField.Value;

            limi = round(limits(1));
            mass_str = num2str(limi);
            nom = strcat( nom_map,'_',mass_str);%,'.biomap');

            dec = 0.25; % ussual difference between the mass limits

            app.MaximumEditField.Value = limits + 0.25;
            app.BiomapOutputEditField.Value = nom;
        end

        % Button pushed function: LaunchReconstructionButton
        function LaunchReconstructionButtonPushed(app, event)

            path(path,'to add') % #TODO
            path(path,'map files')
            path(path,'mat files')
            %path(path,'code')
            path(path,'code/code_for_recording')
            path(path,'code/code_for_reconstruction')

            nom_mat_r = app.MatfileEditField.Value;
            nom_mat = strcat(nom_mat_r,'.mat');
            load(nom_mat);

            nom_map_r = app.MapfileEditField.Value;
            nom_map = strcat(nom_map_r,'.map');
            carte = load_map_fcn(nom_map);

            nom_r = app.BiomapOutputEditField.Value;
            nom = strcat(nom_r,'.biomap');

            % seuil = 6; % if the threshold is recorded in the map
            seuil = -1; % #TODO

            l_min = app.MasslimitsMinimumEditField.Value;
            l_max = app.MaximumEditField.Value;
            limits = [l_min l_max];

            clearvars carte_x % to delete any man that would stay in the memory
            clearvars carte_y
            clearvars carte_z

            carte_x = carte.x;
            carte_y = carte.y;
            carte_z = carte.z;
            if isfield(carte,'time')
                carte_time = carte.time;
            end

            fprintf('(%s) - The map file is loaded \n', datestr(now,'HH:MM:SS'));
            fprintf('(%s) - Starting to build the intensity matrix\n', datestr(now,'HH:MM:SS'));

            loud_data = app.LouddataonthemapSwitch.Value;
            if loud_data(1:2) == 'On'
                loud_flag = 1;
                % [bio_dat ,time,g] = peak_detection8_internal(mzXMLStruct,threshold_begin,t_b,min_threshold); % take only the usefull informations
            else
                loud_flag = 0;
                % [bio_dat ,time,g] = peak_detection8(mzXMLStruct,threshold_begin,t_b,min_threshold); % take only the usefull informations
            end

            if isfield(carte,'time')
                % [ bio_ind ,bio_map ] = mzXML_on_map_norm12(bio_dat,carte_z,limits,carte_time); % put the information on the map
                time_flag = 1;
            else
                % [ bio_ind ,bio_map ] = mzXML_on_map_norm8_4(bio_dat,carte_z,limits,seuil); % put the information on the map
                time_flag = 0;
                carte_time = 0;
            end

            [ bio_ind, bio_num, bio_map, deiso_tab] = mzXML_on_map_norm17(bio_dat,carte_z,limits,carte_time,time_flag,loud_flag);
            %[ bio_ind ,bio_map ] = mzXML_on_map_norm14(bio_dat,carte_z,limits,carte_time,time_flag); % put the information on the map

            %   bio_ind_debug(bio_ind,bio_map,bio_dat);

            [ carte_x,carte_y,carte_z,bio_map  ] = fix_border_2(carte_x,carte_y,carte_z,bio_map,bio_ind);

            fprintf('(%s) - Done, displaying the image\n', datestr(now,'HH:MM:SS'));
            figure()
            s = surf(carte_x,carte_y,carte_z,bio_map);
            s.FaceAlpha = 0.9; % niveau de transparence
            s.FaceColor = 'flat'; % set color interpolation or not
            s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
            axis equal
            title(['biometric map, mass limits : ', num2str(limits(1)),'  ',num2str(limits(2))]);

            record_BIOmap2(carte_x,carte_y,carte_z,bio_map,nom,limits)
        end

        % Button pushed function: LaunchTimeEstimationButton
        function LaunchTimeEstimationButtonPushed(app, event)

            global mzXML;

            path(path,'to add')

            path(path,'mzXML files')
            path(path,'code/code_for_preprocessing')
            path(path,'code/code_for_recording')

            %             fprintf('(%s) - Loading the mzXML file\n', datestr(now,'HH:MM:SS'));
            %             mzxml_r = app.mzXMLfilenameEditField.Value;
            %             nom_mzxml = strcat(mzxml_r,'.mzXML');
            %             mzXMLStruct = mzxmlread(nom_mzxml);

            threshold_begin = app.BeginThresholdEditField.Value;
            t_b = app.Timebetween2lasershotsecondEditField.Value;
            min_threshold = app.LoudthresholdEditField.Value;

            fprintf('(%s) - Filtering the mzXML file to keep only the image related spectra\n', datestr(now,'HH:MM:SS'));
            %             [bio_dat ,time,g] = load_mzXML_p4(mzXMLStruct,threshold_begin,t_b); % take only the usefull informations
            time = time_from_peaks3(mzXML.Struct,threshold_begin,min_threshold); % take only the usefull informations

            time_str = num2str(time);
            time_str2 = strcat(time_str, ' seconds');
            app.TimeValue.Text = time_str2;

        end

        % Button pushed function: ExtractOneSpectrumButton
        function ExtractOneSpectrumButtonPushed(app, event)
            path(path,'map files')
            path(path,'mat files')
            %path(path,'code')
            path(path,'code/code_for_recording')
            path(path,'code/code_for_reconstruction')
            path(path,'to add')

            nom_mat_r = app.MatfileEditField.Value;
            nom_mat = strcat(nom_mat_r,'.mat');
            load(nom_mat)

            nom_map_r = app.MapfileEditField.Value;
            nom_map = strcat(nom_map_r,'.map');
            %out = load(nom_map); % load topographical map. Remove any dot in the file name
            carte = load_map_fcn(nom_map);

%             nom_r = app.BiomapOutputEditField.Value; %  intuile ? % TODO ?
%             nom = strcat(nom_r,'.biomap');

            % seuil = 6; % if the threshold is recorded in the map
            seuil = -1;

            l_min = app.MasslimitsMinimumEditField.Value;
            l_max = app.MaximumEditField.Value;

            limits = [l_min l_max];

            %             nom = 'slice_breastcancer.map';
            %             carte = load_map4_fcn(nom);
            %
            %             load('slice_breastcancer02.mat');
            %
            %             limits = [885 886];

            extract_one_spectra(bio_dat,carte,limits)
        end

        % Button pushed function: ExtractSpectraZoneButton
        function ExtractSpectraZoneButtonPushed(app, event)
            path(path,'map files')
            path(path,'mat files')
            %path(path,'code')
            path(path,'code/code_for_recording')
            path(path,'code/code_for_analysing')
            path(path,'code/code_for_reconstruction')
            path(path,'code/code_for_reconstruction/old reconstruction code')
            path(path,'to add')

            nom_mat_r = app.MatFileEditField.Value; % creer une routine de chargement des donnees ? => factoriser aussi pour n'avoir que 3 lignes de chargement ici ? fonction load and load ma
            check_isempty(nom_mat_r,'.mat')
            nom_mat = strcat(nom_mat_r,'.mat');
            load(nom_mat)

            nom_map_r = app.MapfileEditField.Value;
            check_isempty(nom_map_r,'.map')
            nom_map = strcat(nom_map_r,'.map');
            %out = load(nom_map); % load topographical map. Remove any dot in the file name
            carte = load_map_fcn(nom_map);
            
%             nom_r = app.BiomapOutputEditField.Value; %    inutile ? %TODO ?       
%             check_isempty(nom_r,'.biomap you want to edit')
%             nom = strcat(nom_r,'.biomap');

            % seuil = 6; % if the threshold is recorded in the map
            seuil = -1;

            l_min = app.MasslimitsMinimumEditField.Value;
            l_max = app.MaximumEditField.Value;

            limits = [l_min l_max];

            extract_spectra_zone3(bio_dat,carte,limits)

        end

        % Button pushed function: PlotChromatogramButton
        function PlotChromatogramButtonPushed(app, event)
            path(path,'to add')

            global mzXML;

            path(path,'mzXML files')
            path(path,'code/code_for_preprocessing')
            path(path,'code/code_for_recording')

            %             fprintf('(%s) - Loading the mzXML file\n', datestr(now,'HH:MM:SS'));
            %             mzxml_r = app.mzXMLfilenameEditField.Value;
            %             nom_mzxml = strcat(mzxml_r,'.mzXML');
            %             mzXMLStruct = mzxmlread(nom_mzxml);

            if mzXML.is_loaded == 1
                figure()
                plot_chromatogram(mzXML.Struct)
            else
                disp("There is no Mass Spectra file loaded : Impossible to plot chromatogram") % ERROR_MESSAGE
            end
        end

        % Value changed function: MappingStepmmEditField
        function MappingStepmmEditFieldValueChanged(app, event)
            path(path,'code/code_for_mapping')

            size_x = app.ZonesizeXaxismmEditField.Value;
            step_size = app.MappingStepmmEditField.Value;
            size_y = app.ZonesizeYaxismmEditField.Value;
            nb_shot = app.NumberoflasershotsburstmodeEditField.Value;
            t_b = app.TimebetweenlaserburstssecondEditField.Value;

            [mapping_time_min, mapping_time_sec] = mapping_time_estimation(size_x,size_y,t_b,step_size,nb_shot);

            mapping_time_text = strcat('Estimation of mapping time :',32, num2str(mapping_time_min), ' min ',32,num2str(mapping_time_sec), '  sec ');
            app.EstimationofmappingtimeLabel.Text = mapping_time_text;
            app.ETALabel.Text = mapping_time_text;
            app.Resolutionm500Label.Text = strcat('Resolution(µm): ', num2str(step_size*1000));
        end

        % Value changed function: ZonesizeXaxismmEditField
        function ZonesizeXaxismmEditFieldValueChanged(app, event)
            path(path,'code/code_for_mapping')
            
            size_x = app.ZonesizeXaxismmEditField.Value;
            step_size = app.MappingStepmmEditField.Value;
            size_y = app.ZonesizeYaxismmEditField.Value;
            nb_shot = app.NumberoflasershotsburstmodeEditField.Value;
            t_b = app.TimebetweenlaserburstssecondEditField.Value;

            [mapping_time_min, mapping_time_sec] = mapping_time_estimation(size_x,size_y,t_b,step_size,nb_shot);

            mapping_time_text = strcat('Estimation of mapping time :',32, num2str(mapping_time_min), ' min ',32,num2str(mapping_time_sec), '  sec ');
            app.XLabel.Text = strcat("X: ", num2str(size_x));
            app.EstimationofmappingtimeLabel.Text = mapping_time_text;
            app.ETALabel.Text = mapping_time_text;
        end

        % Value changed function: ZonesizeYaxismmEditField
        function ZonesizeYaxismmEditFieldValueChanged(app, event)
            path(path,'code/code_for_mapping')


            size_x = app.ZonesizeXaxismmEditField.Value;
            step_size = app.MappingStepmmEditField.Value;
            size_y = app.ZonesizeYaxismmEditField.Value;
            nb_shot = app.NumberoflasershotsburstmodeEditField.Value;
            t_b = app.TimebetweenlaserburstssecondEditField.Value;

            [mapping_time_min, mapping_time_sec] = mapping_time_estimation(size_x,size_y,t_b,step_size,nb_shot);

            mapping_time_text = strcat('Estimation of mapping time :',32, num2str(mapping_time_min), ' min ',32,num2str(mapping_time_sec), '  sec ');
            app.YLabel.Text = strcat("Y: ", num2str(size_y));
            app.EstimationofmappingtimeLabel.Text = mapping_time_text;
            app.ETALabel.Text = mapping_time_text;
        end

        % Value changed function: TimebetweenlaserburstssecondEditField
        function TimebetweenlaserburstssecondEditFieldValueChanged(app, event)
            path(path,'code/code_for_mapping')


            size_x = app.ZonesizeXaxismmEditField.Value;
            step_size = app.MappingStepmmEditField.Value;
            size_y = app.ZonesizeYaxismmEditField.Value;
            nb_shot = app.NumberoflasershotsburstmodeEditField.Value;
            t_b = app.TimebetweenlaserburstssecondEditField.Value;

            [mapping_time_min, mapping_time_sec] = mapping_time_estimation(size_x,size_y,t_b,step_size,nb_shot);

            mapping_time_text = strcat('Estimation of mapping time :',32, num2str(mapping_time_min), ' min ',32,num2str(mapping_time_sec), '  sec ');
            app.EstimationofmappingtimeLabel.Text = mapping_time_text;
        end

        % Value changed function: NumberoflasershotsburstmodeEditField
        function NumberoflasershotsburstmodeEditFieldValueChanged(app, event)
            path(path,'code/code_for_mapping')


            size_x = app.ZonesizeXaxismmEditField.Value;
            step_size = app.MappingStepmmEditField.Value;
            size_y = app.ZonesizeYaxismmEditField.Value;
            nb_shot = app.NumberoflasershotsburstmodeEditField.Value;
            t_b = app.TimebetweenlaserburstssecondEditField.Value;

            [mapping_time_min, mapping_time_sec] = mapping_time_estimation(size_x,size_y,t_b,step_size,nb_shot);

            mapping_time_text = strcat('Estimation of mapping time :',32, num2str(mapping_time_min), ' min ',32,num2str(mapping_time_sec), '  sec ');
            app.EstimationofmappingtimeLabel.Text = mapping_time_text;
        end

        % Button pushed function: MapFromSpectraButton
        function MapFromSpectraButtonPushed(app, event)
            path(path,'code/code_for_preprocessing')
            path(path,'code/code_for_recording')
            path(path,'code/code_for_reconstruction')
            path(path,'code/for_display')
            path(path,'code/for_image_building')

            path(path,'mat files')
            path(path,'map files')

            path(path,'to add')

            valmin = app.MinEditField.Value;
            valmax = app.MaxEditField.Value;

            disp([valmin,valmax])

            global all_peaks;
            global old_name;

            nom_mat_r = app.MatFileEditField.Value;
            nom_mat = strcat(nom_mat_r,'.mat');
            load(nom_mat) % génère la variable bio_dat

            nom_map_r = app.MapfileEditField.Value;
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

            all_peaks = plot_all_spectra(bio_dat,compute_flag,all_peaks,valmin,valmax);
            map_from_spectra(bio_dat,carte);

            old_name = nom_mat_r;
        end

        % Button pushed function: LaunchRectificationButton
        function LaunchRectificationButtonPushed(app, event)
            path(path,'map files')
            path(path,'code/code_for_reconstruction')
            path(path,'code/code_for_analysing')
            path(path,'code/code_for_recording')

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

            [corrected_map_height, nb_err]= map_rectification(map_height,min_threshold,max_threshold);

            map_out = click_loop_multi(map,corrected_map_height,min_threshold,max_threshold);

            threshold = 0;

            if isfield(map,'time')
                time_diff_med = record_map(map.x,map.y,map_out,nom_map_new,threshold,map.time);
            else
                record_map_without_time(map.x,map.y,map_out,nom_map_new,threshold);
            end

            %     close all; % fermer au fur et à mesure plutot
        end

        % Button pushed function: LaunchInterpolationButton
        function LaunchInterpolationButtonPushed(app, event)
            path(path,'map files')
            path(path,'code/code_for_analysing')
            path(path,'code/code_for_recording')

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
            path(path,'map files')
            path(path,'code/code_for_analysing')
            path(path,'code/code_for_recording')
            path(path,'to add')


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

        % Button pushed function: LaunchLDAReconstructionButton
        function LaunchLDAReconstructionButtonPushed(app, event)
            path(path,'code/code_for_reconstruction')
            path(path,'code/code_for_recording')
            path(path,'to add')
            path(path,'map files')
            path(path,'mat files')
            path(path,'csv files')

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

            if isempty(class) == 0

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

                [ bio_ind, bio_num, bio_map , deiso_tab] = mzXML_on_map_norm16(bio_dat,carte.z,limits,carte_time,time_flag);
            %  [ bio_ind, bio_num, bio_map ] = mzXML_on_map_norm15(bio_dat,carte.z,limits,carte_time,time_flag);

                si = size(carte.z);
                bio_map_class = zeros(si(1),si(2),3);

                back_color = app.BackgroundColorDropDown.Value;
                if back_color == "White"
                    bio_map_class(:,:,:) = 1;
                elseif back_color == "Grey"
                    bio_map_class(:,:,:) = 0.5;
                end

                bio_map_class = bio_class_builder3(scan,bio_num,class,color,deiso_tab,bio_ind,bio_map_class);

            % bio_map_class = bio_class_builder(scan,bio_num,class,color,deiso_tab,bio_ind);

            %             for i = 1 : length(scan.num)
            %                 [x_i y_i] = find(scan.num(i) == bio_num);
            %                 if ~isempty(x_i)
            %                     c_ind = find(string(scan.class(i)) == class);
            %                     bio_map_class(x_i,y_i,:) = color(c_ind,:);
            %                 end
            %             end

                [ carte.x,carte.y,carte.z,bio_map_class  ] = fix_border_3(carte.x,carte.y,carte.z,bio_map_class,bio_ind);

                fprintf('(%s) - Done, displaying the image\n', datestr(now,'HH:MM:SS'));
                figure()
                s = surf(carte.x,carte.y,carte.z,bio_map_class);
                s.FaceAlpha = 0.9; % niveau de transparence
                s.FaceColor = 'flat'; % set color interpolation or not
                s.EdgeColor = 'none'; %'none' disable lines, you can also choose the color : 'white', etc.
                axis equal
                title('Biometric Class Map');
                legend(class);
            else
                msgbox("Please name at least one class to perform LDA.")
            end
        end

        % Button pushed function: LoadmzXMLButton
        function LoadmzXMLButtonPushed(app, event)
            path(path,'mzXML files')

            disp("Loading of mzXML file in progress...")

            global mzXML

            mzxml_r = app.mzXMLfilenameEditField.Value;
            nom_mzxml = strcat(mzxml_r,'.mzXML');
            mzXML.Struct = mzxmlread(nom_mzxml);

            mzXML.is_loaded = 1;

            disp("Loading of mzXML file finished !")
            
            app.LaunchTimeEstimationButton.Enable = "on";
            app.PlotChromatogramButton.Enable = "on";
            app.MapfilenameEditField_2.Enable = "on";

        end

        % Button pushed function: LaunchExtractionButton
        function LaunchExtractionButtonPushed(app, event)
            path(path,'mat files')
            path(path,'code/code_for_recording')

            nom_mat_r = app.InputMatFileEditField_scils.Value;
            nom_mat = strcat(nom_mat_r,'.mat');
            load(nom_mat);

            nom_txt_r = app.OutputtextfileEditField.Value;
            nom_txt = strcat(nom_txt_r,'.txt');

            folder_name = 'txt files';

            nom  = choix_chemin(folder_name,nom_txt)

            fid = fopen(nom,'wt');
            fprintf(fid, 'mzML=true\n');
            fprintf(fid, 'zlib=false\n');
            fprintf(fid, 'filter="scanNumber');

            l = length(bio_dat);

            for i = 1 : l
                num = abs(bio_dat(i).num);
                fprintf(fid,' [%d,%d]',num,num);
            end
            fprintf(fid,'"');

            fclose(fid);

        end

        % Button pushed function: ExportrawBioMapButton
        function ExportrawBioMapButtonPushed(app, event)
            path(path,'code/code_python')
            pyrunfile('3-PLY-Converter.py')
        end

        % Button pushed function: ExportandcoregisterBiomapButton
        function ExportandcoregisterBiomapButtonPushed(app, event)
            path(path, 'code/code_python')
            pyrunfile('1-Biomap_to_PNG.py')
            pyrunfile('2-Picture_Manual_Registration.py')
            pyrunfile('3-PLY-Converter.py')
        end

        % Button pushed function: STOPCONTINUOUSLASERButton_2
        function STOPCONTINUOUSLASERButton_2Pushed(app, event)
            global laser;

            laser.class.tir_continu_OFF(laser.connexion);
        end

        % Button pushed function: ScanSelectionButton
        function ScanSelectionButtonPushed(app, event)

            global mzXML;

            path(path,'code/method/scan_selection')

            path(path,'to add')

            path(path,'mzXML files')
            path(path,'code/code_for_preprocessing')
            path(path,'code/code_for_recording')
            path(path,'code/for_display')


                

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
            
            if isfield(mzXML,'Struct')
                if strcmp(method.type, 'TimeBasedMethod') == 1
                    offset = app.AspirationTimesEditField.Value;
                    [bio_dat, time, g] =  method.class.selection(mzXML.Struct, carte_time, offset); % take only the useful information
                else
                    [bio_dat, time, g] =  method.class.selection(mzXML.Struct, carte_time);
                end
            else
                disp("Attention : no mzXML file loaded = Impossible to do scan selection")
            end

            mzXML.bio_dat = bio_dat;
            
            app.GeneratedmatfileEditField.Enable = "on";    
        end

        % Button pushed function: ExporttoCSVButton
        function ExporttoCSVButtonPushed(app, event)
            % path(path, "code/")
            path(path, "code/utils")

            mz_min = app.MinMzEditField.Value;
            mz_max = app.MaxMzEditField.Value;
            band = [mz_min, mz_max];

            win = app.BinningEditField.Value;
            map = strcat(app.InputmapfileEditField.Value, '.map');

            mat = strcat(app.InputmatfileEditField.Value, '.mat');
            
            csv_extractor(map, mat, band, win)
        end

        % Button pushed function: NormalizeCSVTICButton
        function NormalizeCSVTICButtonPushed(app, event)
            path(path, 'code/code_python')
            pyrunfile('CSV_TIC_norm.py')
        end

        % Button pushed function: ExportrawCSVButton
        function ExportrawCSVButtonPushed(app, event)
            path(path, 'code/code_python')
            pyrunfile('CSV_to_PLY.py')
        end

        % Button pushed function: ExportandcoregisterCSVButton
        function ExportandcoregisterCSVButtonPushed(app, event)
            path(path, 'code/code_python')
            pyrunfile('CSV_to_PNG.py')
            pyrunfile('2-Picture_Manual_Registration.py')
            pyrunfile('CSV_to_PLY.py')
        end

        % Button pushed function: ConnectSensorButton
        function ConnectSensorButtonPushed(app, event)
            disp("Sensor Connexion... ")
            
            % app.StateLampRobot.Color = [0 0 1];
            path(path,'code/hardware/sensor')
            global sensor; % ou fermeture de la connexion

            sensor.type = app.SensorDropDown.Value;

            sensor.class = eval(sensor.type);

            sensor.connexion = sensor.class.connect();
            % app.StateLampRobot.Color = [0 1 0]; % ajouter 2e LED pour
            % sensor ?

%             global state;
%             state.robot = 1 ;

            disp("Sensor Connected ")

            app.LaunchSensorCalibrationButton.Enable = "on";
            app.SensorStateOffLabel.Text = "Sensor State: Connected";
            app.SensorStateOffLabel.FontColor = [1 0 0];
        end

        % Value changed function: ScanSelectionMethodDropDown
        function ScanSelectionMethodDropDownValueChanged(app, event)
             value = app.ScanSelectionMethodDropDown.Value;
             if strcmp(value, "TimeBasedMethod") == 1 % Direct comparison of strings cannot be done
                 app.BeginThresholdEditField.BackgroundColor = [0.5 0.5 0.5];
                 app.BeginThresholdEditField.Editable = "off";
                 app.Timebetween2lasershotsecondEditField.BackgroundColor = [0.5 0.5 0.5];
                 app.Timebetween2lasershotsecondEditField.Editable = "off";
                 app.LoudthresholdEditField.BackgroundColor = [0.5 0.5 0.5];
                 app.LoudthresholdEditField.Editable = "off";
                 app.AspirationTimesEditField.BackgroundColor = [1 1 1];
                 app.AspirationTimesEditField.Editable = "on";
             elseif strcmp(value, "PeakPickingMethod") == 1
                 app.BeginThresholdEditField.BackgroundColor = [1 1 1];
                 app.BeginThresholdEditField.Editable = "on";
                 app.Timebetween2lasershotsecondEditField.BackgroundColor = [1 1 1];
                 app.Timebetween2lasershotsecondEditField.Editable = "on";
                 app.LoudthresholdEditField.BackgroundColor = [1 1 1];
                 app.LoudthresholdEditField.Editable = "on";
                 app.AspirationTimesEditField.BackgroundColor = [0.5 0.5 0.5];
                 app.AspirationTimesEditField.Editable = "off";
             end
        end

        % Value changed function: MatFileEditField
        function MatFileEditFieldValueChanged(app, event)
%             DEVNOTE: REPLACE WITH FILE SELECTION THROUGH POPUP, SAME GOES
%             FOR MAP FILES
            mat_name = app.MatFileEditField.Value;
            app.MapFileEditField.Value = mat_name; % Note: This means that 
            % the Map field can never be empty if the mat field isn't 

            if isempty(mat_name) == 0 && isempty(app.MapFileEditField.Value) == 0
              app.PleaseinputavalidmatandmapfilenametostartprocessingLabel.Text = 'All set!';
              app.PleaseinputavalidmatandmapfilenametostartprocessingLabel.FontColor = [0.2 0.8 0.2];

%             Enable Processing Tab
              app.MasslimitsMinimumEditField.Enable = 'on';
              app.MaximumEditField.Enable = "on";
              app.LouddataonthemapSwitch.Enable = "on";
              app.BiomapOutputEditField.Enable = "on";
              
              if isempty(app.BiomapOutputEditField.Value) == 0
                app.LaunchReconstructionButton.Enable = "on"; % Triggered
%               by filling in the biomap name
              else
                app.LaunchReconstructionButton.Enable = "off";
              end

              app.ExtractOneSpectrumButton.Enable = "on";
              app.ExtractSpectraZoneButton.Enable = "on";
              app.MinEditField.Enable = "on";
              app.MaxEditField.Enable = "on";
              app.MapFromSpectraButton.Enable = "on";
%             Enable Post-Processing Tab 
              app.NameofthecorrectedmapEditField.Enable = "on";
              app.MinimumthresholdmmEditField.Enable = "on";
              app.MaximumthresholdmmEditField.Enable = 'on';
%               app.LaunchRectificationButton.Enable = "off";  Triggered by
%               filling in the name of the corrected map 
              app.NameoftheinterpolatedmapEditField.Enable = "on";

%             The Display from external data tab is unaffected
%             Enable Scils Extraction (Data Extraction) Tab
              app.OutputtextfileEditField.Enable = "on";
%               app.LaunchExtractionButton.Enable = "off"; Controlled
%               internally
              app.MinMzEditField.Enable = "on";
              app.MaxMzEditField.Enable = "on";
              app.BinningEditField.Enable = "on";
              app.ExporttoCSVButton.Enable = "on";

            else
%             Since the Map text box is currently slaved to the Mat text
%             box, there is no need to account for only one of those two
%             being empty in this callback. This may change later on. 
              app.PleaseinputavalidmatandmapfilenametostartprocessingLabel.Text = "Please input a valid mat and map file name to start processing!";
              app.PleaseinputavalidmatandmapfilenametostartprocessingLabel.FontColor = [1 0 0]; 
%             Disable Post-Processing Tab
              app.NameofthecorrectedmapEditField.Enable = "off";
              app.MinimumthresholdmmEditField.Enable = "off";
              app.MaximumthresholdmmEditField.Enable = "off";
              app.LaunchRectificationButton.Enable = "off";
              app.NameoftheinterpolatedmapEditField.Enable = "off";
              app.PointMultiplierEditField.Enable = "off";
              app.LaunchInterpolationButton.Enable = "off";
%             Disable Processing Tab
              app.MasslimitsMinimumEditField.Enable = 'off';
              app.MaximumEditField.Enable = "off";
              app.LouddataonthemapSwitch.Enable = "off";
              app.BiomapOutputEditField.Enable = "off";
              app.LaunchReconstructionButton.Enable = "off";
              app.ExtractOneSpectrumButton.Enable = "off";
              app.ExtractSpectraZoneButton.Enable = "off";
              app.MinEditField.Enable = "off";
              app.MaxEditField.Enable = "off";
              app.MapFromSpectraButton.Enable = "off";
%             Disable Scils Extraction (Data Extraction) Tab
              app.OutputtextfileEditField.Enable = "off";
              app.LaunchExtractionButton.Enable = "off";
              app.MinMzEditField.Enable = "off";
              app.MaxMzEditField.Enable = "off";
              app.BinningEditField.Enable = "off";
              app.ExporttoCSVButton.Enable = "off";

            end
        end

        % Value changed function: MapFileEditField
        function MapFileEditFieldValueChanged(app, event)
            map_name = app.MapFileEditField.Value;
            if isempty(map_name) == 0
                if isempty(app.MatFileEditField.Value) == 1
                    app.PleaseinputavalidmatandmapfilenametostartprocessingLabel.Text = 'No Mat file selected. Reduced interface functionnality.';
                    app.PleaseinputavalidmatandmapfilenametostartprocessingLabel.FontColor = [1.00 0.41 0.16];
                else
                    app.PleaseinputavalidmatandmapfilenametostartprocessingLabel.Text = 'All set!';
                    app.PleaseinputavalidmatandmapfilenametostartprocessingLabel.FontColor = [0.2 0.8 0.2];
%                   Enable Processing Tab
                    app.MasslimitsMinimumEditField.Enable = 'on';
                    app.MaximumEditField.Enable = "on";
                    app.LouddataonthemapSwitch.Enable = "on";
                    app.BiomapOutputEditField.Enable = "on";
%                   app.LaunchReconstructionButton.Enable = "off";  Handled
%                   internally
                    app.ExtractOneSpectrumButton.Enable = "on";
                    app.ExtractSpectraZoneButton.Enable = "on";
                    app.MinEditField.Enable = "on";
                    app.MaxEditField.Enable = "on";
                    app.MapFromSpectraButton.Enable = "on";

%                   Enable Scils Extraction (Data Extraction) Tab
                    app.OutputtextfileEditField.Enable = "on";
%                   app.LaunchExtractionButton.Enable = "off";  Handled
%                   internally
                    app.MinMzEditField.Enable = "on";
                    app.MaxMzEditField.Enable = "on";
                    app.BinningEditField.Enable = "on";
                    app.ExporttoCSVButton.Enable = "on";
                end 
%               Activate Post-Processing Tab 
                app.NameofthecorrectedmapEditField.Enable = "on";
%               app.MinimumthresholdmmEditField.Enable = "off";
%               app.MaximumthresholdmmEditField.Enable = 'off';
%               app.LaunchRectificationButton.Enable = "off";
                app.NameoftheinterpolatedmapEditField.Enable = "on";
            else
              if isempty(app.MatFileEditField.Value) == 0
                  app.PleaseinputavalidmatandmapfilenametostartprocessingLabel.Text = 'No Map file selected. Reduced interface functionnality.';
                  app.PleaseinputavalidmatandmapfilenametostartprocessingLabel.FontColor = [1.00 0.41 0.16];
              else 
                  app.PleaseinputavalidmatandmapfilenametostartprocessingLabel.Text = "Please input a valid mat and map file name to start processing!";
                  app.PleaseinputavalidmatandmapfilenametostartprocessingLabel.FontColor = [1 0 0];
              end
%             Disable Processing Tab
              app.MasslimitsMinimumEditField.Enable = 'off';
              app.MaximumEditField.Enable = "off";
              app.LouddataonthemapSwitch.Enable = "off";
              app.BiomapOutputEditField.Enable = "off";
              app.LaunchReconstructionButton.Enable = "off";
              app.ExtractOneSpectrumButton.Enable = "off";
              app.ExtractSpectraZoneButton.Enable = "off";
              app.MinEditField.Enable = "off";
              app.MaxEditField.Enable = "off";
              app.MapFromSpectraButton.Enable = "off";
%             Disable Post-Processing Tab
              app.MinimumthresholdmmEditField.Enable = "off";
              app.MaximumthresholdmmEditField.Enable = 'off';
              app.LaunchRectificationButton.Enable = "off";
              app.PointMultiplierEditField.Enable = "off";
              app.NameofthecorrectedmapEditField.Enable = "off";
              app.NameoftheinterpolatedmapEditField.Enable = "off";
%             Disable Scils Extraction (Data Extraction) Tab
              app.OutputtextfileEditField.Enable = "off";
%               app.LaunchExtractionButton.Enable = "off";
              app.MinMzEditField.Enable = "off";
              app.MaxMzEditField.Enable = "off";
              app.BinningEditField.Enable = "off";
              app.ExporttoCSVButton.Enable = "off";
           end    
            
                                 
            limits = app.MasslimitsMinimumEditField.Value;

            limi = round(limits(1));
            mass_str = num2str(limi);
            name = strcat(map_name,'_',mass_str);%,'.biomap');

            app.BiomapOutputEditField.Value = name;
        end

        % Value changed function: GeneratedmatfileEditField
        function GeneratedmatfileEditFieldValueChanged(app, event)
            value = app.GeneratedmatfileEditField.Value;
            app.MatFileEditField.Value = value;

            if isempty(value) == 0
                app.BiningwindowsizeEditField.Enable = "on";
                app.LaunchPreprocessingButton.Enable = "on";
            else
                app.BiningwindowsizeEditField.Enable = "off";
                app.LaunchPreprocessingButton.Enable = "off";
            end
        end

        % Button pushed function: NewMatButton
        function NewMatButtonPushed(app, event)
% Causes janky window behaviour. This is probably because Matlab had the 
% brilliant idea to define positions from the bottom left corner, which 
% means we have to take the width and height into account to define a 
% position. Since this was overlooked when coding the interface, the 
% canvas seems to play catchup to the windows it is supposed to house. 
% Great design all around...            
            app.TabGroup.Visible = "off";
%             app.TabGroup.Position = [-1,-28,603,856];
            app.OMGMSIHopefully10SoonPanel.Visible = "off";
%             app.OMGMSIHopefully10SoonPanel.Position = [-1,829,603,54];
            app.UIFigure.Position = [100,100,603,500];
            app.OMGMSINewmatfilePanel.Position = [0,100,603,500];
            app.OMGMSINewmatfilePanel.Visible = "on";
        end

        % Button pushed function: AbortButton
        function AbortButtonPushed(app, event)
%             Borked, needs fixing
            app.OMGMSINewmatfilePanel.Visible = "off";
            app.UIFigure.Position = [100,100,603,667];
%             app.TabGroup.Position = [-1,-28,603,856];
%             app.OMGMSIHopefully10SoonPanel.Position = [100,100,603,667];
            app.TabGroup.Visible = "on";
            app.OMGMSIHopefully10SoonPanel.Visible = "on";
        end

        % Button pushed function: ProceedButton
        function ProceedButtonPushed(app, event)
            if app.DataprocessingButton.Value == 0
                % Morph app gui, enter data processing submenu
                app.OMGMSIChooseyourmodePanel.Visible = "off";
                app.UIFigure.Position = [100, 100, 606, 490];
                app.TabGroup2.Position = [0, 0, 606, 490];
                app.TabGroup2.Visible = "on";
            else
                app.OMGMSIChooseyourmodePanel.Visible = "off";
                app.UIFigure.Position = [100, 100, 603, 667];
                app.OMGMSIHopefully10SoonPanel.Position = [0, 0, 603, 667];
                app.TabGroup.Position = [0, 0, 603, 594];
                app.OMGMSIHopefully10SoonPanel.Visible = "on";
                app.TabGroup.Visible = "on";
            end

        end

        % Button pushed function: QuittoMenuButton_2
        function QuittoMenuButton_2Pushed(app, event)
            app.TabGroup2.Visible = "off";
            app.UIFigure.Position = [100,100,263,220];
            app.OMGMSIChooseyourmodePanel.Visible = "on";
        end

        % Button pushed function: QuittoMenuButton
        function QuittoMenuButtonPushed(app, event)
            app.TabGroup.Visible = "off";
            app.UIFigure.Position = [100,100,263,220];
            app.OMGMSIChooseyourmodePanel.Visible = "on";
        end

        % Button pushed function: NextButton_6
        function NextButton_6Pushed(app, event)
            app.TabGroup2.SelectedTab = app.AcquisitionPropertiesTab;
        end

        % Button pushed function: NextButton_7
        function NextButton_7Pushed(app, event)
            app.TabGroup2.SelectedTab = app.RobotTab;
        end

        % Button pushed function: NextButton_8
        function NextButton_8Pushed(app, event)
            app.TabGroup2.SelectedTab = app.SensorTab;
        end

        % Button pushed function: NextButton_9
        function NextButton_9Pushed(app, event)
            app.TabGroup2.SelectedTab = app.LaserTab;
        end

        % Button pushed function: NextButton_10
        function NextButton_10Pushed(app, event)
            app.TabGroup2.SelectedTab = app.RecapTab;
        end

        % Value changed function: BiomapOutputEditField
        function BiomapOutputEditFieldValueChanged(app, event)
            value = app.BiomapOutputEditField.Value;
            if isempty(value) == 0
                app.LaunchReconstructionButton.Enable = "on";
            else
                app.LaunchReconstructionButton.Enable = "off";
            end
        end

        % Value changed function: NameofthecorrectedmapEditField
        function NameofthecorrectedmapEditFieldValueChanged(app, event)
            value = app.NameofthecorrectedmapEditField.Value;
            if isempty(value) == 0
                app.MinimumthresholdmmEditField.Enable = "on";
                app.MaximumthresholdmmEditField.Enable = "on";
                app.LaunchRectificationButton.Enable = "on"; 
            else
                app.MinimumthresholdmmEditField.Enable = "off";
                app.MaximumthresholdmmEditField.Enable = "off";
                app.LaunchRectificationButton.Enable = "off";
                app.LaunchRectificationButton.Enable = "off";
            end
        end

        % Value changed function: MinimumthresholdmmEditField
        function MinimumthresholdmmEditFieldValueChanged(app, event)
            value = app.MinimumthresholdmmEditField.Value;
            if isempty(value) == 0 && isempty(app.NameofthecorrectedmapEditField.Value) == 0 && isempty(app.MaximumthresholdmmEditField.Value == 0)
                app.LaunchRectificationButton.Enable = "on";
            else
                app.LaunchRectificationButton.Enable = "off";
            end
        end

        % Value changed function: MaximumthresholdmmEditField
        function MaximumthresholdmmEditFieldValueChanged(app, event)
            value = app.MaximumthresholdmmEditField.Value;
            if isempty(value) == 0 && isempty(app.NameofthecorrectedmapEditField.Value) == 0 && isempty(app.MinimumthresholdmmEditField.Value == 0)
                app.LaunchRectificationButton.Enable = "on";
            else
                app.LaunchRectificationButton.Enable = "off";
            end
        end

        % Value changed function: NameoftheinterpolatedmapEditField
        function NameoftheinterpolatedmapEditFieldValueChanged(app, event)
            value = app.NameoftheinterpolatedmapEditField.Value;
            if isempty(value) == 0
                app.PointMultiplierEditField.Enable = "on";
                if app.PointMultiplierEditField.Value <= 0
                    app.LaunchInterpolationButton.Enable = "off";
                else
                    app.LaunchInterpolationButton.Enable = "on";
                end
            else
                app.PointMultiplierEditField.Enable = "off";
                app.LaunchInterpolationButton.Enable = "off";
            end
        end

        % Value changed function: OutputtextfileEditField
        function OutputtextfileEditFieldValueChanged(app, event)
            value = app.OutputtextfileEditField.Value;
            if isempty(value) == 0
                app.LaunchExtractionButton.Enable = "on";
            else
                app.LaunchExtractionButton.Enable = "off";
            end
        end

        % Value changed function: NameofthecsvfileEditField
        function NameofthecsvfileEditFieldValueChanged(app, event)
            value = app.NameofthecsvfileEditField.Value;
            if isempty(value) == 0
                app.Class01EditField.Enable = "on";
                app.Class02EditField.Enable = "on";
                app.Class03EditField.Enable = "on";
                app.Class04EditField.Enable = "on";
                app.Class05EditField.Enable = "on";
                app.Class06EditField.Enable = "on";
                app.ColorDropDown.Enable = "on";
                app.ColorDropDown_2.Enable = "on";
                app.ColorDropDown_3.Enable = "on";
                app.ColorDropDown_4.Enable = "on";
                app.ColorDropDown_5.Enable = "on";
                app.ColorDropDown_6.Enable = "on";
                app.BackgroundColorDropDown.Enable = "on";
                app.LaunchLDAReconstructionButton.Enable = "on";
            else
                app.Class01EditField.Enable = "off";
                app.Class02EditField.Enable = "off";
                app.Class03EditField.Enable = "off";
                app.Class04EditField.Enable = "off";
                app.Class05EditField.Enable = "off";
                app.Class06EditField.Enable = "off";
                app.ColorDropDown.Enable = "off";
                app.ColorDropDown_2.Enable = "off";
                app.ColorDropDown_3.Enable = "off";
                app.ColorDropDown_4.Enable = "off";
                app.ColorDropDown_5.Enable = "off";
                app.ColorDropDown_6.Enable = "off";
                app.BackgroundColorDropDown.Enable = "off";
                app.LaunchLDAReconstructionButton.Enable = "off";
            end
        end

        % Value changed function: NameofthebiomapEditField
        function NameofthebiomapEditFieldValueChanged(app, event)
            value = app.NameofthebiomapEditField.Value;
            if isempty(value) == 0 && isempty(app.NameoftheinterpolatedbiomapEditField.Value) == 0
                app.PointMultiplierEditField_2.Enable = "on";
                if isempty(app.PointMultiplierEditField_2.Value) == 0
                    app.LaunchBiomapInterpolationButton.Enable = "on";
                end
            else
                app.PointMultiplierEditField_2.Enable = "off";
                app.LaunchBiomapInterpolationButton.Enable = "off";
            end 
        end

        % Value changed function: NameoftheinterpolatedbiomapEditField
        function NameoftheinterpolatedbiomapEditFieldValueChanged(app, event)
            value = app.NameoftheinterpolatedbiomapEditField.Value;
            if isempty(value) == 0 && isempty(app.NameofthebiomapEditField.Value) == 0
                app.PointMultiplierEditField_2.Enable = "on";
                if isempty(app.PointMultiplierEditField_2.Value) == 0
                    app.LaunchBiomapInterpolationButton.Enable = "on";
                end
            else
                app.PointMultiplierEditField_2.Enable = "off";
                app.LaunchBiomapInterpolationButton.Enable = "off";
            end 
        end

        % Value changed function: PointMultiplierEditField_2
        function PointMultiplierEditField_2ValueChanged(app, event)
            value = app.PointMultiplierEditField_2.Value;
            if value <= 0
                app.LaunchBiomapInterpolationButton.Enable = "off";
            else
                app.LaunchBiomapInterpolationButton.Enable = "on";
            end
        end

        % Value changed function: PointMultiplierEditField
        function PointMultiplierEditFieldValueChanged(app, event)
            value = app.PointMultiplierEditField.Value;
            if value <= 0
                app.LaunchInterpolationButton.Enable = "off";
            else
                app.LaunchInterpolationButton.Enable = "on";
            end
        end

        % Value changed function: ContinuousLaserCheckBox
        function ContinuousLaserCheckBoxValueChanged(app, event)
            value = app.ContinuousLaserCheckBox.Value;
            if value == 1
                app.TimebetweenlaserburstssecondEditField.Value = 0;
            end
        end

        % Value changed function: GeneratedmapfileEditField
        function GeneratedmapfileEditFieldValueChanged(app, event)
%             DEVNOTE: CREATE SAFEGUARD TO AVOID MAP FILE OVERWRITING
            value = app.GeneratedmapfileEditField.Value;
            if isempty(value) == 0
                app.MappingStepmmEditField.Enable = "on";
                app.SurfaceoffestmmEditField.Enable = "on";
                app.ZonesizeXaxismmEditField.Enable = "on";
                app.ZonesizeYaxismmEditField.Enable = "on";
                app.MaximumheightmmofthesampleEditField.Enable = "on";
                app.FisrtmappingpointXpositionmmEditField.Enable = "on";
                app.NextButton_7.Enable = "on";
            else
                app.MappingStepmmEditField.Enable = "off";
                app.SurfaceoffestmmEditField.Enable = "off";
                app.ZonesizeXaxismmEditField.Enable = "off";
                app.ZonesizeYaxismmEditField.Enable = "off";
                app.MaximumheightmmofthesampleEditField.Enable = "off";
                app.FisrtmappingpointXpositionmmEditField.Enable = "off";
                app.NextButton_7.Enable = "off";
            end
        end

        % Value changed function: mzXMLfilenameEditField
        function mzXMLfilenameEditFieldValueChanged(app, event)
            value = app.mzXMLfilenameEditField.Value;
            if isempty(value) == 0
                app.LoadmzXMLButton.Enable = "on";
            else
                app.LoadmzXMLButton.Enable = "off";
            end
        end

        % Value changed function: MapfilenameEditField_2
        function MapfilenameEditField_2ValueChanged(app, event)
            value = app.MapfilenameEditField_2.Value;
            if isempty(value) == 0
                app.ScanSelectionMethodDropDown.Enable = "on";
                app.Timebetween2lasershotsecondEditField.Enable = "on";
                app.AspirationTimesEditField.Enable = "on";
                app.BeginThresholdEditField.Enable = "on";
                app.LoudthresholdEditField.Enable = "on";
                app.InternalTriggeringSwitch.Enable = "on";
                app.ScanSelectionButton.Enable = "on";
            else
                app.ScanSelectionMethodDropDown.Enable = "off";
                app.Timebetween2lasershotsecondEditField.Enable = "off";
                app.AspirationTimesEditField.Enable = "off";
                app.BeginThresholdEditField.Enable = "off";
                app.LoudthresholdEditField.Enable = "off";
                app.InternalTriggeringSwitch.Enable = "off";
                app.ScanSelectionButton.Enable = "off";
            end
        end

        % Selection changed function: MappingChoiceButtonGroup
        function MappingChoiceButtonGroupSelectionChanged(app, event)
            selectedButton = app.MappingChoiceButtonGroup.SelectedObject;
            if selectedButton == app.OnlytopographicButton
                app.LaserDropDown.Enable = "off";
                app.ConnectLaserButton.Enable = "off";
                app.NextButton_10.Enable = "on";
                app.MappingMode3DMassSpectrometryLabel.Text = "Mapping Mode: Topography Only";
            elseif selectedButton == app.DmassspectometryButton_2
                app.MappingMode3DMassSpectrometryLabel.Text = "Mapping Mode: 3D Mass Spectrometry";
            elseif selectedButton == app.DmassspectometryButton
                app.MappingMode3DMassSpectrometryLabel.Text = "Mapping Mode: 2D Mass Spectrometry";
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.902 0.902 0.902];
            app.UIFigure.Position = [100 100 263 220];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.CloseRequestFcn = createCallbackFcn(app, @UIFigureCloseRequest, true);

            % Create OMGMSIHopefully10SoonPanel
            app.OMGMSIHopefully10SoonPanel = uipanel(app.UIFigure);
            app.OMGMSIHopefully10SoonPanel.BorderType = 'none';
            app.OMGMSIHopefully10SoonPanel.Title = 'OMG-MSI - Hopefully 1.0 Soon !';
            app.OMGMSIHopefully10SoonPanel.Visible = 'off';
            app.OMGMSIHopefully10SoonPanel.Position = [-1 -779 603 667];

            % Create MatFileEditFieldLabel
            app.MatFileEditFieldLabel = uilabel(app.OMGMSIHopefully10SoonPanel);
            app.MatFileEditFieldLabel.HorizontalAlignment = 'right';
            app.MatFileEditFieldLabel.FontWeight = 'bold';
            app.MatFileEditFieldLabel.Position = [20 624 54 22];
            app.MatFileEditFieldLabel.Text = 'Mat File:';

            % Create MatFileEditField
            app.MatFileEditField = uieditfield(app.OMGMSIHopefully10SoonPanel, 'text');
            app.MatFileEditField.ValueChangedFcn = createCallbackFcn(app, @MatFileEditFieldValueChanged, true);
            app.MatFileEditField.FontWeight = 'bold';
            app.MatFileEditField.Tooltip = {'.Mat files store the data extracted from .mzXML files. They are stored in the "mat files" folder of this software. Specifying one is mandatory for most operations past data acquisition.'};
            app.MatFileEditField.Position = [89 623 141 22];

            % Create MapFileEditFieldLabel
            app.MapFileEditFieldLabel = uilabel(app.OMGMSIHopefully10SoonPanel);
            app.MapFileEditFieldLabel.HorizontalAlignment = 'right';
            app.MapFileEditFieldLabel.FontWeight = 'bold';
            app.MapFileEditFieldLabel.Position = [17 598 57 22];
            app.MapFileEditFieldLabel.Text = 'Map File:';

            % Create MapFileEditField
            app.MapFileEditField = uieditfield(app.OMGMSIHopefully10SoonPanel, 'text');
            app.MapFileEditField.ValueChangedFcn = createCallbackFcn(app, @MapFileEditFieldValueChanged, true);
            app.MapFileEditField.FontWeight = 'bold';
            app.MapFileEditField.Tooltip = {'.Map files store the positions of each pixel acquired in a given MSI experiment. They are stored in the "map files" folder of this software. Specifying the one corresponding to the .mat or .mzXML file of choice is mandatory for most operations past data acquisition.'};
            app.MapFileEditField.Position = [89 597 141 22];

            % Create NewMatButton
            app.NewMatButton = uibutton(app.OMGMSIHopefully10SoonPanel, 'push');
            app.NewMatButton.ButtonPushedFcn = createCallbackFcn(app, @NewMatButtonPushed, true);
            app.NewMatButton.FontWeight = 'bold';
            app.NewMatButton.Position = [263 620 84 26];
            app.NewMatButton.Text = 'New Mat';

            % Create QuittoMenuButton
            app.QuittoMenuButton = uibutton(app.OMGMSIHopefully10SoonPanel, 'push');
            app.QuittoMenuButton.ButtonPushedFcn = createCallbackFcn(app, @QuittoMenuButtonPushed, true);
            app.QuittoMenuButton.Position = [498 622 91 23];
            app.QuittoMenuButton.Text = 'Quit to Menu';

            % Create PleaseinputavalidmatandmapfilenametostartprocessingLabel
            app.PleaseinputavalidmatandmapfilenametostartprocessingLabel = uilabel(app.OMGMSIHopefully10SoonPanel);
            app.PleaseinputavalidmatandmapfilenametostartprocessingLabel.FontColor = [1 0 0];
            app.PleaseinputavalidmatandmapfilenametostartprocessingLabel.Position = [263 593 344 22];
            app.PleaseinputavalidmatandmapfilenametostartprocessingLabel.Text = 'Please input a valid mat and map file name to start processing!';

            % Create OMGMSINewmatfilePanel
            app.OMGMSINewmatfilePanel = uipanel(app.UIFigure);
            app.OMGMSINewmatfilePanel.Title = 'OMG-MSI - New .mat file';
            app.OMGMSINewmatfilePanel.Visible = 'off';
            app.OMGMSINewmatfilePanel.Position = [617 -279 603 500];

            % Create AbortButton
            app.AbortButton = uibutton(app.OMGMSINewmatfilePanel, 'push');
            app.AbortButton.ButtonPushedFcn = createCallbackFcn(app, @AbortButtonPushed, true);
            app.AbortButton.Position = [472 8 91 22];
            app.AbortButton.Text = 'Abort';

            % Create mzXMLfilenameEditFieldLabel
            app.mzXMLfilenameEditFieldLabel = uilabel(app.OMGMSINewmatfilePanel);
            app.mzXMLfilenameEditFieldLabel.HorizontalAlignment = 'right';
            app.mzXMLfilenameEditFieldLabel.FontWeight = 'bold';
            app.mzXMLfilenameEditFieldLabel.Position = [83 433 110 22];
            app.mzXMLfilenameEditFieldLabel.Text = 'mzXML file name :';

            % Create mzXMLfilenameEditField
            app.mzXMLfilenameEditField = uieditfield(app.OMGMSINewmatfilePanel, 'text');
            app.mzXMLfilenameEditField.ValueChangedFcn = createCallbackFcn(app, @mzXMLfilenameEditFieldValueChanged, true);
            app.mzXMLfilenameEditField.Position = [208 433 239 22];

            % Create mzXMLLabel
            app.mzXMLLabel = uilabel(app.OMGMSINewmatfilePanel);
            app.mzXMLLabel.FontWeight = 'bold';
            app.mzXMLLabel.Position = [478 433 51 22];
            app.mzXMLLabel.Text = '.mzXML';

            % Create mzXMLLoadingLabel
            app.mzXMLLoadingLabel = uilabel(app.OMGMSINewmatfilePanel);
            app.mzXMLLoadingLabel.FontWeight = 'bold';
            app.mzXMLLoadingLabel.Position = [9 454 243 22];
            app.mzXMLLoadingLabel.Text = 'mzXML Loading :';

            % Create ScanSelectionLabel
            app.ScanSelectionLabel = uilabel(app.OMGMSINewmatfilePanel);
            app.ScanSelectionLabel.FontWeight = 'bold';
            app.ScanSelectionLabel.Position = [12 328 243 22];
            app.ScanSelectionLabel.Text = 'Scan Selection :';

            % Create LaunchPreprocessingButton
            app.LaunchPreprocessingButton = uibutton(app.OMGMSINewmatfilePanel, 'push');
            app.LaunchPreprocessingButton.ButtonPushedFcn = createCallbackFcn(app, @LaunchPreprocessingButtonPushed, true);
            app.LaunchPreprocessingButton.FontWeight = 'bold';
            app.LaunchPreprocessingButton.Enable = 'off';
            app.LaunchPreprocessingButton.Position = [240 36 145 22];
            app.LaunchPreprocessingButton.Text = 'Launch Preprocessing';

            % Create BiningwindowsizeEditFieldLabel
            app.BiningwindowsizeEditFieldLabel = uilabel(app.OMGMSINewmatfilePanel);
            app.BiningwindowsizeEditFieldLabel.HorizontalAlignment = 'right';
            app.BiningwindowsizeEditFieldLabel.Position = [203 68 107 22];
            app.BiningwindowsizeEditFieldLabel.Text = 'Bining window size';

            % Create BiningwindowsizeEditField
            app.BiningwindowsizeEditField = uieditfield(app.OMGMSINewmatfilePanel, 'numeric');
            app.BiningwindowsizeEditField.Enable = 'off';
            app.BiningwindowsizeEditField.Position = [325 68 100 22];
            app.BiningwindowsizeEditField.Value = 0.1;

            % Create GeneratedmatfileEditFieldLabel
            app.GeneratedmatfileEditFieldLabel = uilabel(app.OMGMSINewmatfilePanel);
            app.GeneratedmatfileEditFieldLabel.HorizontalAlignment = 'right';
            app.GeneratedmatfileEditFieldLabel.FontWeight = 'bold';
            app.GeneratedmatfileEditFieldLabel.Position = [95 101 184 22];
            app.GeneratedmatfileEditFieldLabel.Text = 'Generated mat file ';

            % Create GeneratedmatfileEditField
            app.GeneratedmatfileEditField = uieditfield(app.OMGMSINewmatfilePanel, 'text');
            app.GeneratedmatfileEditField.ValueChangedFcn = createCallbackFcn(app, @GeneratedmatfileEditFieldValueChanged, true);
            app.GeneratedmatfileEditField.Enable = 'off';
            app.GeneratedmatfileEditField.Position = [294 101 138 22];

            % Create matLabel
            app.matLabel = uilabel(app.OMGMSINewmatfilePanel);
            app.matLabel.FontWeight = 'bold';
            app.matLabel.Position = [458 101 30 22];
            app.matLabel.Text = '.mat';

            % Create ScanSelectionButton
            app.ScanSelectionButton = uibutton(app.OMGMSINewmatfilePanel, 'push');
            app.ScanSelectionButton.ButtonPushedFcn = createCallbackFcn(app, @ScanSelectionButtonPushed, true);
            app.ScanSelectionButton.FontWeight = 'bold';
            app.ScanSelectionButton.Enable = 'off';
            app.ScanSelectionButton.Position = [416 154 157 20];
            app.ScanSelectionButton.Text = 'Scan Selection';

            % Create InternalTriggeringSwitchLabel
            app.InternalTriggeringSwitchLabel = uilabel(app.OMGMSINewmatfilePanel);
            app.InternalTriggeringSwitchLabel.HorizontalAlignment = 'center';
            app.InternalTriggeringSwitchLabel.Position = [449 213 102 22];
            app.InternalTriggeringSwitchLabel.Text = 'Internal Triggering';

            % Create InternalTriggeringSwitch
            app.InternalTriggeringSwitch = uiswitch(app.OMGMSINewmatfilePanel, 'slider');
            app.InternalTriggeringSwitch.Enable = 'off';
            app.InternalTriggeringSwitch.Position = [485 187 45 20];
            app.InternalTriggeringSwitch.Value = 'On';

            % Create PreprocessingLabel
            app.PreprocessingLabel = uilabel(app.OMGMSINewmatfilePanel);
            app.PreprocessingLabel.FontWeight = 'bold';
            app.PreprocessingLabel.Position = [13 121 243 22];
            app.PreprocessingLabel.Text = 'Preprocessing :';

            % Create FusionpercentSliderLabel
            app.FusionpercentSliderLabel = uilabel(app.OMGMSINewmatfilePanel);
            app.FusionpercentSliderLabel.HorizontalAlignment = 'right';
            app.FusionpercentSliderLabel.Position = [22 162 98 42];
            app.FusionpercentSliderLabel.Text = ' Fusion percent';

            % Create FusionpercentSlider
            app.FusionpercentSlider = uislider(app.OMGMSINewmatfilePanel);
            app.FusionpercentSlider.Enable = 'off';
            app.FusionpercentSlider.Position = [141 191 136 3];
            app.FusionpercentSlider.Value = 50;

            % Create AspirationTimesEditFieldLabel
            app.AspirationTimesEditFieldLabel = uilabel(app.OMGMSINewmatfilePanel);
            app.AspirationTimesEditFieldLabel.HorizontalAlignment = 'right';
            app.AspirationTimesEditFieldLabel.Position = [31 213 105 22];
            app.AspirationTimesEditFieldLabel.Text = 'Aspiration Time (s)';

            % Create AspirationTimesEditField
            app.AspirationTimesEditField = uieditfield(app.OMGMSINewmatfilePanel, 'numeric');
            app.AspirationTimesEditField.Editable = 'off';
            app.AspirationTimesEditField.BackgroundColor = [0.502 0.502 0.502];
            app.AspirationTimesEditField.Position = [151 213 100 22];
            app.AspirationTimesEditField.Value = 1.05;

            % Create Timebetween2lasershotsecondEditFieldLabel
            app.Timebetween2lasershotsecondEditFieldLabel = uilabel(app.OMGMSINewmatfilePanel);
            app.Timebetween2lasershotsecondEditFieldLabel.HorizontalAlignment = 'right';
            app.Timebetween2lasershotsecondEditFieldLabel.Position = [28 244 197 22];
            app.Timebetween2lasershotsecondEditFieldLabel.Text = 'Time between 2 laser shot (second)';

            % Create Timebetween2lasershotsecondEditField
            app.Timebetween2lasershotsecondEditField = uieditfield(app.OMGMSINewmatfilePanel, 'numeric');
            app.Timebetween2lasershotsecondEditField.Enable = 'off';
            app.Timebetween2lasershotsecondEditField.Position = [240 244 100 22];
            app.Timebetween2lasershotsecondEditField.Value = 3;

            % Create MapfilenameEditField_2Label
            app.MapfilenameEditField_2Label = uilabel(app.OMGMSINewmatfilePanel);
            app.MapfilenameEditField_2Label.HorizontalAlignment = 'right';
            app.MapfilenameEditField_2Label.FontWeight = 'bold';
            app.MapfilenameEditField_2Label.Position = [146 307 85 22];
            app.MapfilenameEditField_2Label.Text = 'Map file name';

            % Create MapfilenameEditField_2
            app.MapfilenameEditField_2 = uieditfield(app.OMGMSINewmatfilePanel, 'text');
            app.MapfilenameEditField_2.ValueChangedFcn = createCallbackFcn(app, @MapfilenameEditField_2ValueChanged, true);
            app.MapfilenameEditField_2.Enable = 'off';
            app.MapfilenameEditField_2.Position = [246 307 146 22];

            % Create mapLabel_5
            app.mapLabel_5 = uilabel(app.OMGMSINewmatfilePanel);
            app.mapLabel_5.FontWeight = 'bold';
            app.mapLabel_5.Position = [412 307 34 22];
            app.mapLabel_5.Text = '.map';

            % Create ScanSelectionMethodDropDownLabel
            app.ScanSelectionMethodDropDownLabel = uilabel(app.OMGMSINewmatfilePanel);
            app.ScanSelectionMethodDropDownLabel.HorizontalAlignment = 'right';
            app.ScanSelectionMethodDropDownLabel.Position = [14 274 128 22];
            app.ScanSelectionMethodDropDownLabel.Text = 'Scan Selection Method';

            % Create ScanSelectionMethodDropDown
            app.ScanSelectionMethodDropDown = uidropdown(app.OMGMSINewmatfilePanel);
            app.ScanSelectionMethodDropDown.ValueChangedFcn = createCallbackFcn(app, @ScanSelectionMethodDropDownValueChanged, true);
            app.ScanSelectionMethodDropDown.Enable = 'off';
            app.ScanSelectionMethodDropDown.Position = [157 274 203 22];

            % Create LaunchTimeEstimationButton
            app.LaunchTimeEstimationButton = uibutton(app.OMGMSINewmatfilePanel, 'push');
            app.LaunchTimeEstimationButton.ButtonPushedFcn = createCallbackFcn(app, @LaunchTimeEstimationButtonPushed, true);
            app.LaunchTimeEstimationButton.FontWeight = 'bold';
            app.LaunchTimeEstimationButton.Enable = 'off';
            app.LaunchTimeEstimationButton.Position = [72 375 154 22];
            app.LaunchTimeEstimationButton.Text = 'Launch Time Estimation';

            % Create TimeValue
            app.TimeValue = uilabel(app.OMGMSINewmatfilePanel);
            app.TimeValue.Position = [247 375 115 22];
            app.TimeValue.Text = 'NO DATA';

            % Create LoadmzXMLButton
            app.LoadmzXMLButton = uibutton(app.OMGMSINewmatfilePanel, 'push');
            app.LoadmzXMLButton.ButtonPushedFcn = createCallbackFcn(app, @LoadmzXMLButtonPushed, true);
            app.LoadmzXMLButton.FontWeight = 'bold';
            app.LoadmzXMLButton.Enable = 'off';
            app.LoadmzXMLButton.Position = [270 402 100 22];
            app.LoadmzXMLButton.Text = 'Load mzXML';

            % Create PlotChromatogramButton
            app.PlotChromatogramButton = uibutton(app.OMGMSINewmatfilePanel, 'push');
            app.PlotChromatogramButton.ButtonPushedFcn = createCallbackFcn(app, @PlotChromatogramButtonPushed, true);
            app.PlotChromatogramButton.FontWeight = 'bold';
            app.PlotChromatogramButton.Enable = 'off';
            app.PlotChromatogramButton.Position = [395 375 136 22];
            app.PlotChromatogramButton.Text = 'Plot Chromatogram';

            % Create BeginThresholdEditFieldLabel
            app.BeginThresholdEditFieldLabel = uilabel(app.OMGMSINewmatfilePanel);
            app.BeginThresholdEditFieldLabel.HorizontalAlignment = 'right';
            app.BeginThresholdEditFieldLabel.Position = [370 274 93 22];
            app.BeginThresholdEditFieldLabel.Text = 'Begin Threshold';

            % Create BeginThresholdEditField
            app.BeginThresholdEditField = uieditfield(app.OMGMSINewmatfilePanel, 'numeric');
            app.BeginThresholdEditField.Enable = 'off';
            app.BeginThresholdEditField.Position = [477 274 100 22];
            app.BeginThresholdEditField.Value = 10000;

            % Create LoudthresholdEditFieldLabel
            app.LoudthresholdEditFieldLabel = uilabel(app.OMGMSINewmatfilePanel);
            app.LoudthresholdEditFieldLabel.HorizontalAlignment = 'right';
            app.LoudthresholdEditFieldLabel.Position = [376 244 85 22];
            app.LoudthresholdEditFieldLabel.Text = 'Loud threshold';

            % Create LoudthresholdEditField
            app.LoudthresholdEditField = uieditfield(app.OMGMSINewmatfilePanel, 'numeric');
            app.LoudthresholdEditField.Enable = 'off';
            app.LoudthresholdEditField.Position = [476 244 100 22];
            app.LoudthresholdEditField.Value = 5000;

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Visible = 'off';
            app.TabGroup.Position = [1 -779 603 594];

            % Create ProcessingTab
            app.ProcessingTab = uitab(app.TabGroup);
            app.ProcessingTab.Title = 'Processing';

            % Create MasslimitsMinimumEditFieldLabel
            app.MasslimitsMinimumEditFieldLabel = uilabel(app.ProcessingTab);
            app.MasslimitsMinimumEditFieldLabel.HorizontalAlignment = 'right';
            app.MasslimitsMinimumEditFieldLabel.Position = [86 498 133 22];
            app.MasslimitsMinimumEditFieldLabel.Text = 'Mass limits:    Minimum:';

            % Create MasslimitsMinimumEditField
            app.MasslimitsMinimumEditField = uieditfield(app.ProcessingTab, 'numeric');
            app.MasslimitsMinimumEditField.ValueDisplayFormat = '%.3f';
            app.MasslimitsMinimumEditField.ValueChangedFcn = createCallbackFcn(app, @MasslimitsMinimumEditFieldValueChanged, true);
            app.MasslimitsMinimumEditField.Enable = 'off';
            app.MasslimitsMinimumEditField.Position = [234 498 100 22];
            app.MasslimitsMinimumEditField.Value = 600;

            % Create MaximumEditFieldLabel
            app.MaximumEditFieldLabel = uilabel(app.ProcessingTab);
            app.MaximumEditFieldLabel.HorizontalAlignment = 'right';
            app.MaximumEditFieldLabel.Position = [161 461 58 22];
            app.MaximumEditFieldLabel.Text = 'Maximum';

            % Create MaximumEditField
            app.MaximumEditField = uieditfield(app.ProcessingTab, 'numeric');
            app.MaximumEditField.ValueDisplayFormat = '%.3f';
            app.MaximumEditField.Enable = 'off';
            app.MaximumEditField.Position = [234 461 100 22];
            app.MaximumEditField.Value = 600.25;

            % Create BiomapOutputEditFieldLabel
            app.BiomapOutputEditFieldLabel = uilabel(app.ProcessingTab);
            app.BiomapOutputEditFieldLabel.HorizontalAlignment = 'right';
            app.BiomapOutputEditFieldLabel.FontWeight = 'bold';
            app.BiomapOutputEditFieldLabel.Position = [28 418 203 22];
            app.BiomapOutputEditFieldLabel.Text = 'Biomap Output:';

            % Create BiomapOutputEditField
            app.BiomapOutputEditField = uieditfield(app.ProcessingTab, 'text');
            app.BiomapOutputEditField.ValueChangedFcn = createCallbackFcn(app, @BiomapOutputEditFieldValueChanged, true);
            app.BiomapOutputEditField.Enable = 'off';
            app.BiomapOutputEditField.Position = [242 418 157 22];

            % Create biomapLabel
            app.biomapLabel = uilabel(app.ProcessingTab);
            app.biomapLabel.FontWeight = 'bold';
            app.biomapLabel.Position = [409 418 52 22];
            app.biomapLabel.Text = '.biomap';

            % Create LaunchReconstructionButton
            app.LaunchReconstructionButton = uibutton(app.ProcessingTab, 'push');
            app.LaunchReconstructionButton.ButtonPushedFcn = createCallbackFcn(app, @LaunchReconstructionButtonPushed, true);
            app.LaunchReconstructionButton.FontWeight = 'bold';
            app.LaunchReconstructionButton.Enable = 'off';
            app.LaunchReconstructionButton.Position = [245 386 150 22];
            app.LaunchReconstructionButton.Text = 'Launch Reconstruction';

            % Create ExtractOneSpectrumButton
            app.ExtractOneSpectrumButton = uibutton(app.ProcessingTab, 'push');
            app.ExtractOneSpectrumButton.ButtonPushedFcn = createCallbackFcn(app, @ExtractOneSpectrumButtonPushed, true);
            app.ExtractOneSpectrumButton.FontWeight = 'bold';
            app.ExtractOneSpectrumButton.Enable = 'off';
            app.ExtractOneSpectrumButton.Position = [162 322 141 23];
            app.ExtractOneSpectrumButton.Text = 'Extract One Spectrum';

            % Create ExtractSpectraZoneButton
            app.ExtractSpectraZoneButton = uibutton(app.ProcessingTab, 'push');
            app.ExtractSpectraZoneButton.ButtonPushedFcn = createCallbackFcn(app, @ExtractSpectraZoneButtonPushed, true);
            app.ExtractSpectraZoneButton.FontWeight = 'bold';
            app.ExtractSpectraZoneButton.Enable = 'off';
            app.ExtractSpectraZoneButton.Position = [327 322 136 22];
            app.ExtractSpectraZoneButton.Text = 'Extract Spectra Zone';

            % Create MapFromSpectraButton
            app.MapFromSpectraButton = uibutton(app.ProcessingTab, 'push');
            app.MapFromSpectraButton.ButtonPushedFcn = createCallbackFcn(app, @MapFromSpectraButtonPushed, true);
            app.MapFromSpectraButton.FontWeight = 'bold';
            app.MapFromSpectraButton.Enable = 'off';
            app.MapFromSpectraButton.Position = [318 282 172 22];
            app.MapFromSpectraButton.Text = 'Map From Spectra';

            % Create MaxEditFieldLabel
            app.MaxEditFieldLabel = uilabel(app.ProcessingTab);
            app.MaxEditFieldLabel.HorizontalAlignment = 'right';
            app.MaxEditFieldLabel.Position = [211 283 28 22];
            app.MaxEditFieldLabel.Text = 'Max';

            % Create MaxEditField
            app.MaxEditField = uieditfield(app.ProcessingTab, 'numeric');
            app.MaxEditField.Enable = 'off';
            app.MaxEditField.Position = [254 281 43 25];
            app.MaxEditField.Value = 2000;

            % Create MinEditFieldLabel
            app.MinEditFieldLabel = uilabel(app.ProcessingTab);
            app.MinEditFieldLabel.HorizontalAlignment = 'right';
            app.MinEditFieldLabel.Position = [117 284 27 22];
            app.MinEditFieldLabel.Text = 'Min';

            % Create MinEditField
            app.MinEditField = uieditfield(app.ProcessingTab, 'numeric');
            app.MinEditField.Enable = 'off';
            app.MinEditField.Position = [153 282 44 25];

            % Create ReconstructionLabel
            app.ReconstructionLabel = uilabel(app.ProcessingTab);
            app.ReconstructionLabel.FontWeight = 'bold';
            app.ReconstructionLabel.Position = [33 542 243 22];
            app.ReconstructionLabel.Text = 'Reconstruction :';

            % Create AdditionnalDataExtractionFeaturesLabel
            app.AdditionnalDataExtractionFeaturesLabel = uilabel(app.ProcessingTab);
            app.AdditionnalDataExtractionFeaturesLabel.FontWeight = 'bold';
            app.AdditionnalDataExtractionFeaturesLabel.Position = [33 351 243 22];
            app.AdditionnalDataExtractionFeaturesLabel.Text = 'Additionnal Data Extraction Features :';

            % Create LouddataonthemapSwitchLabel
            app.LouddataonthemapSwitchLabel = uilabel(app.ProcessingTab);
            app.LouddataonthemapSwitchLabel.HorizontalAlignment = 'center';
            app.LouddataonthemapSwitchLabel.Position = [403 498 122 22];
            app.LouddataonthemapSwitchLabel.Text = 'Loud data on the map';

            % Create LouddataonthemapSwitch
            app.LouddataonthemapSwitch = uiswitch(app.ProcessingTab, 'slider');
            app.LouddataonthemapSwitch.Enable = 'off';
            app.LouddataonthemapSwitch.Position = [438 474 45 20];

            % Create PostProcessingTab
            app.PostProcessingTab = uitab(app.TabGroup);
            app.PostProcessingTab.Title = 'Post Processing';

            % Create NameofthecorrectedmapEditFieldLabel
            app.NameofthecorrectedmapEditFieldLabel = uilabel(app.PostProcessingTab);
            app.NameofthecorrectedmapEditFieldLabel.HorizontalAlignment = 'right';
            app.NameofthecorrectedmapEditFieldLabel.Position = [73 486 154 22];
            app.NameofthecorrectedmapEditFieldLabel.Text = 'Name of the corrected map ';

            % Create NameofthecorrectedmapEditField
            app.NameofthecorrectedmapEditField = uieditfield(app.PostProcessingTab, 'text');
            app.NameofthecorrectedmapEditField.ValueChangedFcn = createCallbackFcn(app, @NameofthecorrectedmapEditFieldValueChanged, true);
            app.NameofthecorrectedmapEditField.Enable = 'off';
            app.NameofthecorrectedmapEditField.Position = [242 486 146 22];

            % Create LaunchRectificationButton
            app.LaunchRectificationButton = uibutton(app.PostProcessingTab, 'push');
            app.LaunchRectificationButton.ButtonPushedFcn = createCallbackFcn(app, @LaunchRectificationButtonPushed, true);
            app.LaunchRectificationButton.FontWeight = 'bold';
            app.LaunchRectificationButton.Enable = 'off';
            app.LaunchRectificationButton.Position = [246 374 137 22];
            app.LaunchRectificationButton.Text = 'Launch Rectification ';

            % Create mapLabel_4
            app.mapLabel_4 = uilabel(app.PostProcessingTab);
            app.mapLabel_4.FontWeight = 'bold';
            app.mapLabel_4.Position = [392 486 34 22];
            app.mapLabel_4.Text = '.map';

            % Create MinimumthresholdmmEditFieldLabel
            app.MinimumthresholdmmEditFieldLabel = uilabel(app.PostProcessingTab);
            app.MinimumthresholdmmEditFieldLabel.HorizontalAlignment = 'right';
            app.MinimumthresholdmmEditFieldLabel.Position = [143 450 142 22];
            app.MinimumthresholdmmEditFieldLabel.Text = 'Minimum threshold (mm) ';

            % Create MinimumthresholdmmEditField
            app.MinimumthresholdmmEditField = uieditfield(app.PostProcessingTab, 'numeric');
            app.MinimumthresholdmmEditField.ValueChangedFcn = createCallbackFcn(app, @MinimumthresholdmmEditFieldValueChanged, true);
            app.MinimumthresholdmmEditField.Enable = 'off';
            app.MinimumthresholdmmEditField.Position = [302 449 100 22];

            % Create MaximumthresholdmmEditFieldLabel
            app.MaximumthresholdmmEditFieldLabel = uilabel(app.PostProcessingTab);
            app.MaximumthresholdmmEditFieldLabel.HorizontalAlignment = 'right';
            app.MaximumthresholdmmEditFieldLabel.Position = [142 417 145 22];
            app.MaximumthresholdmmEditFieldLabel.Text = 'Maximum threshold (mm) ';

            % Create MaximumthresholdmmEditField
            app.MaximumthresholdmmEditField = uieditfield(app.PostProcessingTab, 'numeric');
            app.MaximumthresholdmmEditField.ValueChangedFcn = createCallbackFcn(app, @MaximumthresholdmmEditFieldValueChanged, true);
            app.MaximumthresholdmmEditField.Enable = 'off';
            app.MaximumthresholdmmEditField.Position = [302 417 102 22];
            app.MaximumthresholdmmEditField.Value = 20;

            % Create LaunchInterpolationButton
            app.LaunchInterpolationButton = uibutton(app.PostProcessingTab, 'push');
            app.LaunchInterpolationButton.ButtonPushedFcn = createCallbackFcn(app, @LaunchInterpolationButtonPushed, true);
            app.LaunchInterpolationButton.FontWeight = 'bold';
            app.LaunchInterpolationButton.Enable = 'off';
            app.LaunchInterpolationButton.Position = [248 200 134 22];
            app.LaunchInterpolationButton.Text = 'Launch Interpolation';

            % Create mapLabel_7
            app.mapLabel_7 = uilabel(app.PostProcessingTab);
            app.mapLabel_7.FontWeight = 'bold';
            app.mapLabel_7.Position = [401 279 34 22];
            app.mapLabel_7.Text = '.map';

            % Create NameoftheinterpolatedmapEditFieldLabel
            app.NameoftheinterpolatedmapEditFieldLabel = uilabel(app.PostProcessingTab);
            app.NameoftheinterpolatedmapEditFieldLabel.HorizontalAlignment = 'right';
            app.NameoftheinterpolatedmapEditFieldLabel.Position = [70 280 167 22];
            app.NameoftheinterpolatedmapEditFieldLabel.Text = 'Name of the interpolated map ';

            % Create NameoftheinterpolatedmapEditField
            app.NameoftheinterpolatedmapEditField = uieditfield(app.PostProcessingTab, 'text');
            app.NameoftheinterpolatedmapEditField.ValueChangedFcn = createCallbackFcn(app, @NameoftheinterpolatedmapEditFieldValueChanged, true);
            app.NameoftheinterpolatedmapEditField.Enable = 'off';
            app.NameoftheinterpolatedmapEditField.Position = [252 280 146 22];

            % Create PointMultiplierEditFieldLabel
            app.PointMultiplierEditFieldLabel = uilabel(app.PostProcessingTab);
            app.PointMultiplierEditFieldLabel.HorizontalAlignment = 'right';
            app.PointMultiplierEditFieldLabel.Position = [180 245 84 22];
            app.PointMultiplierEditFieldLabel.Text = 'Point Multiplier';

            % Create PointMultiplierEditField
            app.PointMultiplierEditField = uieditfield(app.PostProcessingTab, 'numeric');
            app.PointMultiplierEditField.ValueChangedFcn = createCallbackFcn(app, @PointMultiplierEditFieldValueChanged, true);
            app.PointMultiplierEditField.Enable = 'off';
            app.PointMultiplierEditField.Position = [281 244 100 22];
            app.PointMultiplierEditField.Value = 2;

            % Create LaunchBiomapInterpolationButton
            app.LaunchBiomapInterpolationButton = uibutton(app.PostProcessingTab, 'push');
            app.LaunchBiomapInterpolationButton.ButtonPushedFcn = createCallbackFcn(app, @LaunchBiomapInterpolationButtonPushed, true);
            app.LaunchBiomapInterpolationButton.FontWeight = 'bold';
            app.LaunchBiomapInterpolationButton.Enable = 'off';
            app.LaunchBiomapInterpolationButton.Position = [221 20 182 22];
            app.LaunchBiomapInterpolationButton.Text = 'Launch Biomap Interpolation';

            % Create biomapLabel_2
            app.biomapLabel_2 = uilabel(app.PostProcessingTab);
            app.biomapLabel_2.FontWeight = 'bold';
            app.biomapLabel_2.Position = [389 115 52 22];
            app.biomapLabel_2.Text = '.biomap';

            % Create biomapLabel_3
            app.biomapLabel_3 = uilabel(app.PostProcessingTab);
            app.biomapLabel_3.FontWeight = 'bold';
            app.biomapLabel_3.Position = [390 85 52 22];
            app.biomapLabel_3.Text = '.biomap';

            % Create NameofthebiomapEditFieldLabel
            app.NameofthebiomapEditFieldLabel = uilabel(app.PostProcessingTab);
            app.NameofthebiomapEditFieldLabel.HorizontalAlignment = 'right';
            app.NameofthebiomapEditFieldLabel.Position = [112 115 114 22];
            app.NameofthebiomapEditFieldLabel.Text = 'Name of the biomap';

            % Create NameofthebiomapEditField
            app.NameofthebiomapEditField = uieditfield(app.PostProcessingTab, 'text');
            app.NameofthebiomapEditField.ValueChangedFcn = createCallbackFcn(app, @NameofthebiomapEditFieldValueChanged, true);
            app.NameofthebiomapEditField.Position = [241 115 146 22];

            % Create NameoftheinterpolatedbiomapEditFieldLabel
            app.NameoftheinterpolatedbiomapEditFieldLabel = uilabel(app.PostProcessingTab);
            app.NameoftheinterpolatedbiomapEditFieldLabel.HorizontalAlignment = 'right';
            app.NameoftheinterpolatedbiomapEditFieldLabel.Position = [44 86 183 22];
            app.NameoftheinterpolatedbiomapEditFieldLabel.Text = 'Name of the interpolated biomap ';

            % Create NameoftheinterpolatedbiomapEditField
            app.NameoftheinterpolatedbiomapEditField = uieditfield(app.PostProcessingTab, 'text');
            app.NameoftheinterpolatedbiomapEditField.ValueChangedFcn = createCallbackFcn(app, @NameoftheinterpolatedbiomapEditFieldValueChanged, true);
            app.NameoftheinterpolatedbiomapEditField.Position = [242 86 146 22];

            % Create PointMultiplierEditField_2Label
            app.PointMultiplierEditField_2Label = uilabel(app.PostProcessingTab);
            app.PointMultiplierEditField_2Label.HorizontalAlignment = 'right';
            app.PointMultiplierEditField_2Label.Position = [163 54 84 22];
            app.PointMultiplierEditField_2Label.Text = 'Point Multiplier';

            % Create PointMultiplierEditField_2
            app.PointMultiplierEditField_2 = uieditfield(app.PostProcessingTab, 'numeric');
            app.PointMultiplierEditField_2.ValueChangedFcn = createCallbackFcn(app, @PointMultiplierEditField_2ValueChanged, true);
            app.PointMultiplierEditField_2.Enable = 'off';
            app.PointMultiplierEditField_2.Position = [264 53 100 22];
            app.PointMultiplierEditField_2.Value = 2;

            % Create TopographicCorrectionLabel
            app.TopographicCorrectionLabel = uilabel(app.PostProcessingTab);
            app.TopographicCorrectionLabel.HorizontalAlignment = 'center';
            app.TopographicCorrectionLabel.FontWeight = 'bold';
            app.TopographicCorrectionLabel.Position = [160 527 311 22];
            app.TopographicCorrectionLabel.Text = 'Topographic Correction';

            % Create TopographicInterpolationLabel
            app.TopographicInterpolationLabel = uilabel(app.PostProcessingTab);
            app.TopographicInterpolationLabel.HorizontalAlignment = 'center';
            app.TopographicInterpolationLabel.FontWeight = 'bold';
            app.TopographicInterpolationLabel.Position = [161 323 311 22];
            app.TopographicInterpolationLabel.Text = 'Topographic Interpolation';

            % Create BiometricDataInterpolationLabel
            app.BiometricDataInterpolationLabel = uilabel(app.PostProcessingTab);
            app.BiometricDataInterpolationLabel.HorizontalAlignment = 'center';
            app.BiometricDataInterpolationLabel.FontWeight = 'bold';
            app.BiometricDataInterpolationLabel.Position = [161 154 311 22];
            app.BiometricDataInterpolationLabel.Text = 'Biometric Data Interpolation';

            % Create DisplayfromexternaldataTab
            app.DisplayfromexternaldataTab = uitab(app.TabGroup);
            app.DisplayfromexternaldataTab.Title = 'Display from external data';

            % Create ColorDropDownLabel
            app.ColorDropDownLabel = uilabel(app.DisplayfromexternaldataTab);
            app.ColorDropDownLabel.HorizontalAlignment = 'right';
            app.ColorDropDownLabel.Position = [311 385 34 22];
            app.ColorDropDownLabel.Text = 'Color';

            % Create ColorDropDown
            app.ColorDropDown = uidropdown(app.DisplayfromexternaldataTab);
            app.ColorDropDown.Items = {'Red', 'Green', 'Blue', 'Orange', 'Violet', 'Yellow', 'None'};
            app.ColorDropDown.Enable = 'off';
            app.ColorDropDown.Position = [360 385 100 22];
            app.ColorDropDown.Value = 'Red';

            % Create csvLabel
            app.csvLabel = uilabel(app.DisplayfromexternaldataTab);
            app.csvLabel.FontWeight = 'bold';
            app.csvLabel.Position = [427 428 29 22];
            app.csvLabel.Text = '.csv';

            % Create NameofthecsvfileEditFieldLabel
            app.NameofthecsvfileEditFieldLabel = uilabel(app.DisplayfromexternaldataTab);
            app.NameofthecsvfileEditFieldLabel.HorizontalAlignment = 'right';
            app.NameofthecsvfileEditFieldLabel.Position = [125 428 111 22];
            app.NameofthecsvfileEditFieldLabel.Text = 'Name of the csv file';

            % Create NameofthecsvfileEditField
            app.NameofthecsvfileEditField = uieditfield(app.DisplayfromexternaldataTab, 'text');
            app.NameofthecsvfileEditField.ValueChangedFcn = createCallbackFcn(app, @NameofthecsvfileEditFieldValueChanged, true);
            app.NameofthecsvfileEditField.Position = [251 428 167 22];

            % Create Class01EditFieldLabel
            app.Class01EditFieldLabel = uilabel(app.DisplayfromexternaldataTab);
            app.Class01EditFieldLabel.HorizontalAlignment = 'right';
            app.Class01EditFieldLabel.Position = [105 385 52 22];
            app.Class01EditFieldLabel.Text = 'Class 01';

            % Create Class01EditField
            app.Class01EditField = uieditfield(app.DisplayfromexternaldataTab, 'text');
            app.Class01EditField.Enable = 'off';
            app.Class01EditField.Position = [172 385 130 22];

            % Create Class02EditFieldLabel
            app.Class02EditFieldLabel = uilabel(app.DisplayfromexternaldataTab);
            app.Class02EditFieldLabel.HorizontalAlignment = 'right';
            app.Class02EditFieldLabel.Position = [105 356 52 22];
            app.Class02EditFieldLabel.Text = 'Class 02';

            % Create Class02EditField
            app.Class02EditField = uieditfield(app.DisplayfromexternaldataTab, 'text');
            app.Class02EditField.Enable = 'off';
            app.Class02EditField.Position = [172 356 130 22];

            % Create Class03EditFieldLabel
            app.Class03EditFieldLabel = uilabel(app.DisplayfromexternaldataTab);
            app.Class03EditFieldLabel.HorizontalAlignment = 'right';
            app.Class03EditFieldLabel.Position = [105 325 52 22];
            app.Class03EditFieldLabel.Text = 'Class 03';

            % Create Class03EditField
            app.Class03EditField = uieditfield(app.DisplayfromexternaldataTab, 'text');
            app.Class03EditField.Enable = 'off';
            app.Class03EditField.Position = [172 325 130 22];

            % Create LaunchLDAReconstructionButton
            app.LaunchLDAReconstructionButton = uibutton(app.DisplayfromexternaldataTab, 'push');
            app.LaunchLDAReconstructionButton.ButtonPushedFcn = createCallbackFcn(app, @LaunchLDAReconstructionButtonPushed, true);
            app.LaunchLDAReconstructionButton.FontWeight = 'bold';
            app.LaunchLDAReconstructionButton.Enable = 'off';
            app.LaunchLDAReconstructionButton.Position = [226 106 178 22];
            app.LaunchLDAReconstructionButton.Text = 'Launch LDA Reconstruction';

            % Create BackgroundColorDropDownLabel
            app.BackgroundColorDropDownLabel = uilabel(app.DisplayfromexternaldataTab);
            app.BackgroundColorDropDownLabel.HorizontalAlignment = 'right';
            app.BackgroundColorDropDownLabel.Position = [203 179 102 22];
            app.BackgroundColorDropDownLabel.Text = 'Background Color';

            % Create BackgroundColorDropDown
            app.BackgroundColorDropDown = uidropdown(app.DisplayfromexternaldataTab);
            app.BackgroundColorDropDown.Items = {'Black', 'White', 'Grey'};
            app.BackgroundColorDropDown.Enable = 'off';
            app.BackgroundColorDropDown.Position = [320 179 100 22];
            app.BackgroundColorDropDown.Value = 'Black';

            % Create ColorDropDown_2Label
            app.ColorDropDown_2Label = uilabel(app.DisplayfromexternaldataTab);
            app.ColorDropDown_2Label.HorizontalAlignment = 'right';
            app.ColorDropDown_2Label.Position = [312 355 34 22];
            app.ColorDropDown_2Label.Text = 'Color';

            % Create ColorDropDown_2
            app.ColorDropDown_2 = uidropdown(app.DisplayfromexternaldataTab);
            app.ColorDropDown_2.Items = {'Red', 'Green', 'Blue', 'Orange', 'Violet', 'Yellow', 'None'};
            app.ColorDropDown_2.Enable = 'off';
            app.ColorDropDown_2.Position = [361 355 100 22];
            app.ColorDropDown_2.Value = 'Green';

            % Create ColorDropDown_3Label
            app.ColorDropDown_3Label = uilabel(app.DisplayfromexternaldataTab);
            app.ColorDropDown_3Label.HorizontalAlignment = 'right';
            app.ColorDropDown_3Label.Position = [313 325 34 22];
            app.ColorDropDown_3Label.Text = 'Color';

            % Create ColorDropDown_3
            app.ColorDropDown_3 = uidropdown(app.DisplayfromexternaldataTab);
            app.ColorDropDown_3.Items = {'Red', 'Green', 'Blue', 'Orange', 'Violet', 'Yellow', 'None'};
            app.ColorDropDown_3.Enable = 'off';
            app.ColorDropDown_3.Position = [362 325 100 22];
            app.ColorDropDown_3.Value = 'Orange';

            % Create ColorDropDown_4Label
            app.ColorDropDown_4Label = uilabel(app.DisplayfromexternaldataTab);
            app.ColorDropDown_4Label.HorizontalAlignment = 'right';
            app.ColorDropDown_4Label.Position = [314 294 34 22];
            app.ColorDropDown_4Label.Text = 'Color';

            % Create ColorDropDown_4
            app.ColorDropDown_4 = uidropdown(app.DisplayfromexternaldataTab);
            app.ColorDropDown_4.Items = {'Red', 'Green', 'Blue', 'Orange', 'Violet', 'Yellow', 'None'};
            app.ColorDropDown_4.Enable = 'off';
            app.ColorDropDown_4.Position = [363 294 100 22];
            app.ColorDropDown_4.Value = 'None';

            % Create Class04EditFieldLabel
            app.Class04EditFieldLabel = uilabel(app.DisplayfromexternaldataTab);
            app.Class04EditFieldLabel.HorizontalAlignment = 'right';
            app.Class04EditFieldLabel.Position = [105 294 52 22];
            app.Class04EditFieldLabel.Text = 'Class 04';

            % Create Class04EditField
            app.Class04EditField = uieditfield(app.DisplayfromexternaldataTab, 'text');
            app.Class04EditField.Enable = 'off';
            app.Class04EditField.Position = [172 294 130 22];

            % Create Class05EditFieldLabel
            app.Class05EditFieldLabel = uilabel(app.DisplayfromexternaldataTab);
            app.Class05EditFieldLabel.HorizontalAlignment = 'right';
            app.Class05EditFieldLabel.Position = [105 265 52 22];
            app.Class05EditFieldLabel.Text = 'Class 05';

            % Create Class05EditField
            app.Class05EditField = uieditfield(app.DisplayfromexternaldataTab, 'text');
            app.Class05EditField.Enable = 'off';
            app.Class05EditField.Position = [172 265 130 22];

            % Create Class06EditFieldLabel
            app.Class06EditFieldLabel = uilabel(app.DisplayfromexternaldataTab);
            app.Class06EditFieldLabel.HorizontalAlignment = 'right';
            app.Class06EditFieldLabel.Position = [106 233 52 22];
            app.Class06EditFieldLabel.Text = 'Class 06';

            % Create Class06EditField
            app.Class06EditField = uieditfield(app.DisplayfromexternaldataTab, 'text');
            app.Class06EditField.Enable = 'off';
            app.Class06EditField.Position = [173 233 130 22];

            % Create ColorDropDown_5Label
            app.ColorDropDown_5Label = uilabel(app.DisplayfromexternaldataTab);
            app.ColorDropDown_5Label.HorizontalAlignment = 'right';
            app.ColorDropDown_5Label.Position = [315 264 34 22];
            app.ColorDropDown_5Label.Text = 'Color';

            % Create ColorDropDown_5
            app.ColorDropDown_5 = uidropdown(app.DisplayfromexternaldataTab);
            app.ColorDropDown_5.Items = {'Red', 'Green', 'Blue', 'Orange', 'Violet', 'Yellow', 'None'};
            app.ColorDropDown_5.Enable = 'off';
            app.ColorDropDown_5.Position = [364 264 100 22];
            app.ColorDropDown_5.Value = 'None';

            % Create ColorDropDown_6Label
            app.ColorDropDown_6Label = uilabel(app.DisplayfromexternaldataTab);
            app.ColorDropDown_6Label.HorizontalAlignment = 'right';
            app.ColorDropDown_6Label.Position = [316 234 34 22];
            app.ColorDropDown_6Label.Text = 'Color';

            % Create ColorDropDown_6
            app.ColorDropDown_6 = uidropdown(app.DisplayfromexternaldataTab);
            app.ColorDropDown_6.Items = {'Red', 'Green', 'Blue', 'Orange', 'Violet', 'Yellow', 'None'};
            app.ColorDropDown_6.Enable = 'off';
            app.ColorDropDown_6.Position = [365 234 100 22];
            app.ColorDropDown_6.Value = 'None';

            % Create Label
            app.Label = uilabel(app.DisplayfromexternaldataTab);
            app.Label.FontWeight = 'bold';
            app.Label.Position = [59 491 505 25];
            app.Label.Text = 'Import Classification from External Software : Display of the classification on the map';

            % Create Scils_Extraction
            app.Scils_Extraction = uitab(app.TabGroup);
            app.Scils_Extraction.Title = 'Data Extraction';

            % Create OutputtextfileEditFieldLabel
            app.OutputtextfileEditFieldLabel = uilabel(app.Scils_Extraction);
            app.OutputtextfileEditFieldLabel.HorizontalAlignment = 'right';
            app.OutputtextfileEditFieldLabel.FontWeight = 'bold';
            app.OutputtextfileEditFieldLabel.Position = [140 481 93 22];
            app.OutputtextfileEditFieldLabel.Text = 'Output text file:';

            % Create OutputtextfileEditField
            app.OutputtextfileEditField = uieditfield(app.Scils_Extraction, 'text');
            app.OutputtextfileEditField.ValueChangedFcn = createCallbackFcn(app, @OutputtextfileEditFieldValueChanged, true);
            app.OutputtextfileEditField.Enable = 'off';
            app.OutputtextfileEditField.Position = [248 481 146 22];

            % Create txtLabel
            app.txtLabel = uilabel(app.Scils_Extraction);
            app.txtLabel.FontWeight = 'bold';
            app.txtLabel.Position = [406 481 25 22];
            app.txtLabel.Text = '.txt';

            % Create LaunchExtractionButton
            app.LaunchExtractionButton = uibutton(app.Scils_Extraction, 'push');
            app.LaunchExtractionButton.ButtonPushedFcn = createCallbackFcn(app, @LaunchExtractionButtonPushed, true);
            app.LaunchExtractionButton.FontWeight = 'bold';
            app.LaunchExtractionButton.Enable = 'off';
            app.LaunchExtractionButton.Position = [262 438 120 22];
            app.LaunchExtractionButton.Text = 'Launch Extraction';

            % Create ExporttoSCILSImzmlLabel
            app.ExporttoSCILSImzmlLabel = uilabel(app.Scils_Extraction);
            app.ExporttoSCILSImzmlLabel.HorizontalAlignment = 'center';
            app.ExporttoSCILSImzmlLabel.FontWeight = 'bold';
            app.ExporttoSCILSImzmlLabel.Position = [251 529 142 22];
            app.ExporttoSCILSImzmlLabel.Text = 'Export to SCILS (Imzml)';

            % Create Exportto3DfileplyLabel
            app.Exportto3DfileplyLabel = uilabel(app.Scils_Extraction);
            app.Exportto3DfileplyLabel.HorizontalAlignment = 'center';
            app.Exportto3DfileplyLabel.FontWeight = 'bold';
            app.Exportto3DfileplyLabel.Position = [12 342 134 22];
            app.Exportto3DfileplyLabel.Text = 'Export to 3D file (ply)';

            % Create ExportrawBioMapButton
            app.ExportrawBioMapButton = uibutton(app.Scils_Extraction, 'push');
            app.ExportrawBioMapButton.ButtonPushedFcn = createCallbackFcn(app, @ExportrawBioMapButtonPushed, true);
            app.ExportrawBioMapButton.FontWeight = 'bold';
            app.ExportrawBioMapButton.Position = [173 338 187 23];
            app.ExportrawBioMapButton.Text = 'Export raw BioMap';

            % Create ExportandcoregisterBiomapButton
            app.ExportandcoregisterBiomapButton = uibutton(app.Scils_Extraction, 'push');
            app.ExportandcoregisterBiomapButton.ButtonPushedFcn = createCallbackFcn(app, @ExportandcoregisterBiomapButtonPushed, true);
            app.ExportandcoregisterBiomapButton.FontWeight = 'bold';
            app.ExportandcoregisterBiomapButton.Position = [174 296 186 23];
            app.ExportandcoregisterBiomapButton.Text = 'Export and coregister Biomap';

            % Create ExporttoCSVfileLabel
            app.ExporttoCSVfileLabel = uilabel(app.Scils_Extraction);
            app.ExporttoCSVfileLabel.HorizontalAlignment = 'center';
            app.ExporttoCSVfileLabel.FontWeight = 'bold';
            app.ExporttoCSVfileLabel.Position = [11 220 134 22];
            app.ExporttoCSVfileLabel.Text = 'Export to CSV file:';

            % Create MinMzEditFieldLabel
            app.MinMzEditFieldLabel = uilabel(app.Scils_Extraction);
            app.MinMzEditFieldLabel.HorizontalAlignment = 'right';
            app.MinMzEditFieldLabel.Position = [140 220 47 22];
            app.MinMzEditFieldLabel.Text = 'Min M/z';

            % Create MinMzEditField
            app.MinMzEditField = uieditfield(app.Scils_Extraction, 'numeric');
            app.MinMzEditField.Enable = 'off';
            app.MinMzEditField.Position = [202 220 61 22];

            % Create MaxMzEditFieldLabel
            app.MaxMzEditFieldLabel = uilabel(app.Scils_Extraction);
            app.MaxMzEditFieldLabel.HorizontalAlignment = 'right';
            app.MaxMzEditFieldLabel.Position = [136 193 50 22];
            app.MaxMzEditFieldLabel.Text = 'Max M/z';

            % Create MaxMzEditField
            app.MaxMzEditField = uieditfield(app.Scils_Extraction, 'numeric');
            app.MaxMzEditField.Enable = 'off';
            app.MaxMzEditField.Position = [201 193 61 22];
            app.MaxMzEditField.Value = 2000;

            % Create BinningEditFieldLabel
            app.BinningEditFieldLabel = uilabel(app.Scils_Extraction);
            app.BinningEditFieldLabel.HorizontalAlignment = 'right';
            app.BinningEditFieldLabel.Position = [141 166 45 22];
            app.BinningEditFieldLabel.Text = 'Binning';

            % Create BinningEditField
            app.BinningEditField = uieditfield(app.Scils_Extraction, 'numeric');
            app.BinningEditField.Enable = 'off';
            app.BinningEditField.Position = [201 166 61 22];
            app.BinningEditField.Value = 0.1;

            % Create ExporttoCSVButton
            app.ExporttoCSVButton = uibutton(app.Scils_Extraction, 'push');
            app.ExporttoCSVButton.ButtonPushedFcn = createCallbackFcn(app, @ExporttoCSVButtonPushed, true);
            app.ExporttoCSVButton.FontWeight = 'bold';
            app.ExporttoCSVButton.Enable = 'off';
            app.ExporttoCSVButton.Position = [364 220 187 23];
            app.ExporttoCSVButton.Text = 'Export to CSV';

            % Create NormalizeCSVTICButton
            app.NormalizeCSVTICButton = uibutton(app.Scils_Extraction, 'push');
            app.NormalizeCSVTICButton.ButtonPushedFcn = createCallbackFcn(app, @NormalizeCSVTICButtonPushed, true);
            app.NormalizeCSVTICButton.FontWeight = 'bold';
            app.NormalizeCSVTICButton.Tooltip = {'Takes a .csv file generated with the "Export to CSV" button, and performs Total Ion Count (TIC) normalization on it. Highly recommended for data interpretation.'};
            app.NormalizeCSVTICButton.Position = [365 166 187 23];
            app.NormalizeCSVTICButton.Text = 'Normalize CSV (TIC)';

            % Create ExportrawCSVButton
            app.ExportrawCSVButton = uibutton(app.Scils_Extraction, 'push');
            app.ExportrawCSVButton.ButtonPushedFcn = createCallbackFcn(app, @ExportrawCSVButtonPushed, true);
            app.ExportrawCSVButton.FontWeight = 'bold';
            app.ExportrawCSVButton.Position = [375 339 187 23];
            app.ExportrawCSVButton.Text = 'Export raw CSV';

            % Create ExportandcoregisterCSVButton
            app.ExportandcoregisterCSVButton = uibutton(app.Scils_Extraction, 'push');
            app.ExportandcoregisterCSVButton.ButtonPushedFcn = createCallbackFcn(app, @ExportandcoregisterCSVButtonPushed, true);
            app.ExportandcoregisterCSVButton.FontWeight = 'bold';
            app.ExportandcoregisterCSVButton.Position = [386 297 167 23];
            app.ExportandcoregisterCSVButton.Text = 'Export and coregister CSV';

            % Create TabGroup2
            app.TabGroup2 = uitabgroup(app.UIFigure);
            app.TabGroup2.Visible = 'off';
            app.TabGroup2.Position = [618 -798 606 490];

            % Create ModeTab
            app.ModeTab = uitab(app.TabGroup2);
            app.ModeTab.Title = 'Mode';

            % Create MappingChoiceButtonGroup
            app.MappingChoiceButtonGroup = uibuttongroup(app.ModeTab);
            app.MappingChoiceButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @MappingChoiceButtonGroupSelectionChanged, true);
            app.MappingChoiceButtonGroup.Title = 'Mapping Choice';
            app.MappingChoiceButtonGroup.Position = [187 198 228 94];

            % Create OnlytopographicButton
            app.OnlytopographicButton = uiradiobutton(app.MappingChoiceButtonGroup);
            app.OnlytopographicButton.Text = 'Only topographic';
            app.OnlytopographicButton.Position = [11 48 113 22];

            % Create DmassspectometryButton_2
            app.DmassspectometryButton_2 = uiradiobutton(app.MappingChoiceButtonGroup);
            app.DmassspectometryButton_2.Text = '3D mass spectometry';
            app.DmassspectometryButton_2.Position = [11 26 149 22];
            app.DmassspectometryButton_2.Value = true;

            % Create LampOnlyTopo
            app.LampOnlyTopo = uilamp(app.MappingChoiceButtonGroup);
            app.LampOnlyTopo.Position = [191 50 20 20];
            app.LampOnlyTopo.Color = [1 0 0];

            % Create LampWithSpectro
            app.LampWithSpectro = uilamp(app.MappingChoiceButtonGroup);
            app.LampWithSpectro.Position = [191 25 20 20];
            app.LampWithSpectro.Color = [1 0 0];

            % Create DmassspectometryButton
            app.DmassspectometryButton = uiradiobutton(app.MappingChoiceButtonGroup);
            app.DmassspectometryButton.Text = '2D mass spectometry';
            app.DmassspectometryButton.Position = [10 5 138 22];

            % Create LampWithSpectro_2D
            app.LampWithSpectro_2D = uilamp(app.MappingChoiceButtonGroup);
            app.LampWithSpectro_2D.Position = [192 0 20 20];
            app.LampWithSpectro_2D.Color = [1 0 0];

            % Create NextButton_6
            app.NextButton_6 = uibutton(app.ModeTab, 'push');
            app.NextButton_6.ButtonPushedFcn = createCallbackFcn(app, @NextButton_6Pushed, true);
            app.NextButton_6.Position = [505 19 89 25];
            app.NextButton_6.Text = 'Next';

            % Create ButtonGroupMappingSpeed
            app.ButtonGroupMappingSpeed = uibuttongroup(app.ModeTab);
            app.ButtonGroupMappingSpeed.SelectionChangedFcn = createCallbackFcn(app, @ButtonGroupMappingSpeedSelectionChanged, true);
            app.ButtonGroupMappingSpeed.Position = [234 126 134 53];

            % Create WithrepositioningButton
            app.WithrepositioningButton = uiradiobutton(app.ButtonGroupMappingSpeed);
            app.WithrepositioningButton.Text = 'With repositioning';
            app.WithrepositioningButton.Position = [11 26 117 22];
            app.WithrepositioningButton.Value = true;

            % Create FastmappingButton
            app.FastmappingButton = uiradiobutton(app.ButtonGroupMappingSpeed);
            app.FastmappingButton.Text = 'Fast mapping';
            app.FastmappingButton.Position = [11 4 95 22];

            % Create AcquisitionPropertiesTab
            app.AcquisitionPropertiesTab = uitab(app.TabGroup2);
            app.AcquisitionPropertiesTab.Title = 'Acquisition Properties';

            % Create GeneratedmapfileEditFieldLabel
            app.GeneratedmapfileEditFieldLabel = uilabel(app.AcquisitionPropertiesTab);
            app.GeneratedmapfileEditFieldLabel.HorizontalAlignment = 'right';
            app.GeneratedmapfileEditFieldLabel.FontWeight = 'bold';
            app.GeneratedmapfileEditFieldLabel.Position = [45 423 113 22];
            app.GeneratedmapfileEditFieldLabel.Text = 'Generated map file';

            % Create GeneratedmapfileEditField
            app.GeneratedmapfileEditField = uieditfield(app.AcquisitionPropertiesTab, 'text');
            app.GeneratedmapfileEditField.ValueChangedFcn = createCallbackFcn(app, @GeneratedmapfileEditFieldValueChanged, true);
            app.GeneratedmapfileEditField.FontWeight = 'bold';
            app.GeneratedmapfileEditField.Position = [173 423 100 22];

            % Create mapLabel
            app.mapLabel = uilabel(app.AcquisitionPropertiesTab);
            app.mapLabel.FontWeight = 'bold';
            app.mapLabel.Position = [284 423 34 22];
            app.mapLabel.Text = '.map';

            % Create MappingStepmmEditFieldLabel
            app.MappingStepmmEditFieldLabel = uilabel(app.AcquisitionPropertiesTab);
            app.MappingStepmmEditFieldLabel.HorizontalAlignment = 'right';
            app.MappingStepmmEditFieldLabel.Position = [44 384 114 22];
            app.MappingStepmmEditFieldLabel.Text = 'Mapping Step  (mm)';

            % Create MappingStepmmEditField
            app.MappingStepmmEditField = uieditfield(app.AcquisitionPropertiesTab, 'numeric');
            app.MappingStepmmEditField.ValueChangedFcn = createCallbackFcn(app, @MappingStepmmEditFieldValueChanged, true);
            app.MappingStepmmEditField.Enable = 'off';
            app.MappingStepmmEditField.Position = [173 384 100 22];
            app.MappingStepmmEditField.Value = 0.5;

            % Create SurfaceoffestmmEditFieldLabel
            app.SurfaceoffestmmEditFieldLabel = uilabel(app.AcquisitionPropertiesTab);
            app.SurfaceoffestmmEditFieldLabel.HorizontalAlignment = 'right';
            app.SurfaceoffestmmEditFieldLabel.Position = [48 346 111 22];
            app.SurfaceoffestmmEditFieldLabel.Text = 'Surface offest (mm)';

            % Create SurfaceoffestmmEditField
            app.SurfaceoffestmmEditField = uieditfield(app.AcquisitionPropertiesTab, 'numeric');
            app.SurfaceoffestmmEditField.Enable = 'off';
            app.SurfaceoffestmmEditField.Position = [174 346 100 22];

            % Create ZonesizeXaxismmEditFieldLabel
            app.ZonesizeXaxismmEditFieldLabel = uilabel(app.AcquisitionPropertiesTab);
            app.ZonesizeXaxismmEditFieldLabel.HorizontalAlignment = 'right';
            app.ZonesizeXaxismmEditFieldLabel.Position = [318 384 125 22];
            app.ZonesizeXaxismmEditFieldLabel.Text = 'Zone size X axis (mm)';

            % Create ZonesizeXaxismmEditField
            app.ZonesizeXaxismmEditField = uieditfield(app.AcquisitionPropertiesTab, 'numeric');
            app.ZonesizeXaxismmEditField.ValueChangedFcn = createCallbackFcn(app, @ZonesizeXaxismmEditFieldValueChanged, true);
            app.ZonesizeXaxismmEditField.Enable = 'off';
            app.ZonesizeXaxismmEditField.Position = [458 384 100 22];
            app.ZonesizeXaxismmEditField.Value = 16;

            % Create ZonesizeYaxismmEditFieldLabel
            app.ZonesizeYaxismmEditFieldLabel = uilabel(app.AcquisitionPropertiesTab);
            app.ZonesizeYaxismmEditFieldLabel.HorizontalAlignment = 'right';
            app.ZonesizeYaxismmEditFieldLabel.Position = [318 346 125 22];
            app.ZonesizeYaxismmEditFieldLabel.Text = 'Zone size Y axis (mm)';

            % Create ZonesizeYaxismmEditField
            app.ZonesizeYaxismmEditField = uieditfield(app.AcquisitionPropertiesTab, 'numeric');
            app.ZonesizeYaxismmEditField.ValueChangedFcn = createCallbackFcn(app, @ZonesizeYaxismmEditFieldValueChanged, true);
            app.ZonesizeYaxismmEditField.Enable = 'off';
            app.ZonesizeYaxismmEditField.Position = [458 346 100 22];
            app.ZonesizeYaxismmEditField.Value = 16;

            % Create EstimationofmappingtimeLabel
            app.EstimationofmappingtimeLabel = uilabel(app.AcquisitionPropertiesTab);
            app.EstimationofmappingtimeLabel.Tooltip = {'Mapping time may differ from the estimation. This estimation is based on the number of pixels (Determined by the mapping step and area dimensions) and by the waiting time of the arm (Found in the Laser tab)'};
            app.EstimationofmappingtimeLabel.Position = [174 304 319 22];
            app.EstimationofmappingtimeLabel.Text = 'Estimation of mapping time : ';

            % Create MaximumheightmmofthesampleEditFieldLabel
            app.MaximumheightmmofthesampleEditFieldLabel = uilabel(app.AcquisitionPropertiesTab);
            app.MaximumheightmmofthesampleEditFieldLabel.HorizontalAlignment = 'right';
            app.MaximumheightmmofthesampleEditFieldLabel.Position = [48 243 205 22];
            app.MaximumheightmmofthesampleEditFieldLabel.Text = 'Maximum height (mm)  of the sample';

            % Create MaximumheightmmofthesampleEditField
            app.MaximumheightmmofthesampleEditField = uieditfield(app.AcquisitionPropertiesTab, 'numeric');
            app.MaximumheightmmofthesampleEditField.Enable = 'off';
            app.MaximumheightmmofthesampleEditField.Position = [266 243 100 22];
            app.MaximumheightmmofthesampleEditField.Value = 10;

            % Create FisrtmappingpointXpositionmmEditFieldLabel
            app.FisrtmappingpointXpositionmmEditFieldLabel = uilabel(app.AcquisitionPropertiesTab);
            app.FisrtmappingpointXpositionmmEditFieldLabel.HorizontalAlignment = 'right';
            app.FisrtmappingpointXpositionmmEditFieldLabel.Position = [59 203 196 22];
            app.FisrtmappingpointXpositionmmEditFieldLabel.Text = 'Fisrt mapping point X position (mm)';

            % Create FisrtmappingpointXpositionmmEditField
            app.FisrtmappingpointXpositionmmEditField = uieditfield(app.AcquisitionPropertiesTab, 'numeric');
            app.FisrtmappingpointXpositionmmEditField.Enable = 'off';
            app.FisrtmappingpointXpositionmmEditField.Position = [270 203 100 22];
            app.FisrtmappingpointXpositionmmEditField.Value = 150;

            % Create NextButton_7
            app.NextButton_7 = uibutton(app.AcquisitionPropertiesTab, 'push');
            app.NextButton_7.ButtonPushedFcn = createCallbackFcn(app, @NextButton_7Pushed, true);
            app.NextButton_7.Enable = 'off';
            app.NextButton_7.Position = [505 19 89 25];
            app.NextButton_7.Text = 'Next';

            % Create RobotTab
            app.RobotTab = uitab(app.TabGroup2);
            app.RobotTab.Title = 'Robot';

            % Create RobotDropDownLabel
            app.RobotDropDownLabel = uilabel(app.RobotTab);
            app.RobotDropDownLabel.HorizontalAlignment = 'right';
            app.RobotDropDownLabel.Position = [157 423 41 22];
            app.RobotDropDownLabel.Text = 'Robot ';

            % Create RobotDropDown
            app.RobotDropDown = uidropdown(app.RobotTab);
            app.RobotDropDown.Position = [213 423 231 22];

            % Create RobotConnexionB
            app.RobotConnexionB = uibutton(app.RobotTab, 'push');
            app.RobotConnexionB.ButtonPushedFcn = createCallbackFcn(app, @RobotConnexionBButtonPushed, true);
            app.RobotConnexionB.FontWeight = 'bold';
            app.RobotConnexionB.Position = [102 374 101 22];
            app.RobotConnexionB.Text = 'Connect Robot';

            % Create StateLampRobot
            app.StateLampRobot = uilamp(app.RobotTab);
            app.StateLampRobot.Position = [293 374 20 20];
            app.StateLampRobot.Color = [1 0 0];

            % Create DisconnectRobotButton
            app.DisconnectRobotButton = uibutton(app.RobotTab, 'push');
            app.DisconnectRobotButton.ButtonPushedFcn = createCallbackFcn(app, @DisconnectRobotButtonPushed, true);
            app.DisconnectRobotButton.Interruptible = 'off';
            app.DisconnectRobotButton.FontWeight = 'bold';
            app.DisconnectRobotButton.Enable = 'off';
            app.DisconnectRobotButton.Position = [415 372 118 22];
            app.DisconnectRobotButton.Text = 'Disconnect Robot';

            % Create XPositionEditFieldLabel
            app.XPositionEditFieldLabel = uilabel(app.RobotTab);
            app.XPositionEditFieldLabel.HorizontalAlignment = 'right';
            app.XPositionEditFieldLabel.Position = [28 303 60 22];
            app.XPositionEditFieldLabel.Text = 'X Position';

            % Create XPositionEditField
            app.XPositionEditField = uieditfield(app.RobotTab, 'numeric');
            app.XPositionEditField.Enable = 'off';
            app.XPositionEditField.Position = [103 303 47 22];
            app.XPositionEditField.Value = 150;

            % Create YPositionEditFieldLabel
            app.YPositionEditFieldLabel = uilabel(app.RobotTab);
            app.YPositionEditFieldLabel.HorizontalAlignment = 'right';
            app.YPositionEditFieldLabel.Position = [188 303 60 22];
            app.YPositionEditFieldLabel.Text = 'Y Position';

            % Create YPositionEditField
            app.YPositionEditField = uieditfield(app.RobotTab, 'numeric');
            app.YPositionEditField.Enable = 'off';
            app.YPositionEditField.Position = [263 303 51 22];
            app.YPositionEditField.Value = 2;

            % Create ZPositionEditFieldLabel
            app.ZPositionEditFieldLabel = uilabel(app.RobotTab);
            app.ZPositionEditFieldLabel.HorizontalAlignment = 'right';
            app.ZPositionEditFieldLabel.Position = [333 303 59 22];
            app.ZPositionEditFieldLabel.Text = 'Z Position';

            % Create ZPositionEditField
            app.ZPositionEditField = uieditfield(app.RobotTab, 'numeric');
            app.ZPositionEditField.Enable = 'off';
            app.ZPositionEditField.Position = [407 303 58 22];
            app.ZPositionEditField.Value = 100;

            % Create GOTOButton
            app.GOTOButton = uibutton(app.RobotTab, 'push');
            app.GOTOButton.ButtonPushedFcn = createCallbackFcn(app, @GOTOButtonPushed, true);
            app.GOTOButton.Interruptible = 'off';
            app.GOTOButton.FontWeight = 'bold';
            app.GOTOButton.Enable = 'off';
            app.GOTOButton.Position = [485 303 100 22];
            app.GOTOButton.Text = 'GO TO';

            % Create NextButton_8
            app.NextButton_8 = uibutton(app.RobotTab, 'push');
            app.NextButton_8.ButtonPushedFcn = createCallbackFcn(app, @NextButton_8Pushed, true);
            app.NextButton_8.Enable = 'off';
            app.NextButton_8.Position = [505 19 89 25];
            app.NextButton_8.Text = 'Next';

            % Create SensorTab
            app.SensorTab = uitab(app.TabGroup2);
            app.SensorTab.Title = 'Sensor';

            % Create SensorDropDownLabel
            app.SensorDropDownLabel = uilabel(app.SensorTab);
            app.SensorDropDownLabel.HorizontalAlignment = 'right';
            app.SensorDropDownLabel.Position = [127 414 43 22];
            app.SensorDropDownLabel.Text = 'Sensor';

            % Create SensorDropDown
            app.SensorDropDown = uidropdown(app.SensorTab);
            app.SensorDropDown.Position = [185 414 211 22];

            % Create LaunchSensorCalibrationButton
            app.LaunchSensorCalibrationButton = uibutton(app.SensorTab, 'push');
            app.LaunchSensorCalibrationButton.ButtonPushedFcn = createCallbackFcn(app, @LaunchSensorCalibrationButtonPushed, true);
            app.LaunchSensorCalibrationButton.Interruptible = 'off';
            app.LaunchSensorCalibrationButton.FontWeight = 'bold';
            app.LaunchSensorCalibrationButton.Enable = 'off';
            app.LaunchSensorCalibrationButton.Position = [171 283 168 22];
            app.LaunchSensorCalibrationButton.Text = 'Launch Sensor Calibration';

            % Create CalibrationstateLabel
            app.CalibrationstateLabel = uilabel(app.SensorTab);
            app.CalibrationstateLabel.HorizontalAlignment = 'right';
            app.CalibrationstateLabel.Position = [375 281 140 22];
            app.CalibrationstateLabel.Text = 'Sensor Calibration state :';

            % Create SensorCalibrationstateLamp
            app.SensorCalibrationstateLamp = uilamp(app.SensorTab);
            app.SensorCalibrationstateLamp.Position = [530 283 20 20];
            app.SensorCalibrationstateLamp.Color = [1 0 0];

            % Create ConnectSensorButton
            app.ConnectSensorButton = uibutton(app.SensorTab, 'push');
            app.ConnectSensorButton.ButtonPushedFcn = createCallbackFcn(app, @ConnectSensorButtonPushed, true);
            app.ConnectSensorButton.Interruptible = 'off';
            app.ConnectSensorButton.FontWeight = 'bold';
            app.ConnectSensorButton.Position = [202 373 168 23];
            app.ConnectSensorButton.Text = 'Connect Sensor';

            % Create NextButton_9
            app.NextButton_9 = uibutton(app.SensorTab, 'push');
            app.NextButton_9.ButtonPushedFcn = createCallbackFcn(app, @NextButton_9Pushed, true);
            app.NextButton_9.Position = [505 19 89 25];
            app.NextButton_9.Text = 'Next';

            % Create LaserTab
            app.LaserTab = uitab(app.TabGroup2);
            app.LaserTab.Title = 'Laser';

            % Create LaserDropDownLabel
            app.LaserDropDownLabel = uilabel(app.LaserTab);
            app.LaserDropDownLabel.HorizontalAlignment = 'right';
            app.LaserDropDownLabel.Position = [199 423 36 22];
            app.LaserDropDownLabel.Text = 'Laser';

            % Create LaserDropDown
            app.LaserDropDown = uidropdown(app.LaserTab);
            app.LaserDropDown.Items = {'Opotek IR Radiant', 'Opolette'};
            app.LaserDropDown.Position = [250 423 146 22];
            app.LaserDropDown.Value = 'Opotek IR Radiant';

            % Create ConnectLaserButton
            app.ConnectLaserButton = uibutton(app.LaserTab, 'push');
            app.ConnectLaserButton.ButtonPushedFcn = createCallbackFcn(app, @ConnectLaserButtonPushed, true);
            app.ConnectLaserButton.FontWeight = 'bold';
            app.ConnectLaserButton.Position = [132 377 100 22];
            app.ConnectLaserButton.Text = 'Connect Laser';

            % Create StateLampOpotek
            app.StateLampOpotek = uilamp(app.LaserTab);
            app.StateLampOpotek.Position = [302 378 20 20];
            app.StateLampOpotek.Color = [1 0 0];

            % Create DisconnectButton
            app.DisconnectButton = uibutton(app.LaserTab, 'push');
            app.DisconnectButton.ButtonPushedFcn = createCallbackFcn(app, @DisconnectButtonPushed, true);
            app.DisconnectButton.Interruptible = 'off';
            app.DisconnectButton.FontWeight = 'bold';
            app.DisconnectButton.Enable = 'off';
            app.DisconnectButton.Position = [394 377 100 22];
            app.DisconnectButton.Text = 'Disconnect ';

            % Create GetTempButton
            app.GetTempButton = uibutton(app.LaserTab, 'push');
            app.GetTempButton.ButtonPushedFcn = createCallbackFcn(app, @GetTempButtonPushed, true);
            app.GetTempButton.Interruptible = 'off';
            app.GetTempButton.FontWeight = 'bold';
            app.GetTempButton.Enable = 'off';
            app.GetTempButton.Position = [132 323 100 22];
            app.GetTempButton.Text = 'Get Temp';

            % Create AffichageTemperature
            app.AffichageTemperature = uilabel(app.LaserTab);
            app.AffichageTemperature.Position = [357 323 138 22];
            app.AffichageTemperature.Text = 'Temperature : NO_DATA';

            % Create TurnLampOnButton
            app.TurnLampOnButton = uibutton(app.LaserTab, 'push');
            app.TurnLampOnButton.ButtonPushedFcn = createCallbackFcn(app, @TurnLampOnButtonPushed, true);
            app.TurnLampOnButton.Interruptible = 'off';
            app.TurnLampOnButton.FontWeight = 'bold';
            app.TurnLampOnButton.Enable = 'off';
            app.TurnLampOnButton.Position = [132 280 100 22];
            app.TurnLampOnButton.Text = 'Turn Lamp On ';

            % Create Lamp_LampONorOFF
            app.Lamp_LampONorOFF = uilamp(app.LaserTab);
            app.Lamp_LampONorOFF.Position = [302 282 20 20];
            app.Lamp_LampONorOFF.Color = [1 0 0];

            % Create TurnLampOffButton
            app.TurnLampOffButton = uibutton(app.LaserTab, 'push');
            app.TurnLampOffButton.ButtonPushedFcn = createCallbackFcn(app, @TurnLampOffButtonPushed, true);
            app.TurnLampOffButton.Interruptible = 'off';
            app.TurnLampOffButton.FontWeight = 'bold';
            app.TurnLampOffButton.Enable = 'off';
            app.TurnLampOffButton.Position = [394 281 100 22];
            app.TurnLampOffButton.Text = 'Turn Lamp Off';

            % Create GetStateButton
            app.GetStateButton = uibutton(app.LaserTab, 'push');
            app.GetStateButton.ButtonPushedFcn = createCallbackFcn(app, @GetStateButtonPushed, true);
            app.GetStateButton.Interruptible = 'off';
            app.GetStateButton.FontWeight = 'bold';
            app.GetStateButton.Enable = 'off';
            app.GetStateButton.Position = [132 232 100 22];
            app.GetStateButton.Text = 'Get State';

            % Create AffichageState
            app.AffichageState = uilabel(app.LaserTab);
            app.AffichageState.Position = [361 224 213 31];
            app.AffichageState.Text = 'State : NO_DATA';

            % Create MicroprobefocaldistanceinZaxismmEditFieldLabel
            app.MicroprobefocaldistanceinZaxismmEditFieldLabel = uilabel(app.LaserTab);
            app.MicroprobefocaldistanceinZaxismmEditFieldLabel.HorizontalAlignment = 'right';
            app.MicroprobefocaldistanceinZaxismmEditFieldLabel.Position = [70 190 227 22];
            app.MicroprobefocaldistanceinZaxismmEditFieldLabel.Text = 'Microprobe focal distance in Z axis (mm) ';

            % Create MicroprobefocaldistanceinZaxismmEditField
            app.MicroprobefocaldistanceinZaxismmEditField = uieditfield(app.LaserTab, 'numeric');
            app.MicroprobefocaldistanceinZaxismmEditField.Enable = 'off';
            app.MicroprobefocaldistanceinZaxismmEditField.Position = [321 190 43 22];
            app.MicroprobefocaldistanceinZaxismmEditField.Value = 80;

            % Create NextButton_10
            app.NextButton_10 = uibutton(app.LaserTab, 'push');
            app.NextButton_10.ButtonPushedFcn = createCallbackFcn(app, @NextButton_10Pushed, true);
            app.NextButton_10.Position = [505 19 89 25];
            app.NextButton_10.Text = 'Next';

            % Create ContinuousLaserCheckBox
            app.ContinuousLaserCheckBox = uicheckbox(app.LaserTab);
            app.ContinuousLaserCheckBox.ValueChangedFcn = createCallbackFcn(app, @ContinuousLaserCheckBoxValueChanged, true);
            app.ContinuousLaserCheckBox.Enable = 'off';
            app.ContinuousLaserCheckBox.Text = 'Continuous Laser';
            app.ContinuousLaserCheckBox.Position = [415 142 116 22];

            % Create EnergylevelVSpinnerLabel
            app.EnergylevelVSpinnerLabel = uilabel(app.LaserTab);
            app.EnergylevelVSpinnerLabel.HorizontalAlignment = 'right';
            app.EnergylevelVSpinnerLabel.Position = [46 142 91 22];
            app.EnergylevelVSpinnerLabel.Text = 'Energy level (V)';

            % Create EnergylevelVSpinner
            app.EnergylevelVSpinner = uispinner(app.LaserTab);
            app.EnergylevelVSpinner.ValueChangedFcn = createCallbackFcn(app, @EnergylevelVSpinnerValueChanged, true);
            app.EnergylevelVSpinner.Enable = 'off';
            app.EnergylevelVSpinner.Position = [152 142 100 22];
            app.EnergylevelVSpinner.Value = 682;

            % Create LampVoltageSet
            app.LampVoltageSet = uilamp(app.LaserTab);
            app.LampVoltageSet.Position = [302 144 20 20];

            % Create LaunchBurstButton
            app.LaunchBurstButton = uibutton(app.LaserTab, 'push');
            app.LaunchBurstButton.ButtonPushedFcn = createCallbackFcn(app, @LaunchBurstButtonPushed, true);
            app.LaunchBurstButton.Interruptible = 'off';
            app.LaunchBurstButton.FontWeight = 'bold';
            app.LaunchBurstButton.Enable = 'off';
            app.LaunchBurstButton.Position = [394 60 99 22];
            app.LaunchBurstButton.Text = 'Launch Burst ';

            % Create TimebetweenlaserburstssecondEditFieldLabel
            app.TimebetweenlaserburstssecondEditFieldLabel = uilabel(app.LaserTab);
            app.TimebetweenlaserburstssecondEditFieldLabel.HorizontalAlignment = 'right';
            app.TimebetweenlaserburstssecondEditFieldLabel.Position = [27 98 209 22];
            app.TimebetweenlaserburstssecondEditFieldLabel.Text = 'Time between laser bursts (second)';

            % Create TimebetweenlaserburstssecondEditField
            app.TimebetweenlaserburstssecondEditField = uieditfield(app.LaserTab, 'numeric');
            app.TimebetweenlaserburstssecondEditField.ValueChangedFcn = createCallbackFcn(app, @TimebetweenlaserburstssecondEditFieldValueChanged, true);
            app.TimebetweenlaserburstssecondEditField.Enable = 'off';
            app.TimebetweenlaserburstssecondEditField.Position = [251 98 100 22];
            app.TimebetweenlaserburstssecondEditField.Value = 3;

            % Create NumberoflasershotsburstmodeEditFieldLabel
            app.NumberoflasershotsburstmodeEditFieldLabel = uilabel(app.LaserTab);
            app.NumberoflasershotsburstmodeEditFieldLabel.HorizontalAlignment = 'right';
            app.NumberoflasershotsburstmodeEditFieldLabel.Position = [41 60 195 22];
            app.NumberoflasershotsburstmodeEditFieldLabel.Text = 'Number of laser shots (burst mode)';

            % Create NumberoflasershotsburstmodeEditField
            app.NumberoflasershotsburstmodeEditField = uieditfield(app.LaserTab, 'numeric');
            app.NumberoflasershotsburstmodeEditField.ValueChangedFcn = createCallbackFcn(app, @NumberoflasershotsburstmodeEditFieldValueChanged, true);
            app.NumberoflasershotsburstmodeEditField.Enable = 'off';
            app.NumberoflasershotsburstmodeEditField.Position = [251 60 100 22];
            app.NumberoflasershotsburstmodeEditField.Value = 3;

            % Create RecapTab
            app.RecapTab = uitab(app.TabGroup2);
            app.RecapTab.Title = 'Recap';

            % Create GotoPositionButton
            app.GotoPositionButton = uibutton(app.RecapTab, 'push');
            app.GotoPositionButton.ButtonPushedFcn = createCallbackFcn(app, @GotoPositionButtonPushed, true);
            app.GotoPositionButton.Interruptible = 'off';
            app.GotoPositionButton.FontWeight = 'bold';
            app.GotoPositionButton.Position = [471 98 100 22];
            app.GotoPositionButton.Text = 'Go to Position';

            % Create ClearMapButton
            app.ClearMapButton = uibutton(app.RecapTab, 'push');
            app.ClearMapButton.ButtonPushedFcn = createCallbackFcn(app, @ClearMapButtonPushed, true);
            app.ClearMapButton.FontWeight = 'bold';
            app.ClearMapButton.Position = [472 61 100 22];
            app.ClearMapButton.Text = 'Clear Map';

            % Create NoMappingLabel
            app.NoMappingLabel = uilabel(app.RecapTab);
            app.NoMappingLabel.Position = [26 25 199 22];
            app.NoMappingLabel.Text = 'No Mapping';

            % Create LaunchMappingButton
            app.LaunchMappingButton = uibutton(app.RecapTab, 'push');
            app.LaunchMappingButton.ButtonPushedFcn = createCallbackFcn(app, @LaunchMappingButtonPushed, true);
            app.LaunchMappingButton.Interruptible = 'off';
            app.LaunchMappingButton.FontWeight = 'bold';
            app.LaunchMappingButton.Position = [215 25 163 22];
            app.LaunchMappingButton.Text = 'Launch Mapping';

            % Create STOPCONTINUOUSLASERButton_2
            app.STOPCONTINUOUSLASERButton_2 = uibutton(app.RecapTab, 'push');
            app.STOPCONTINUOUSLASERButton_2.ButtonPushedFcn = createCallbackFcn(app, @STOPCONTINUOUSLASERButton_2Pushed, true);
            app.STOPCONTINUOUSLASERButton_2.FontWeight = 'bold';
            app.STOPCONTINUOUSLASERButton_2.FontColor = [1 0 0];
            app.STOPCONTINUOUSLASERButton_2.Position = [23 66 131 38];
            app.STOPCONTINUOUSLASERButton_2.Text = {'STOP CONTINUOUS'; 'LASER'};

            % Create QuittoMenuButton_2
            app.QuittoMenuButton_2 = uibutton(app.RecapTab, 'push');
            app.QuittoMenuButton_2.ButtonPushedFcn = createCallbackFcn(app, @QuittoMenuButton_2Pushed, true);
            app.QuittoMenuButton_2.Position = [475 25 91 23];
            app.QuittoMenuButton_2.Text = 'Quit to Menu';

            % Create RobotStateOffLabel
            app.RobotStateOffLabel = uilabel(app.RecapTab);
            app.RobotStateOffLabel.Position = [47 350 115 23];
            app.RobotStateOffLabel.Text = 'Robot State: Off';

            % Create LaserStateOffLabel
            app.LaserStateOffLabel = uilabel(app.RecapTab);
            app.LaserStateOffLabel.Position = [49 272 184 23];
            app.LaserStateOffLabel.Text = 'Laser State: Off';

            % Create MappingMode3DMassSpectrometryLabel
            app.MappingMode3DMassSpectrometryLabel = uilabel(app.RecapTab);
            app.MappingMode3DMassSpectrometryLabel.Position = [47 382 214 23];
            app.MappingMode3DMassSpectrometryLabel.Text = 'Mapping Mode: 3D Mass Spectrometry';

            % Create MapDimensionsmmLabel
            app.MapDimensionsmmLabel = uilabel(app.RecapTab);
            app.MapDimensionsmmLabel.Position = [286 381 126 23];
            app.MapDimensionsmmLabel.Text = 'Map Dimensions (mm)';

            % Create XLabel
            app.XLabel = uilabel(app.RecapTab);
            app.XLabel.Position = [411 377 84 23];
            app.XLabel.Text = 'X:';

            % Create YLabel
            app.YLabel = uilabel(app.RecapTab);
            app.YLabel.Position = [497 381 84 23];
            app.YLabel.Text = 'Y:';

            % Create Resolutionm500Label
            app.Resolutionm500Label = uilabel(app.RecapTab);
            app.Resolutionm500Label.Position = [283 347 249 23];
            app.Resolutionm500Label.Text = 'Resolution (µm): 500';

            % Create SensorStateOffLabel
            app.SensorStateOffLabel = uilabel(app.RecapTab);
            app.SensorStateOffLabel.Position = [44 312 222 23];
            app.SensorStateOffLabel.Text = 'Sensor State: Off';

            % Create ETALabel
            app.ETALabel = uilabel(app.RecapTab);
            app.ETALabel.Position = [286 295 247 23];
            app.ETALabel.Text = 'ETA: ';

            % Create OMGMSIChooseyourmodePanel
            app.OMGMSIChooseyourmodePanel = uipanel(app.UIFigure);
            app.OMGMSIChooseyourmodePanel.Title = 'OMG-MSI - Choose your mode';
            app.OMGMSIChooseyourmodePanel.Position = [-1 1 265 220];

            % Create InterfaceModeButtonGroup
            app.InterfaceModeButtonGroup = uibuttongroup(app.OMGMSIChooseyourmodePanel);
            app.InterfaceModeButtonGroup.Title = 'Interface Mode';
            app.InterfaceModeButtonGroup.Position = [66 65 131 90];

            % Create DataacquisitionButton
            app.DataacquisitionButton = uiradiobutton(app.InterfaceModeButtonGroup);
            app.DataacquisitionButton.Text = 'Data acquisition';
            app.DataacquisitionButton.Position = [11 30 107 22];
            app.DataacquisitionButton.Value = true;

            % Create DataprocessingButton
            app.DataprocessingButton = uiradiobutton(app.InterfaceModeButtonGroup);
            app.DataprocessingButton.Text = 'Data processing';
            app.DataprocessingButton.Position = [11 8 109 22];

            % Create ProceedButton
            app.ProceedButton = uibutton(app.OMGMSIChooseyourmodePanel, 'push');
            app.ProceedButton.ButtonPushedFcn = createCallbackFcn(app, @ProceedButtonPushed, true);
            app.ProceedButton.Position = [181 13 65 25];
            app.ProceedButton.Text = 'Proceed';

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