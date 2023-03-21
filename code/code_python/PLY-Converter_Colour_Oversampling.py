# Validated on Python 3.8.10
# To run through MatLab: pyrunfile('PLY-Converter_Colour_tkinter.py')
# If not working:
# _Make sure that Python 3.8 is installed properly
# _Verify that the Matlab version is compatible with Python 3.8
# _Verify that Matlab is using the proper Python environment (i.e: Python 3.8). If not, set it up.
# _Tk and Tcl may need to be copied to the 'Lib' file of the Python 3.8 installation folder
# Oversampling not fully implemented yet. Only works when set to 2x.

import pandas
import numpy
import tkinter
from tkinter import ttk
from tkinter.filedialog import askopenfilename
from coloraide import Color

# Creation of global variables
filename = None
colour1 = None
colour2 = None


def linear_itp(obj1, obj2, rate=0.5):
    obj3 = rate * obj1 + (1 - rate) * obj2
    return obj3


# GUI Goodness
def uploadaction():
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


def set_interpol():
    global interpol
    interpol = sldr7.get()


gui = tkinter.Tk()
gui.title("Biomap to PLY converter - Now with point interpolation!")
gui.resizable(False, False)
frm = ttk.Frame(gui, padding=10, height=350, width=300)
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

ttk.Button(frm, text="Apply", command=fetch_colours).place(x=180, y=210)

separator = ttk.Separator(gui, orient="horizontal")
separator.place(x=0, y=250, relwidth=3)

ttk.Label(frm, text="Interpolation").place(x=0, y=245)
sldr7 = tkinter.Scale(frm, from_=2, to=10, orient=tkinter.HORIZONTAL)
sldr7.place(x=35, y=260)
sldr7.set(2)

ttk.Button(frm, text="Set", command=set_interpol).place(x=180, y=260)

ttk.Button(frm, text="Quit", command=gui.destroy).place(x=180, y=290)
gui.mainloop()

biomap = pandas.read_csv(filename, sep=' ', header=None)  # Reads the opened biomap

# Header Generation
if interpol == 1:
    dimX = biomap.iloc[0][1]
    dimY = biomap.iloc[0][0]
    oldimX = biomap.iloc[0][1]
    oldimY = biomap.iloc[0][0]
else:
    dimX = (biomap.iloc[0][1] * interpol) - (interpol - 1)
    dimY = (biomap.iloc[0][0] * interpol) - (interpol - 1)
    oldimX = biomap.iloc[0][1]
    oldimY = biomap.iloc[0][0]
vertices = int(dimX*dimY)
old_vertices = int(oldimX*oldimY)
edges = interpol * dimX * dimY - dimX - dimY  # See Grid Graphs properties, seems wrong
faces = (dimX - 1) * (dimY - 1)
faces = int(faces)  # Conversion to integer is necessary for PLY files
headertp = "ply\nformat ascii 1.0\nelement vertex ", vertices, "\nproperty float64 x\nproperty float64 " \
                                                               "y\nproperty float64 z\nproperty uchar red\nproperty " \
                                                               "uchar green\nproperty uchar blue\nelement face" \
                                                               " ", faces, "\nproperty list uchar int " \
                                                                           "vertex_indices""\nend_header\n"
header = ""
header = header.join(map(str, headertp))

# Vertices recovery and upscaling
coords = biomap.iloc[:, 0:4]
coordsfinal = coords.drop(0)  # Grabs vertices coordinates without the header
coordsfinal[numpy.isnan(coordsfinal)] = 0
coordsrnk = numpy.arange(1, old_vertices + 1, dtype=int)
ovspcoords = numpy.zeros((vertices, 4))
rank = 1
interpol_range = numpy.arange(1, interpol)

for i in coordsrnk:
    if rank == vertices:  # Checks if we are on the last point
        ovspcoords[rank - 1] = coordsfinal.iloc[i - 1]  # No interpolation
        break
    elif vertices - dimX + 1 <= rank < vertices:  # Checks if we are on the last line
        ovspcoords[rank - 1] = coordsfinal.iloc[i - 1]
        for n in interpol_range:
            ovspcoords[rank - 1 + n] = linear_itp(coordsfinal.iloc[i - 1], coordsfinal.iloc[i], rate=1 - (n / interpol))
        rank = rank + interpol
    elif i % (int(oldimX)) == 0:  # Checks if we are in the last column
        ovspcoords[rank - 1] = coordsfinal.iloc[i - 1]
        for n in interpol_range:
            ovspcoords[rank - 1 + n * int(dimX)] = linear_itp(coordsfinal.iloc[i - 1],
                                                              coordsfinal.iloc[i + int(oldimX) - 1],
                                                              rate=1 - (n / interpol))
        rank = rank + (interpol - 1) * int(dimX) + 1
    elif vertices - int(dimX) + 1 > rank:
        ovspcoords[rank - 1] = coordsfinal.iloc[i - 1]
        ovspcoords[rank - 1 + interpol] = coordsfinal.iloc[i]
        ovspcoords[rank - 1 + interpol * int(dimX)] = coordsfinal.iloc[i - 1 + int(oldimX)]
        ovspcoords[rank - 1 + interpol * int(dimX) + interpol] = coordsfinal.iloc[i + int(oldimX)]
        for n in interpol_range:
            ovspcoords[rank - 1 + n] = linear_itp(coordsfinal.iloc[i - 1], coordsfinal.iloc[i], rate=1 - (n / interpol))
            ovspcoords[rank - 1 + n * int(dimX)] = linear_itp(coordsfinal.iloc[i - 1],
                                                              coordsfinal.iloc[i + int(oldimX) - 1],
                                                              rate=1 - (n / interpol))
            ovspcoords[rank - 1 + interpol + n * int(dimX)] = linear_itp(coordsfinal.iloc[i],
                                                                         coordsfinal.iloc[i + int(oldimX)],
                                                                         rate=1 - (n / interpol))
        interpol_range2 = interpol_range
        for n in interpol_range:
            for m in interpol_range2:
                ovspcoords[rank - 1 + n * int(dimX) + m] = linear_itp(ovspcoords[rank - 1 + n * int(dimX)],
                                                                      ovspcoords[rank - 1 + interpol + n * int(dimX)],
                                                                      rate=1 - (m / interpol))
        rank = rank + interpol
    else:
        print('WTF ')

# MS intensities extraction
intensities = ovspcoords[:, 3]
ovspcoords = ovspcoords[:, :3]
imax = max(intensities)
itstlst = []
for i in intensities:
    itstlst.append(int(i))  # Creates a list of intensities converted to integers

# Colouring of vertices with ColorAide
c1 = Color("srgb", [r1 / 255, g1 / 255, b1 / 255])
c2 = Color("srgb", [r2 / 255, g2 / 255, b2 / 255])
col = Color.interpolate([c1, c2], space="srgb")
colours = numpy.zeros(shape=(vertices, 3))
rank = 0

for i in itstlst:
    hue = col(i / imax)
    colours[rank] = ([hue['r'] * 255, hue['g'] * 255, hue['b'] * 255])
    rank = rank + 1
coloursdf = pandas.DataFrame(colours)
coloursdf = coloursdf.astype(int)

# Faces calculation
vtx = numpy.arange(1, vertices)  # Generates a numbered list corresponding to vertices
fcs = numpy.zeros(shape=(vertices, 5))
for i in vtx:
    if (i % dimX) != 0 and i + dimX <= vertices and ((i + dimX) % dimX) != 0 and i + dimX + 1 <= vertices:
        fcs[i - 1] = ([4, i + dimX - 1, i + dimX, i, i - 1])
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
counter = numpy.arange(1, (vertices + 0.5) * 2)
countervtx = 0
countercol = 0
for i in counter:  # Fills a buffer with either vertices or colours and writes it to target file. Necessary AFAIK.
    if i % 2 != 0:
        buffertp = (ovspcoords[countervtx, 0], " ", ovspcoords[countervtx, 1], " ", ovspcoords[countervtx, 2], " \n")
        buffer = ""
        buffer = buffer.join(map(str, buffertp))
        with open(tgtname, "a") as plyfile:
            plyfile.write(buffer)
        countervtx = countervtx + 1
    else:
        buffertp = (
        coloursdf.iloc[countercol, 0], " ", coloursdf.iloc[countercol, 1], " ", coloursdf.iloc[countercol, 2], " \n")
        buffer = ""
        buffer = buffer.join(map(str, buffertp))
        with open(tgtname, "a") as plyfile:
            plyfile.write(buffer)
        countercol = countercol + 1
fcsdf.to_csv(path_or_buf=tgtname, sep=" ", header=False, index=False, mode="a")  # Write faces to target file
