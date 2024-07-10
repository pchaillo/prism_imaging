function raw_conversion(app, raw_path, txt_path, output_path)
% Uses MSConvert to generate mzML files
% Could be repurposed to generate other file types if needed

command = strcat("msconvert ", '"', raw_path, '" ', "-c ", '"', txt_path, ...
    '" ', "-o ", '"', output_path, " --mzML");

state = system(command);

if state ==0
    update_log(app, "File converted!")
else 
    update_log(app, "Something went wrong. Check the raw_conversion " + ...
        "function and the integrity of the raw and txt files.")
end 

end

