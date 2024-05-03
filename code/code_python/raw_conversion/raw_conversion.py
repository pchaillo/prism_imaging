import os
import subprocess
from tkinter.filedialog import askopenfilename
from tkinter import Tk

# TODO: Add a dictionnary of all output formats and pass that as an argument instead of hardcoding mzML as an output

extensions_dict = {'mzML':'--mzML', 'mzXML':'--mzXML', 'mgf':'--mgf', 'txt':'--txt', 'mz5':'--mz5'}

def convert_raw_to_mzxml(raw_files_path, extension = "--mzML"):
    command = ["msconvert", raw_files_path, "-o", 'files/conversion/', extension="--mzML"]
    subprocess.run(command, check=True)

Tk().withdraw()
filename = askopenfilename()

convert_raw_to_mzxml(raw_files_path="")

print("mzML file saved in files/raw files/")