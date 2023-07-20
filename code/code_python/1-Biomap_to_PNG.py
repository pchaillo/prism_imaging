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


def set_interpol():
    global interpol
    interpol = sldr7.get()


gui = tkinter.Tk()
gui.title("Biomap to PNG - For Coregistration")
gui.resizable(False, False)
frm = ttk.Frame(gui, padding=10, height=260, width=290)
frm.grid()
ttk.Button(frm, text="Target", command=uploadaction).place(x=100, y=0)  # Fetches the biomap of interest
ttk.Label(frm, text="Load a biomap: ").place(x=0, y=3)

separator = ttk.Separator(gui, orient="horizontal")
separator.place(x=0, y=40, relwidth=3)

ttk.Label(frm, text="Colour Gradient:").place(x=0, y=45)
col_box = ttk.Combobox(frm, state='readonly',
                   values=('Easter', 'Fusion', 'Halloween', 'Magic', 'Viridian'),
                   width=13)
col_box.place(x=100, y=45)
col_box.set('Viridian')


def set_gradient_type():
    global gradient_type
    gradient_type = col_box.get()


col_box.bind('<<ComboboxSelected>>', set_gradient_type())

ttk.Label(frm, text='Min. Percentile Clip').place(x=0, y=75)
min_percentile = tkinter.StringVar(value="0")
min_percentile_input = tkinter.Entry(frm, textvariable=min_percentile, width=7).place(x=30, y=100)

ttk.Label(frm, text='Max. Percentile Clip').place(x=150, y=75)
max_percentile = tkinter.StringVar(value="100")
max_percentile_input = tkinter.Entry(frm, textvariable=max_percentile, width=7).place(x=180, y=100)


def set_limits():
    global min_percentile, max_percentile
    min_percentile = min_percentile.get()
    max_percentile = max_percentile.get()

separator = ttk.Separator(gui, orient="horizontal")
separator.place(x=0, y=140, relwidth=3)

ttk.Label(frm, text="Interpolation").place(x=0, y=140)
sldr7 = tkinter.Scale(frm, from_=1, to=10, orient=tkinter.HORIZONTAL)
sldr7.place(x=35, y=155)
sldr7.set(1)

itp_type = tkinter.StringVar()  # I hate this box, but it works, so I'm not touching it
cb1 = ttk.Combobox(frm, state='readonly', textvariable=itp_type, values=('Linear', 'Nearest', 'SLinear', 'Cubic',
                                                                         'Quintic', 'PChip'), width=13)
cb1.place(x=157, y=173)
cb1.set('Linear')


def set_interpol_type():
    global itp_type
    itp_type = cb1.get()


cb1.bind('<<ComboboxSelected>>', set_interpol_type)

is_segmentation = tkinter.IntVar(value=0)


def set_profiling():
    global is_segmentation
    is_segmentation = is_segmentation.get()


profiling_chk = ttk.Checkbutton(frm, text='Segmentation', variable=is_segmentation, onvalue=1, offvalue=0)
profiling_chk.place(x=35, y=212)

ttk.Button(frm, text="Proceed", command=lambda: [set_gradient_type(), set_limits(), set_interpol(), set_interpol_type(),
                                                 set_profiling(), gui.destroy()]).place(x=180, y=210)
gui.mainloop()

biomap = pandas.read_csv(filename, sep=' ', header=None)  # Reads the opened biomap
if coreg_img is not None:
    coreg = Image.open(coreg_img)

# Header Generation
if interpol == 1:
    dimX = biomap.iloc[0][1]
    dimY = biomap.iloc[0][0]
else:
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
itp_dic = {"Linear": "linear",
           "Nearest": "nearest",
           "SLinear": "slinear",
           "Cubic": "cubic",
           "Quintic": "quintic",
           "PChip": "pchip"}

itp_type = itp_dic.get(itp_type)

coords = biomap.iloc[:, 0:4]
coordsfinal = coords.drop(0)  # Grabs vertices coordinates without the header
coordsfinal[numpy.isnan(coordsfinal)] = 0

if interpol != 1:
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
    if is_segmentation == 0:
        interp_grid_int = scipy.interpolate.RegularGridInterpolator((orderX, orderY), biomap_int_np, method=itp_type)
    elif is_segmentation == 1:
        interp_grid_int = scipy.interpolate.RegularGridInterpolator((orderX, orderY), biomap_int_np, method='nearest')
    else:
        sys.exit("is_segmentation was not set properly. Review the interface code to find the issue.")

    # Computes every position in X and Y for which we want interpolated data
    neworderX = numpy.arange(coordsfinal.iloc[0][0],
                             max(coordsfinal[0]) + (coordsfinal.iloc[1][1] - coordsfinal.iloc[0][1]),
                             (coordsfinal.iloc[1][1] - coordsfinal.iloc[0][1]) / interpol)
    neworderX = neworderX.round(5)
    neworderX = neworderX[neworderX <= max(coordsfinal[0])]

    neworderY = numpy.arange(coordsfinal.iloc[0][1],
                             coordsfinal.iloc[int(oldimX) - 1][1] + (coordsfinal.iloc[1][1] - coordsfinal.iloc[0][1]),
                             (coordsfinal.iloc[1][1] - coordsfinal.iloc[0][1]) / interpol)
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
if interpol == 1:
    intensities = coordsfinal.iloc[:, 3]
    ovspcoords = coordsfinal.iloc[:, :3]
    ovspcoords = ovspcoords.to_numpy()  # "Oversampled" coordinates does not properly describe this variable anymore
else:
    intensities = ovspcoords[:, 3]
    ovspcoords = ovspcoords[:, :3]
imax = max(intensities)
itstlst = []
for i in intensities:
    itstlst.append(int(i))  # Creates a list of intensities converted to integers

# Colouring of vertices with ColorAide
colours_dict = {"Viridian": [Color("srgb", [0, 0.25, 1]), Color("srgb", [1, 0.7, 0]), Color("srgb", [0, 1, 0]), "linear"],
                "Fusion": [Color("srgb", [1, 1, 0]), Color("srgb", [0, 0.25, 1]), Color("srgb", [1, 0, 0]), "linear"],
                "Halloween": [Color("srgb", [1, 0.4, 0]), Color("srgb", [0.2, 0.1, 0.8]), Color("srgb", [0.3, 1, 0.2]), "linear"],
                "Easter": [Color("srgb", [0, 0, 1]), Color("srgb", [1, 0.6, 0.8]), Color("srgb", [1, 0.6, 0]), "linear"],
                "Magic": [Color("srgb", [0.2, 0.1, 0.66]), Color("srgb", [0, 1, 0]), Color("srgb", [1, 0.8, 0]), "continuous"]}
gradient_base = colours_dict.get(gradient_type)

if coreg_img is None:
    col = Color.interpolate([gradient_base[0], gradient_base[1], gradient_base[2]],
                            space="oklab",
                            method=gradient_base[3])
    colours = numpy.zeros(shape=(vertices, 3))
    rank = 0

    max_cutoff = numpy.percentile(itstlst, float(max_percentile))
    min_cutoff = numpy.percentile(itstlst, float(min_percentile))

    for i in itstlst:
        if i >= int(max_cutoff):
            hue = col(1)
        elif i <= int(min_cutoff):
            hue = col(0)
        else:
            scaled_value = (i - min_cutoff)/(max_cutoff - min_cutoff)
            hue = col(scaled_value)
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
