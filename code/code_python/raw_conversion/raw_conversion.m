function raw_conversion(app, raw_path, txt_path, output_path,filename)

% Uses msconvert to generate mzML files
% Could be repurposed to generate other file types if needed

command = strcat("msconvert ", '"', raw_path, '"', " -c ", '"', txt_path, ...
    '"', " -o ", output_path, " --outfile ", filename   ,' --mzML');
disp(command)
disp(output_path)

state = system(command);

 if state == 0
     update_log(app, "File converted!")
 else 
     update_log(app, "Something went wrong. Check the raw_conversion " + ...
         "function and integrity of the raw file.")
 end


end

