# Validated on Python 3.14.3
# To run manually through MatLab:
#   path(path, 'code/code_python')
#   pyrunfile('#SCRIPT_NAME#.py')
# This version will instead work on the sum of intensities in each pixel

import os
import sys

sys.path.insert(0, os.getcwd() + "\\code\\code_python") # Needed so that MatLab can actually find the dependency

import pandas
import numpy
from tkinter.filedialog import askopenfilename
from tkinter import Tk
from utils.utils import file_name_recovery, parse_imaging_file

norm_name = 'RMS'

Tk().withdraw()
filename = askopenfilename()
filename = filename.replace("/", "\\")

file, ext = parse_imaging_file(filename)
#TODO: Make the head/tail split more clever, automatically retrieving the 
head = file.iloc[:11, :]
tail = file.iloc[11:, :]

tail_sum = tail.copy()
tail_sum = tail_sum.sum(axis=0)  # This should equate to the TIC, but it is much larger.
tail_mean = tail_sum.mean()
tail_delta = tail_sum - tail_mean
tail_rms = numpy.sqrt(tail.apply(numpy.square).mean())


# Not too sure about this one. It looks like floats are messing up and creating values where there are none
tail = tail/tail_rms

file_norm = pandas.concat([head, tail])

# Export the RMS-normalized data
in_filename, in_filename_ext, project = file_name_recovery(filepath=filename)
out_name = f"{in_filename}-{norm_name}-norm.{ext}"

if ext == "csv":
    file_norm.to_csv(path_or_buf=(f"files\\{project}\\csv_files\\{out_name}"))
elif ext == "parquet":
    file_norm.to_parquet(path=(f"files\\{project}\\csv_files\\{out_name}"))

print(f"{out_name} was properly saved in files/{project}/csv_files/")
