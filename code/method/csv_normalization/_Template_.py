# Validated on Python 3.8.10
# To run manually through MatLab:
#   path(path, 'code/code_python')
#   pyrunfile('#SCRIPT_NAME#.py')

import os
import sys

sys.path.insert(0, os.getcwd() + "\code\code_python") # Needed so that MatLab can actually find the dependency

import pandas
from tkinter.filedialog import askopenfilename
from tkinter import Tk
from utils.utils import file_name_recovery, parse_imaging_file

# Normalization name goes here 
norm_name = 'NormalizationName'

Tk().withdraw()
filename = askopenfilename()
filename = filename.replace("/", "\\")

file, ext = parse_imaging_file(filename)
head = file.iloc[:11, :] # Header of the imaging file
tail = file.iloc[11:, :] # MS data, the part to be normalized

######################################
#####TAIL NORMALIZATION GOES HERE#####
######################################

file_norm = pandas.concat([head, tail]) # Rebuilds the imaging file

# Export the Normalized data
in_filename, in_filename_ext, project = file_name_recovery(filepath=filename)
out_name = f"{in_filename}-{norm_name}-norm.{ext}]"

if ext == "csv":
    file_norm.to_csv(path_or_buf=(f"files\\{project}\\csv_files\\{out_name}"))
elif ext == "parquet":
    file_norm.to_parquet(path_or_buf=(f"files\\{project}\\csv_files\\{out_name}"))

print(f"{out_name} was properly saved in files/{project}/csv_files/")

