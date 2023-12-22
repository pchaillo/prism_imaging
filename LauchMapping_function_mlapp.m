        function LaunchMappingButtonPushed(app, event)

 app.NoMappingLabel.Text = 'Mapping in progress...';

            % Variables initialisation
            % global scan;
            % global zone;
            global parameters
            global state;

            state.arret = 0; % permet arret securité total en cas de soucis

            global map;
        
            global laser;

             %   global t; % obsolete, remplace par robot.connexion
            global robot;
            global sensor;

            %% Parameters => Import user parameters from the GUI
            nom_1 = app.MapNameEditField.Value;
            check_isempty(nom_1,'.map');
            nom = strcat(nom_1,'.map');
            parameters.mapping_step = app.MappingStepmmEditField.Value;         % mapping step in mm
            parameters.maximal_height = app.MaximumheightmmofthesampleEditField.Value;         % maximum height (mm) of the sample you want to map, add a little bit more than real height
            parameters.x_offset = app.FisrtmappingpointXpositionmmEditField.Value;         % x offset (mm) between the robot base and the robot head
            parameters.dim_x = app.ZonesizeXaxismmEditField.Value;        % dimension of the mapping zone in the x axis, should be an even value % Even value only ???? #TODO
            parameters.dim_y = app.ZonesizeYaxismmEditField.Value;        % dimension of the mapping zone in the y axis, should be an even value
            parameters.surface_offset = app.SurfaceoffestmmEditField.Value;        % surface offset in mm
            parameters.initial_height = app.MicroprobefocaldistanceinZaxismmEditField.Value + scan.s_offset;          % z offset between the robot arm and the sample to be analysed

            scan.voltage_value = app.EnergylevelVSpinner.Value; % With some laser, you may set the voltage you want in order to tune the intensity of the laser % use different variable for laser parameters ? #TODO
            scan.t_b = app.TimebetweentwolasershotsecondEditField.Value; % pause time between two laser shot, in second
            scan.nb_shot = app.NumberoflasershotburstmodeEditField.Value; % number of shot for the burst mode
            %             biometrical_scanning = 1; % 0 only topographical / 1 total scanning % useless ? #TODO

            % Mapping Variable %
            scan.etal = 0.25; % pas d'étallonage => 0.25 mm recommandé / step of the camera calibration
            scan.pre = 2; % multiplier for the number of point in the map from the scanning : if scanning step=1mm then a factor of 1 will keep this resolution, a factor of two will create a map with point every 0.5mm

            laser.continuous_flag = app.ContinuousLaserCheckBox.Value; % 0 => no continuous / 1 => continuous

            seuil = 0; % used in record_map4 => useful ? #TODO

            parameters.fast_flag = app.FastMappingButton.Value; % I think it's a variable to not do repositionning if it's difficult to get height data from depth sensor

            ard = sensor.connexion; % connect the arduino for spectro triggering) 

            pos_i= [zone.dec  2  parameters.initial_height 180 0 180]; % initial position
            robot.class.set_position(robot.connexion,pos_i);  % send the mapping initial position of the robot

            %% To select and launch the mapping code
            if app.WithMassSpectometryButton.Value %% For 3D imaging with Mass Spectrometry
                time_ref = trigger_spectro_time(ard);
                real_time_mapping_scanning_2(robot,sensor,laser,scan.t_b,scan.nb_shot,time_ref); % do the mapping step
            elseif app.OnlyTopographicButton.Value %% For 3D acquisition only (without mass spectrometry)
                map = topographic_mapping(robot,sensor);
            elseif app.DMassSpectometryButton.Value  %% For 2D imaging with Mass Spectrometry
                time_ref = trigger_spectro_time(ard);
                scanning_2d_2(robot,laser,scan.nb_shot,scan.t_b,time_ref);
            else
                disp('ERROR - Mapping choice problem');
            end

            %[ map.r, nb_err ] = recti(map.i); % correction of the map %%( delete impossible values ) #TODO
            map.r = map.i; % two time the same ! #TODO
            figure(4)
            subplot(2,4,[1,2,5,6]), mesh(map.x,map.y,map.i); % initial map
            axis equal
            subplot(2,4,[3,4,7,8]), mesh(map.x,map.y,map.r); % rectified map
            axis equal

            time_rec = record_map(map.x,map.y,map.r,nom,seuil,false,map.time);

            time_text = strcat('Map finished. Recommended reconstruction time : ',time_rec);
            app.NoMappingLabel.Text = time_text;

            % once the map is done, go back to the 1st point position
            pos_d_i= [zone.dec  2  parameters.initial_height 180 0 180];
            robot.class.set_position(robot.connexion,pos_d_i);  % send the mapping initial position of the robot

            % hugh_to_sleep(t);

end