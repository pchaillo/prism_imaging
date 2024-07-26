# Validated on Python 3.8.10
# To run manually through MatLab:
#   path(path, 'code/code_python')
#   pyrunfile('#SCRIPT_NAME#.py')

import pandas
import math
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

bp = csv.iloc[9, :].mode()
bp = math.floor(bp.iloc[0]*10)/10  # Not the proper way to round, but this allows us to work around the binning of the
# csv file

print(bp)

bp_value = csv.loc[str(bp), :].copy()  # This is conceptually fine, but we have lots of empty intensity values. We
# can't divide by zero, so this is an issue

bp_value.loc[bp_value == 0] = 1  # This works around the 0 intensity issue, at the cost of slightly modifying the
# molecular data FOR NORMALIZATION. To be clear, this just means that 0 gets divided by 1 in the table, giving us 0 in
# the csv file.

tail = tail/bp_value

csv_norm = pandas.concat([head, tail])

# Export the TIC-normalized data
file_name_recovery(filepath=filename)
tgtname = tgtnamefin + '-BPnorm.' + tgtext
csv_norm.to_csv(path_or_buf=('files/csv files/' + tgtname))

print(tgtname, 'was properly saved in csv files/')
