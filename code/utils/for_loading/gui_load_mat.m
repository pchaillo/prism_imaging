function mat_file = gui_load_mat(app)

% Loads the mat file specified in the corresponding field of the interface
mat_file_r = app.MatFileEditField.Value;
mat_name = strcat(app.workdir, "\files\mat files\", mat_file_r,'.mat');
mat_file = load(mat_name);

end

