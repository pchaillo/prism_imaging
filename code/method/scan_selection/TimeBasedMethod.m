classdef TimeBasedMethod

    properties

    end

    methods

        function init(method,app)

        end

        function [bio_dat ,time,g] = selection(method, mzXML_data, carte_time, aspiration_time)

            path(path,'code/for_image_building/TimeBased') % Ranger ca ou ? => Ici c'est bien non ? #TODO
            path(path,'code/for_image_building/for_scan_selection/TimeBased') % Ranger ca ou ? => Ici c'est bien non ? #TODO
            path(path,'code/for_image_building/for_scan_selection')
            path(path,'code/for_processing') 
            % Insert laser connexion and return connection object variable
            [bio_dat ,time,g] = continuous_detection(mzXML_data, carte_time, aspiration_time); % take only the useful informations

        end
    end
end