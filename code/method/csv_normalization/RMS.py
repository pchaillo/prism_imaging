# Validated on Python 3.8.10
# To run manunally through MatLab:
#   path(path, 'code/code_python')
#   pyrunfile('#SCRIPT_NAME#.py')
# This version will instead work on the sum of intensities in each pixel

import pandas
import numpy
from tkinter.filedialog import askopenfilename
from tkinter import Tk
from utils.utils import file_name_recovery

norm_name = 'RMS'

Tk().withdraw()
filename = askopenfilename()

csv = pandas.read_csv(filename, sep=',', index_col='Data Type', low_memory=False)  # Reads the opened CSV
head = csv.iloc[:11, :]
tail = csv.iloc[11:, :]

tail_sum = tail.copy()
tail_sum = tail_sum.sum(axis=0)  # This should equate to the TIC, but it is much larger.
tail_mean = tail_sum.mean()
tail_delta = tail_sum - tail_mean
tail_rms = numpy.sqrt(tail_delta.apply(numpy.square))

# The following line is a debug workaround, and WILL diminish RMS accuracy
tail_rms = tail_rms.round()

# Not too sure about this one. It looks like floats are messing up and creating values where there are none

tail = tail/tail_rms

csv_norm = pandas.concat([head, tail])

# Export the RMS-normalized data
in_filename, in_filename_ext, project = file_name_recovery(filepath=filename)
out_name = f"%in_filename%-%norm_name%-norm.csv" + norm_name + 'norm.' + tgtext
csv_norm.to_csv(path_or_buf=(f"files\\%project%\\csv_files\\%out_name%"))

print(f"%out_name% was properly saved in files/%project%/csv_files/")

