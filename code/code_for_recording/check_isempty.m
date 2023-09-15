function check_isempty(data,file_type_text)

% Check if the field is empty, and if it is, send a message text

if isempty(data)
    message = strcat('ATTENTION : nom du fichier [', file_type_text, '] non renseigne => indispensable pour la reconstruction');
    disp(message)
    f = msgbox(message);
end