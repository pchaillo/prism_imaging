function  multiple_mzML_generator(app, raw_path, folder_txt, pixels_scans, output_file_loc,name)

name_folder = strcat(name,"\");
txt_folder_path = path_editor(folder_txt,name_folder);
mkdir(txt_folder_path)

name_folder = strcat(name,"\");
% mzML_folder_path = path_editor(output_file_loc,name_folder);
mzML_folder_path = strcat(output_file_loc, name_folder);
mkdir(mzML_folder_path)

l = length(pixels_scans);
for i = 1 : l % Working, but not adapted to the rest of the pipeline, avec pixels_scans en argument
    num_list = pixels_scans(i).deisotoped;
    txt_path_pixel = strcat(txt_folder_path, name , "_" , string(i),".txt");
    export_to_txt(txt_path_pixel,num_list);
    mzML_pixel_name = strcat( name , "_" , string(i));
    raw_conversion(app, raw_path, txt_path_pixel, mzML_folder_path, mzML_pixel_name)
end



