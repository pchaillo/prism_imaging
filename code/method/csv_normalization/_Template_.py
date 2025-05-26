# Validated on Python 3.8.10
# To run manually through MatLab:
#   path(path, 'code/code_python')
#   pyrunfile('#SCRIPT_NAME#.py')

import pandas
from tkinter.filedialog import askopenfilename
from tkinter import Tk
from utils.utils import file_name_recovery

# Normalization name goes here 
norm_name = 'NormalizationName'

Tk().withdraw()
filename = askopenfilename()

csv = pandas.read_csv(filename, sep=',', index_col='Data Type', low_memory=False)  # Reads the opened CSV
head = csv.iloc[:11, :] # Header of the CSV file
tail = csv.iloc[11:, :] # MS data, the part to be normalized

######################################
#####TAIL NORMALIZATION GOES HERE#####
######################################

csv_norm = pandas.concat([head, tail]) # Rebuilds the CSV file

# Export the Normalized data
in_filename, in_filename_ext, project = file_name_recovery(filepath=filename)
out_name = f"%in_filename%-%norm_name%-norm.csv" + norm_name + 'norm.' + tgtext
csv_norm.to_csv(path_or_buf=(f"files\\%project%\\csv_files\\%out_name%"))

print(f"%out_name% was properly saved in files/%project%/csv_files/")
