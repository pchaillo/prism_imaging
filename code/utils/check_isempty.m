function check_isempty(data,file_type_text)

% Check if the field is empty, and if it is, send a message text

if isempty(data)
    message = strcat('Warning: Blank name for file of type [', file_type_text, ']');
    update_log(app, message)
    f = msgbox(message);
end