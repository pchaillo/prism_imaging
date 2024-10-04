# Validated on Python 3.8.10
# To run manunally through MatLab:
#   path(path, 'code/code_python')
#   pyrunfile('#SCRIPT_NAME#.py')
# This version will instead work on the sum of intensities in each pixel

import pandas
import numpy
from tkinter.filedialog import askopenfilename
from tkinter import Tk


# Define the name fetching function
def file_name_recovery(filepath):
    # This function returns a file's name and its extension as two separate entities in order to allow for easier
    # manipulation
    global tgtnamefin, tgtext
    tgtname = ''
    rvstgtname = ''
    tgtnamefin = ''
    tgtext = ''
    rvstgtext = ''
    for i in reversed(filepath):
        if i != "/":
            rvstgtname = rvstgtname + i
        else:
            break

    for i in reversed(rvstgtname):
        tgtname = tgtname + i

    for i in tgtname:
        if i != '.':
            tgtnamefin = tgtnamefin + i  # Target name
        else:
            break

    for i in reversed(filepath):
        if i != '.':
            rvstgtext = rvstgtext + i
        else:
            break

    for i in reversed(rvstgtext):
        tgtext = tgtext + i  # Target extension
    return tgtnamefin, tgtext


Tk().withdraw()
filename = askopenfilename()

csv = pandas.read_csv(filename, sep=',', index_col='cell1', low_memory=False)  # Reads the opened CSV
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

# Export the TIC-normalized data
file_name_recovery(filepath=filename)
tgtname = tgtnamefin + '-RMSnorm.' + tgtext
csv_norm.to_csv(path_or_buf=('files/csv files/' + tgtname))

print(tgtname, 'was properly saved in files/csv files/')
