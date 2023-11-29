classdef TimeBasedMethod

    properties

    end

    methods

        function init(method,app)

        end

        function [bio_dat ,time,g] = selection(method,mzXML_data , carte_time)

            path(path,'code/code_for_preprocessing/TimeBased') % Ranger ca ou ? #TODO
            % Insert laser connexion and return connection object variable
            [bio_dat ,time,g] = continuous_detection(mzXML_data,carte_time); % take only the useful informations

        end
    end
end