# Validated on Python 3.8.10
# To run manually through MatLab:
#   path(path, 'code/code_python')
#   pyrunfile('#SCRIPT_NAME#.py')
# Modified based on the approach defined in: 10.1007/s00216-011-4929-z
# Recompute the TIC based on the sum of intensities
# TIC normalization outlines artifacts and should thus be used in conjunction with denoising. This might be worth
# implementing at some point

import pandas
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
file_name_recovery(filepath=filename)
tgtname = tgtnamefin + '-TICnorm.' + tgtext
csv_norm.to_csv(path_or_buf=('files/csv files/' + tgtname))

print(tgtname, 'was properly saved in files/csv files/')
