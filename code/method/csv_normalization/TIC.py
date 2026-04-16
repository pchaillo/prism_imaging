# Validated on Python 3.8.10
# To run manually through MatLab:
#   path(path, 'code/code_python')
#   pyrunfile('#SCRIPT_NAME#.py')
# Modified based on the approach defined in: 10.1007/s00216-011-4929-z
# Recompute the TIC based on the sum of intensities
# TIC normalization outlines artifacts and should thus be used in conjunction with denoising. This might be worth
# implementing at some point

import os
import sys

sys.path.insert(0, os.getcwd() + "\\code\\code_python") # Needed so that MatLab can actually find the dependency

import pandas
from tkinter.filedialog import askopenfilename
from tkinter import Tk
from utils.utils import file_name_recovery

norm_name = 'TIC'

Tk().withdraw()
filename = askopenfilename()
filename = filename.replace("/", "\\")

csv = pandas.read_csv(filename, sep=',', index_col='Data Type', low_memory=False)  # Reads the opened CSV, deprecated
head = csv.iloc[:11, :]
tail = csv.iloc[11:, :]
tic = head.loc["TIC"]

tic.loc[tic == 0.0] = 1  # Some TICs are equal to zero. This is an issue that can prevent normalization from working.
# Making those values equal to 1 is a workaround.

proportional_tic = tic/max(tic)

tail = tail / proportional_tic

csv_norm = pandas.concat([head, tail])

# Export the TIC-normalized data
in_filename, in_filename_ext, project = file_name_recovery(filepath=filename)
out_name = f"{in_filename}-{norm_name}-norm.csv"
csv_norm.to_csv(path_or_buf=(f"files\\{project}\\csv_files\\{out_name}"))

print(f"{out_name} was properly saved in files/{project}/csv_files/")
