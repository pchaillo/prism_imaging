function update_log(app, log, msg)   
log = [log, newline, string(datetime), msg];
app.info_log = log;

app.TextArea.Value = log;
app.TextArea2.Value = log;
app.LogTextArea.Value = log;
% If any additionnal textbox needs to be updated, add it here