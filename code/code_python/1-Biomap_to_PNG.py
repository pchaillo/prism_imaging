# Validated on Python 3.8.10
# To run through MatLab: pyrunfile('PLY-Converter_Colour_tkinter.py')
# If not working:
# _Make sure that Python 3.8 is installed properly
# _Verify that the Matlab version is compatible with Python 3.8
# _Verify that Matlab is using the proper Python environment (i.e: Python 3.8). If not, set it up.
# _Tk and Tcl may need to be copied to the 'Lib' file of the Python 3.8 installation folder
# Interpolations are all fully functional in this version, for better or worse

import pandas
import sys
import numpy
import scipy
import tkinter
from tkinter import ttk
from tkinter.filedialog import askopenfilename
from PIL import Image
from coloraide import Color

# Creation of global variables
filename = None
colour1 = None
colour2 = None
coreg_img = None


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


# GUI Goodness
def uploadaction():
    global filename
    filename = askopenfilename(
        defaultextension='.biomap')  # Global allows for modification of a variable out of the function


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
gui.title("Biomap to PNG - For Coregistration")
gui.resizable(False, False)
frm = ttk.Frame(gui, padding=10, height=340, width=300)
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
sldr1.set(0)
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
sldr5.set(255)
sldr6 = tkinter.Scale(frm, from_=0, to=255, orient=tkinter.HORIZONTAL)
sldr6.place(x=155, y=160)
sldr6.set(255)

separator = ttk.Separator(gui, orient="horizontal")
separator.place(x=0, y=220, relwidth=3)

ttk.Label(frm, text="Interpolation").place(x=0, y=225)
sldr7 = tkinter.Scale(frm, from_=2, to=10, orient=tkinter.HORIZONTAL)
sldr7.place(x=35, y=240)
sldr7.set(2)

itp_type = tkinter.StringVar()  # I hate this box, but it works, so I'm not touching it
cb1 = ttk.Combobox(frm, state='readonly', textvariable=itp_type, values=('Linear', 'Nearest', 'SLinear', 'Cubic',
                                                                         'Quintic', 'PChip'), width=13)
cb1.place(x=157, y=258)
cb1.set('Linear')


def set_interpol_type():
    global itp_type
    itp_type = cb1.get()


cb1.bind('<<ComboboxSelected>>', set_interpol_type)

ttk.Button(frm, text="Quit", command=lambda: [fetch_colours(), set_interpol(), set_interpol_type(), gui.destroy()]). \
    place(x=180, y=290)
gui.mainloop()

biomap = pandas.read_csv(filename, sep=' ', header=None)  # Reads the opened biomap
if coreg_img is not None:
    coreg = Image.open(coreg_img)

# Header Generation
dimX = (biomap.iloc[0][1] * interpol) - (interpol - 1)
dimY = (biomap.iloc[0][0] * interpol) - (interpol - 1)
oldimX = biomap.iloc[0][1]
oldimY = biomap.iloc[0][0]
vertices = int(dimX * dimY)
old_vertices = int(oldimX * oldimY)
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
if itp_type == 'Linear':
    itp_type = 'linear'
elif itp_type == 'Nearest':
    itp_type = 'nearest'
elif itp_type == 'SLinear':
    itp_type = 'slinear'
elif itp_type == 'Cubic':
    itp_type = 'cubic'
elif itp_type == 'Quintic':
    itp_type = 'quintic'
elif itp_type == 'PChip':
    itp_type = 'pchip'
else:
    print('Error: No interpolation was selected, somehow')
    sys.exit()

coords = biomap.iloc[:, 0:4]
coordsfinal = coords.drop(0)  # Grabs vertices coordinates without the header
coordsfinal[numpy.isnan(coordsfinal)] = 0

# Data must be mapped in a grid for 2D interpolation. For 2D, we can only implement one dataset at a time. Z heights
# and intensities therefore get their individual arrays
biomap_z = coordsfinal.pivot_table(index=[0], columns=[1], values=[2])
biomap_z_np = biomap_z.to_numpy(dtype=float)  # Conversion to numpy arrays is mandatory for proper indexing
biomap_int = coordsfinal.pivot_table(index=[0], columns=[1], values=[3])
biomap_int_np = biomap_int.to_numpy(dtype=float)

# Computes all positions in X and Y to feed the 2D interpolator
orderX = numpy.arange(coordsfinal.iloc[0][0],
                      max(coordsfinal[0]) + (coordsfinal.iloc[1][1] - coordsfinal.iloc[0][1]),
                      coordsfinal.iloc[1][1] - coordsfinal.iloc[0][1])

orderY = numpy.arange(coordsfinal.iloc[0][1],
                      coordsfinal.iloc[int(oldimX) - 1][1] + (coordsfinal.iloc[1][1] - coordsfinal.iloc[0][1]),
                      coordsfinal.iloc[1][1] - coordsfinal.iloc[0][1])

# Methods for 2D interpolation (str): linear, nearest, slinear, cubic, quintic, pchip
interp_grid_z = scipy.interpolate.RegularGridInterpolator((orderX, orderY), biomap_z_np, method=itp_type)
interp_grid_int = scipy.interpolate.RegularGridInterpolator((orderX, orderY), biomap_int_np, method=itp_type)

# Computes every position in X and Y for which we want interpolated data
neworderX = numpy.arange(coordsfinal.iloc[0][0],
                         max(coordsfinal[0]) + (coordsfinal.iloc[1][1] - coordsfinal.iloc[0][1]),
                         (coordsfinal.iloc[1][1] - coordsfinal.iloc[0][1]) / interpol)
neworderX = neworderX.round(5)
neworderX = neworderX[neworderX <= max(coordsfinal[0])]

neworderY = numpy.arange(coordsfinal.iloc[0][1],
                         coordsfinal.iloc[int(oldimX) - 1][1] + (coordsfinal.iloc[1][1] - coordsfinal.iloc[0][1]),
                         (coordsfinal.iloc[1][1] - coordsfinal.iloc[0][
                             1]) / interpol)  # Should work in theory, but floats are garbage
neworderY = neworderY.round(5)
neworderY = neworderY[neworderY <= coordsfinal.iloc[int(oldimX) - 1][1]]
yy2, xx2 = numpy.meshgrid(neworderY, neworderX)

# Creates a flattened array of X and Y couples, akin to an interpolated version of columns 1 and 2 of the biomap
target_pts = numpy.vstack([xx2.ravel(), yy2.ravel()])
target_pts = target_pts.transpose()

# Returns the interpolated data
z_interpol = interp_grid_z(target_pts)
int_interpol = interp_grid_int(target_pts)

# All data is then compiled into a single array for further analysis
ovspcoords = numpy.vstack([z_interpol, int_interpol])
ovspcoords = ovspcoords.transpose()
ovspcoords = numpy.hstack([target_pts, ovspcoords])

# MS intensities extraction
intensities = ovspcoords[:, 3]
ovspcoords = ovspcoords[:, :3]
imax = max(intensities)
itstlst = []
for i in intensities:
    itstlst.append(int(i))  # Creates a list of intensities converted to integers

# Colouring of vertices with ColorAide
if coreg_img is None:
    c1 = Color("srgb", [r1 / 255, g1 / 255, b1 / 255])
    c1 = Color.convert(c1, "oklab")  # Converts values from srgb to the perceptually linear oklab colour space
    c2 = Color("srgb", [r2 / 255, g2 / 255, b2 / 255])
    c2 = Color.convert(c2, "oklab")
    col = Color.interpolate([c1, c2], space="oklab")
    colours = numpy.zeros(shape=(vertices, 3))
    rank = 0

    for i in itstlst:
        hue = col(i / imax)
        hue = Color.convert(hue, "srgb")
        colours[rank] = ([hue['r'] * 255, hue['g'] * 255, hue['b'] * 255])
        rank = rank + 1
    coloursdf = pandas.DataFrame(colours)

else:
    coreg_pixels = list(coreg.getdata())
    coloursdf = pandas.DataFrame(coreg_pixels)
coloursdf = coloursdf.astype(int)

# IMG Creation and Exportation
file_name_recovery(filepath=filename)
if coreg_img is None:
    colours_int = colours.astype(int)
    colours_export = colours_int.reshape((int(dimY), int(dimX), 3))
    coreg_target = Image.fromarray(colours_export.astype('uint8'), mode='RGB')
    coreg_target.save('3d_export/molecular_png/' + tgtnamefin + '.png')

print(tgtnamefin, '.png', 'was properly saved in 3d_export/molecular_png/')
