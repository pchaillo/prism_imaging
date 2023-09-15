function check_isempty(data,file_type_text)

% Check if the field is empty, and if it is, send a message text

if isempty(data)
    message = strcat('ATTENTION : file of type [', file_type_text, '] name not filled');
    disp(message)
    f = msgbox(message);
end