# Validated on Python 3.8.10
# To run manually through MatLab:
#   path(path, 'code/code_python')
#   pyrunfile('#SCRIPT_NAME#.py')
# Note: In order to avoid issues during BP normalization, please only 
# perform it on CSV files that contain the entire mass range of the experiment.

import os
import sys

sys.path.insert(0, os.getcwd() + "\code\code_python") # Needed so that MatLab can actually find the dependency

import pandas
import math
from tkinter.filedialog import askopenfilename
from tkinter import Tk
from utils.utils import file_name_recovery, parse_imaging_file

norm_name = 'BasePeak'

Tk().withdraw()
filename = askopenfilename()
filename = filename.replace("/", "\\")

file, ext = parse_imaging_file(filename)
head = file.iloc[:11, :]
tail = file.iloc[11:, :]

bp = file.iloc[9, :].mode()
bp = math.floor(bp.iloc[0]*10)/10  # Not the proper way to round, but this allows us to work around the binning of the
# imaging file

# print(bp)

bp_value = file.loc[str(bp), :].copy()  # This is conceptually fine, but we have lots of empty intensity values. We
# can't divide by zero, so this is an issue

bp_value.loc[bp_value == 0] = 1  # This works around the 0 intensity issue, at the cost of slightly modifying the
# molecular data FOR NORMALIZATION. To be clear, this just means that 0 gets divided by 1 in the table, giving us 0 in
# the imaging file.

tail = tail/bp_value

file_norm = pandas.concat([head, tail])

# Export the BP-normalized data
in_filename, in_filename_ext, project = file_name_recovery(filepath=filename)
out_name = f"{in_filename}-{norm_name}-norm.{ext}]"

if ext == "csv":
    file_norm.to_csv(path_or_buf=(f"files\\{project}\\csv_files\\{out_name}"))
elif ext == "parquet":
    file_norm.to_parquet(path_or_buf=(f"files\\{project}\\csv_files\\{out_name}"))

print(f"{out_name} was properly saved in files/{project}/csv_files/")


