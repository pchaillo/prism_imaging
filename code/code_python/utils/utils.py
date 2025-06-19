# Define the name fetching function

def file_name_recovery(filepath):
    # This function returns a file's name and its extension as two separate entities in order to allow for easier
    # manipulation
    if "\\" in filepath:
        split_char = "\\"
        filepath_split = filepath.split("\\")
    elif "/" in filepath:
        split_char = "/"
        filepath_split = filepath.split("/")
    else:
        raise Exception("Error: Could not find a proper separator in the file path. Make sure that either a frontslash "
                        "or a backslash is used to create the path")
    filename_full = filepath_split[-1]
    filename_split = filename_full.split(".")

    in_filename = filename_split[0]
    in_filename_ext = filename_split[1]

    if f"{split_char}image_files{split_char}" in filepath:
        project = filepath_split[-4]
    else:
        project = filepath_split[-3]

    return in_filename, in_filename_ext, project
