# Define the name fetching function

def file_name_recovery(filepath):
    # This function returns a file's name and its extension as two separate entities in order to allow for easier
    # manipulation
    
    filepath_split = filepath.split("/")
    filename_full = filepath_split[-1]
    filename_split = filename_full.split(".")

    in_filename = filename_split[0]
    in_filename_ext = filename_split[1]

    if "/image_files/" in filepath:
        project = filepath_split[-4]
    else:
        project = filepath_split[-3]

    return in_filename, in_filename_ext, project
