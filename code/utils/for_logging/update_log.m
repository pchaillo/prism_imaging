function update_log(app, msg)   

global info_log

disp(msg) % to get message on command window

new_log = [info_log, newline, string(datetime), msg];
info_log = new_log;

app.TextArea.Value = new_log;
app.TextArea2.Value = new_log;
app.LogTextArea.Value = new_log;
% If any additionnal textbox needs to be updated, add it here
end