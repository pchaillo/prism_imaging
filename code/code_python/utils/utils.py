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

def parse_imaging_file(filename, sparse=False, high_precision=True):
    """
    :param filename: Full path of the parquet or CSV file to load
    :param sparse: Converts the data to a sparse Dataframe to save lots of memory at the cost of increased loading and processing times
    :param high_precision: If False, converts the data to 32 bits for lower memory requirements and processing times at the cost of precision
    :return:
    """
    import os
    import pandas as pd
    import numpy as np

    supported_ext = ["csv", "parquet"]
    extension = os.path.split(filename)[1].split(".")[1]

    if extension not in supported_ext:
        raise TypeError
    else:
        if extension == "csv":
            # For older files: file = pd.read_csv(filename, sep=",", index_col="Data Type", low_memory=False)
            file = pd.read_csv(filename, sep=",", header=None, index_col=0, low_memory=False)
            # Compatibility layer for older files
            if "Data Type" in file.index:
                file.drop("Data Type", inplace=True)
        elif extension == "parquet":
            file = pd.read_parquet(filename)
            if "x" in file.columns:
                file = file.T

            # Files exported through MatLab, as always, do not behave as expected. This is how to manage them:
            if "x" not in file.index:
                file.columns = range(len(file.columns))
                if file.iloc[0,0] != "x":
                    # Removes the first row if it is supposed to be column headers
                    file.drop(0, axis=0, inplace=True)
                file.index = file.iloc[:,0]
                file.drop(0, axis=1, inplace=True)

            file = file.astype(float)
            file.columns = file.columns.astype("int")

            # Sometimes an empty column is created at the end of the file. This deals with it.
            if file.loc["x"].iloc[-1] == 0:
                file.drop(file.columns[-1], axis=1, inplace=True)

            if sparse or not high_precision:
                if high_precision:
                    file = file.astype(pd.SparseDtype("float", 0))
                elif not sparse:
                    # Diminished precision but memory use is halved
                    file = file.astype(np.float32)
                else:
                    # Greatly diminishes memory requirements, but significantly increases processing time
                    file = file.astype(pd.SparseDtype(np.float32, 0))

        return file, extension