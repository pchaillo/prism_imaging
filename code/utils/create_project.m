function create_project(project_name)
%CREATE_PROJECT Creates all directories related to a given MSI experiment

folders = ["colour_scales" 
    "csv_files" 
    "etal_files" 
    "image_files"
    "map_files"
    "mat_files"
    "mzML_files" 
    "mzXML_files"
    "ply_files"
    "raw_files"
    "rgb_map_files"
    "txt_files"];

root = strcat("files\", project_name, "\");

for i = 1:length(folders)
    newfolder = fullfile(root, folders(i));
    mkdir(newfolder)
    if folders(i) == "image_files"
        subfolders = ["coregistered_images"
                      "molecular_png"
                      "optical_images"];
        
        for j = 1:length(subfolders) 
            newsubfolder = fullfile(newfolder, subfolders(j));
            mkdir(newsubfolder)
        end
    end
end

formatSpec = "Project %s created in files/";
sprintf(formatSpec, project_name)

end