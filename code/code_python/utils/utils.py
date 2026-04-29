def file_name_recovery(filepath):
    # This function returns a file's name and its extension as two separate entities in order to allow for easier
    # manipulation
    
    filepath_split = filepath.split("\\")
    filename_full = filepath_split[-1]
    filename_split = filename_full.split(".")

    in_filename = filename_split[0]
    in_filename_ext = filename_split[1]

    if "\\image_files\\" in filepath:
        project = filepath_split[-4]
    else:
        project = filepath_split[-3]

    return in_filename, in_filename_ext, project

def parse_imaging_file(filename):
    import os
    import pandas as pd

    supported_ext = ["csv", "parquet"]
    extension = os.path.split(filename)[1].split(".")[1]

    if extension not in supported_ext:
        raise TypeError
    else:
        if extension == "csv":
            file = pd.read_csv(filename, sep=",", index_col='Data Type', low_memory=False)
        elif extension == "parquet":
            file = pd.read_parquet(filename)
            file.columns = file.iloc[0, :]
            file.drop(0, inplace=True)
            file.index = file.iloc[:,0]
            file.drop("Data Type", axis=1, inplace=True)
        return file, extension