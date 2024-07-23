function map_file = gui_load_map(app)

map_name_r = app.MapFileEditField.Value;
map_name = strcat(app.workdir, '\files\map files\', map_name_r,'.map');
map_file = load_map_fcn(map_name);

end

