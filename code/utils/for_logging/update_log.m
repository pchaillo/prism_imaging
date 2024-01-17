function update_log(app, log, msg)  %WIP 
log = strcat(log, newline, msg);
app.TextArea.Value = log;
app.TextArea2.Value = log;
app.LogTextArea.Value = log;
% If any additionnal textbox needs to be updated, add it here