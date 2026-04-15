function  multiple_mzML_generator(app, raw_path, pixels_scans, output_file_loc, name)

name_folder = strcat(name,"\");
txt_file_loc = strrep(output_file_loc, "mzML_files\", "txt_files\");
txt_folder_path = strcat(txt_file_loc, "\", name_folder);
disp(txt_folder_path)
mkdir(txt_folder_path)

% mzML_folder_path = path_editor(output_file_loc,name_folder);
mzML_folder_path = strcat(output_file_loc, name_folder);
mkdir(mzML_folder_path)

l = length(pixels_scans);

if l > 100
    % Initialize the progress bar
    queue = createParallelProgressBar(l);
    parfor i = 1 : l
        num_list = pixels_scans(i).deisotoped;
        txt_path_pixel = strcat(txt_folder_path, name , "_" , string(i),".txt");
        export_to_txt(txt_path_pixel,num_list);
        mzML_pixel_name = strcat( name , "_" , string(i));
        raw_conversion(app, raw_path, txt_path_pixel, mzML_folder_path, mzML_pixel_name, false)
        send(queue, i)
    end
else
    
    for i = 1 : l % Working, but not adapted to the rest of the pipeline, with pixels_scans as an argument
        num_list = pixels_scans(i).deisotoped;
        txt_path_pixel = strcat(txt_folder_path, name , "_" , string(i),".txt");
        export_to_txt(txt_path_pixel,num_list);
        mzML_pixel_name = strcat( name , "_" , string(i));
        raw_conversion(app, raw_path, txt_path_pixel, mzML_folder_path, mzML_pixel_name, false)
    end
end

update_log(app, "Files exported in the project's mzML folder.")



