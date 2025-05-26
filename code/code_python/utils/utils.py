# Define the name fetching function
def file_name_recovery(filepath):
    # This function returns a file's name and its extension as two separate entities in order to allow for easier
    # manipulation
    global in_filename, in_filename_ext, project
    
    filepath_split = filepath.split("/")
    filename_full = filepath_split[-1]
    filename_split = filename_full.split(".")

    filename = filename_split[0]
    filename_ext = filename_split[1]

    project = filepath_split[-3]

    return in_filename, in_filename_ext, project
