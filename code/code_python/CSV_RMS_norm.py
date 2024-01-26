# Validated on Python 3.8.10
# To run manunally through MatLab:
#   path(path, 'code/code_python')
#   pyrunfile('#SCRIPT_NAME#.py')
# Highly sensitive to the null values that populate most cells of the CSV files. Not advisable as it is.

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

csv = pandas.read_csv(filename, sep=',', index_col='cell1', low_memory=False)  # Reads the opened CSV, deprecated
head = csv.iloc[:11, :]
tail = csv.iloc[11:, :]
tail_squared = tail.apply(numpy.square)
tail_squared_mean = []

for data in tail_squared:
    tail_squared_mean.append(tail_squared[data].mean())

tail_rms = numpy.sqrt(tail_squared_mean)

i = 0
for data in tail:
    tail[data] = tail[data]/tail_rms[i]
    i = i + 1

csv_norm = pandas.concat([head, tail])

# Export the TIC-normalized data
file_name_recovery(filepath=filename)
tgtname = tgtnamefin + '-RMSnorm.' + tgtext
csv_norm.to_csv(path_or_buf=('files/csv files/' + tgtname))

print(tgtname, 'was properly saved in "files/csv files/"')
