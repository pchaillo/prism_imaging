import os
import subprocess
from tkinter.filedialog import askopenfilename
from tkinter import Tk

# TODO: Add support for the dictionnary in MatLab

extensions_dict = {'mzML':'--mzML', 'mzXML':'--mzXML', 'mgf':'--mgf', 'txt':'--txt', 'mz5':'--mz5'}

def convert_raw_to_mzxml(raw_file_path, txt_file, extension = "--mzML"):
    command = ["msconvert ", raw_file_path, "-f ", txt_file, "-o ", "files/conversion/ ", "--mzML"]
    subprocess.run(command, check=True)
    
print("Loaded text file: ")
print(txt_file)

print("Loaded .RAW file: ")
print(raw_file)

convert_raw_to_mzxml(raw_file_path=raw_file, txt_file = txt_file)

print("mzML file saved in files/raw files/")