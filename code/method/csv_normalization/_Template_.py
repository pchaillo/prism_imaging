# Validated on Python 3.8.10
# To run manually through MatLab:
#   path(path, 'code/code_python')
#   pyrunfile('#SCRIPT_NAME#.py')

import pandas
from tkinter.filedialog import askopenfilename
from tkinter import Tk

# Normalization name goes here 
norm_name = 'NormalizationName'

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
head = csv.iloc[:11, :] # Header of the CSV file
tail = csv.iloc[11:, :] # MS data, the part to be normalized

######################################
#####TAIL NORMALIZATION GOES HERE#####
######################################

csv_norm = pandas.concat([head, tail]) # Rebuilds the CSV file

# Export the TIC-normalized data
file_name_recovery(filepath=filename)
tgtname = tgtnamefin + norm_name + 'norm.' + tgtext
csv_norm.to_csv(path_or_buf=('files/csv files/' + tgtname))

print(tgtname, 'was properly saved in files/csv files/')
