# Validated on Python 3.8.10
# To run through MatLab: pyrunfile('PLY-Converter_Colour_tkinter.py')
# If not working:
# _Make sure that Python 3.8 is installed properly
# _Verify that the Matlab version is compatible with Python 3.8
# _Verify that Matlab is using the proper Python environment (i.e: Python 3.8). If not, set it up.
# _Tk and Tcl may need to be copied to the 'Lib' file of the Python 3.8 installation folder

import pandas
import numpy
import tkinter
from tkinter import ttk
from tkinter.filedialog import askopenfilename
from coloraide import Color
import time

# GUI Goodness
# Creation of global variables
filename = None
colour1 = None
colour2 = None


def uploadaction():  # Function to fetch file name from button
    global filename
    filename = askopenfilename()  # Global allows for modification of a variable out of the function


def fetch_colours():
    global r1
    r1 = sldr1.get()
    global r2
    r2 = sldr2.get()
    global g1
    g1 = sldr3.get()
    global g2
    g2 = sldr4.get()
    global b1
    b1 = sldr5.get()
    global b2
    b2 = sldr6.get()
    gui.quit()  # Instantly closes the window upon validation, potentially annoying


gui = tkinter.Tk()
gui.title("Biomap to PLY converter")
gui.resizable(False,False)
frm = ttk.Frame(gui, padding=10, height=300, width=300)
frm.grid()
ttk.Button(frm, text="Target", command=uploadaction).place(x=100, y=0)  # Fetches the biomap of interest
ttk.Label(frm, text="Load a biomap: ").place(x=0, y=3)

separator = ttk.Separator(gui, orient="horizontal")
separator.place(x=0, y=40, relwidth=3)

ttk.Label(frm, text="Low intensity").place(x=50, y=40)  # Column headers
ttk.Label(frm, text="High intensity").place(x=170, y=40)

ttk.Label(frm, text="Red").place(x=0, y=80)
sldr1 = tkinter.Scale(frm, from_=0, to=255, orient=tkinter.HORIZONTAL)
sldr1.place(x=35, y=60)
sldr1.set(255)
sldr2 = tkinter.Scale(frm, from_=0, to=255, orient=tkinter.HORIZONTAL)
sldr2.place(x=155, y=60)

ttk.Label(frm, text="Green").place(x=0, y=130)
sldr3 = tkinter.Scale(frm, from_=0, to=255, orient=tkinter.HORIZONTAL)
sldr3.place(x=35, y=110)
sldr4 = tkinter.Scale(frm, from_=0, to=255, orient=tkinter.HORIZONTAL)
sldr4.place(x=155, y=110)
sldr4.set(255)

ttk.Label(frm, text="Blue").place(x=0, y=180)
sldr5 = tkinter.Scale(frm, from_=0, to=255, orient=tkinter.HORIZONTAL)
sldr5.place(x=35, y=160)
sldr6 = tkinter.Scale(frm, from_=0, to=255, orient=tkinter.HORIZONTAL)
sldr6.place(x=155, y=160)

ttk.Button(frm, text="Apply", command=fetch_colours).place(x=90, y=220)
ttk.Button(frm, text="Quit", command=gui.destroy).place(x=180, y=220)
gui.mainloop()

# Starts CPU execution time
start_time = time.process_time()

biomap = pandas.read_csv(filename, sep=' ', header=None, names=['X', 'Y', 'Z', 'Time', 'N.A'])  # Reads the opened biomap

# Header Generation
vertices = len(biomap)-1
dimX = biomap.iloc[0][1]
dimY = biomap.iloc[0][0]
edges = 2*dimX*dimY-dimX-dimY  # See Grid Graphs properties, seems wrong
faces = (dimX-1)*(dimY-1)
faces = int(faces)  # Conversion to integer is necessary for PLY files
headertp = "ply\nformat ascii 1.0\nelement vertex ", vertices, "\nproperty float64 x\nproperty float64 y\nproperty float64 z\nproperty uchar red\nproperty uchar green\nproperty uchar blue\nelement face ", faces, "\nproperty list uchar int vertex_indices""\nend_header\n"
header = ""
header = header.join(map(str, headertp))

# Vertices recovery
coords = biomap.iloc[:, 0:3]
coordsfinal = coords.drop(0)  # Grabs vertices coordinates without the header

# MS intensities extraction
intensities = biomap.iloc[:, 3]
intensities = intensities.drop(0)  # Grabs intensities without the header
intensities = intensities.fillna(0)
imax = max(intensities)
itstlst = []
for i in intensities:
    itstlst.append(int(i))  # Creates a list of intensities converted to integers

# Colouring of vertices with ColorAide
c1 = Color("srgb", [r1/255, g1/255, b1/255])
c2 = Color("srgb", [r2/255, g2/255, b2/255])
col = Color.interpolate([c1, c2], space="srgb")
colours = numpy.zeros(shape=(vertices, 3))
rank = 0

for i in itstlst:
    hue = col(i/imax)
    colours[rank] = ([hue['r']*255, hue['g']*255, hue['b']*255])
    rank = rank + 1
coloursdf = pandas.DataFrame(colours)
coloursdf = coloursdf.astype(int)

# Faces calculation
vtx = numpy.arange(1, vertices)  # Generates a numbered list corresponding to vertices
fcs = numpy.zeros(shape=(vertices, 5))
for i in vtx:
    if (i % dimX) != 0 and i + dimX <= vertices and ((i + dimX) % dimX) != 0 and i + dimX + 1 <= vertices:
        fcs[i - 1] = ([4, i+dimX-1, i+dimX, i, i-1])
fcsdf = pandas.DataFrame(fcs)
fcsdf = fcsdf.astype(int)
fcsdf = fcsdf[fcsdf[0] != 0]

# Export file name recovery
tgtname = ''
rvstgtname = ''
for i in reversed(filename):
    if i != "/":
        rvstgtname = rvstgtname + i
    else:
        break
for i in reversed(rvstgtname):
    tgtname = tgtname + i
tgtname = tgtname.replace("biomap", "ply")
with open(tgtname, "w") as plyfile:
    plyfile.write(header)

counter = numpy.arange(0, vertices)
rank = 0
fusion = pandas.DataFrame(index=range(vertices*2), columns=range(3))

for i in counter:
    fusion.iloc[rank] = coordsfinal.iloc[i]
    fusion.iloc[rank + 1] = coloursdf.iloc[i]
    rank = rank + 2

fusion.assign(line_return='\n')
fusion.to_csv(path_or_buf=tgtname, sep=" ", header=False, index=False, mode="a")
fcsdf.to_csv(path_or_buf=tgtname, sep=" ", header=False, index=False, mode="a")  # Write faces to target file

# Time-related code, grabs the end time
end_time = time.process_time()

# Time-related code, calculates the elapsed time
cpu_time = end_time - start_time
print('CPU Runtime = ', cpu_time)
