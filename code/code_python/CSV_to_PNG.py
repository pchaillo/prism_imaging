# Validated on Python 3.8.10
# To run manually through MatLab:
#   path(path, 'code/code_python')
#   pyrunfile('#FILE_NAME#.py')
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
import time

# Creation of global variables
filename = None
data_list = None
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
    global filename, data_list, binning_win
    filename = askopenfilename(
        defaultextension='.csv')  # Global allows for modification of a variable out of the function
    biomap = pandas.read_csv(filename, sep=',', index_col='cell1', low_memory=False)
    data_list = biomap.index
    data_list = data_list.to_list()
    data['values'] = data_list
    binning_win = round((float(data_list[12]) - float(data_list[11])), 5)  # Recovers the CSV binning


def on_combobox_change(*args):
    query = data_type.get()
    filtered_data_list = [option for option in data_list if query.lower() in option.lower()]
    data['values'] = filtered_data_list


def set_coreg():
    global coreg_img
    coreg_img = askopenfilename()


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
gui.title("CSV to PNG converter - The small one")
gui.resizable(False, False)
frm = ttk.Frame(gui, padding=10, height=390, width=290)
frm.grid()
ttk.Button(frm, text="Load a CSV", command=uploadaction).place(x=0, y=0)  # Fetches the biomap of interest
ttk.Label(frm, text="Data:").place(x=85, y=3)

data_type = tkinter.StringVar()
data = ttk.Combobox(frm, textvariable=data_type)
data.place(x=120, y=2)


def set_data_type():
    global data_type
    data_type = data.get()


data_list = []
data['values'] = data_list
data.bind('<<ComboboxSelected>>', set_data_type)

data_type.trace('w', on_combobox_change)

ttk.Label(frm, text='M/z +/-').place(x=160, y=30)
img_win = tkinter.StringVar(value= "0")
img_win_input = tkinter.Entry(frm, textvariable=img_win, width=7).place(x=208, y=30)


def windowmaker(resolution, indices=data_type):
    # Function that returns each index of interest in a given window, and then parses the full index list to retain the
    # ones of interest
    window = img_win.get()
    centroid = float(indices.get())
    win_max = centroid + float(window)
    win_min = centroid - float(window)
    cursor = win_min
    target_indices = [win_min]
    while cursor <= win_max:
        cursor = cursor + resolution
        target_indices.append(cursor)
    target_indices_str = []
    for index in target_indices:
        target_indices_str.append(str(index))
    target_indices = [round(index, 5) for index in target_indices]  # Workaround float-related shenanigans
    target_indices_str = []
    for index in target_indices_str:
        if index.endswith('.0'):
            index = index.replace('.0', '')
        target_indices.append(index)
    global data_window
    data_window = []
    for index in target_indices:
        if index in data_list:
            data_window.append(index)
    return data_window

separator = ttk.Separator(gui, orient="horizontal")
separator.place(x=0, y=65, relwidth=3)

ttk.Label(frm, text="Low intensity").place(x=50, y=60)  # Column headers
ttk.Label(frm, text="High intensity").place(x=170, y=60)

ttk.Label(frm, text="Red").place(x=0, y=100)
sldr1 = tkinter.Scale(frm, from_=0, to=255, orient=tkinter.HORIZONTAL)
sldr1.place(x=35, y=80)
sldr1.set(0)
sldr2 = tkinter.Scale(frm, from_=0, to=255, orient=tkinter.HORIZONTAL)
sldr2.place(x=155, y=80)

ttk.Label(frm, text="Green").place(x=0, y=150)
sldr3 = tkinter.Scale(frm, from_=0, to=255, orient=tkinter.HORIZONTAL)
sldr3.place(x=35, y=130)
sldr4 = tkinter.Scale(frm, from_=0, to=255, orient=tkinter.HORIZONTAL)
sldr4.place(x=155, y=130)
sldr4.set(255)

ttk.Label(frm, text="Blue").place(x=0, y=200)
sldr5 = tkinter.Scale(frm, from_=0, to=255, orient=tkinter.HORIZONTAL)
sldr5.place(x=35, y=180)
sldr5.set(255)
sldr6 = tkinter.Scale(frm, from_=0, to=255, orient=tkinter.HORIZONTAL)
sldr6.place(x=155, y=180)
sldr6.set(255)

separator = ttk.Separator(gui, orient="horizontal")
separator.place(x=0, y=240, relwidth=3)

ttk.Label(frm, text="Interpolation").place(x=0, y=235)
sldr7 = tkinter.Scale(frm, from_=1, to=10, orient=tkinter.HORIZONTAL)
sldr7.place(x=35, y=250)
sldr7.set(1)

itp_type = tkinter.StringVar()
cb1 = ttk.Combobox(frm, state='readonly', textvariable=itp_type, values=('Linear', 'Nearest', 'SLinear', 'Cubic',
                                                                         'Quintic', 'PChip'), width=13)
cb1.place(x=157, y=269)
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
profiling_chk.place(x=155, y=303)

ttk.Button(frm, text="Proceed", command=lambda: [fetch_colours(), set_data_type(), set_interpol(), set_interpol_type(),
                                                 set_profiling(), windowmaker(resolution=binning_win), gui.destroy()])\
                                                .place(x=180, y=330)
gui.mainloop()

# End of the GUI loop

biomap = pandas.read_csv(filename, sep=',', index_col='cell1', low_memory=False)
biomap = biomap.transpose()
biomap = biomap.astype(float)
if coreg_img is not None:
    coreg = Image.open(coreg_img)

# Dimensions recovery, necessary for CSV files
yvals = biomap.iloc[:, 0]
yvals = yvals.drop_duplicates()
res = yvals.iloc[1] - yvals.iloc[0]  # Determines the resolution of the map
yvals = yvals.shape[0]  # Number of acquired pixels in the Y axis

xvals = biomap.iloc[:, 1]
xvals = xvals.drop_duplicates()
xvals = xvals.shape[0]  # Number of acquired pixels in the X axis

# Header Generation
if interpol == 1:
    dimX = xvals
    dimY = yvals
else:
    dimX = (xvals * interpol) - (interpol - 1)
    dimY = (yvals * interpol) - (interpol - 1)
oldimX = xvals
oldimY = yvals
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

coordsfinal = biomap.iloc[:, 0:3]
coordsfinal[numpy.isnan(coordsfinal)] = 0  # Probably redundant for CSV, but it doesn't hurt
if len(data_window) == 1:
    data_type = data_window
    coordsfinal[data_type] = biomap[data_type]
else:
    coordsfinal[data_type] = biomap[data_window].sum(1)
coordsfinal = coordsfinal.rename(columns={'x': 0, 'y': 1, 'z': 2, data_type: 3})

if interpol != 1:
    # Data must be mapped in a grid for 2D interpolation. For 2D, we can only implement one dataset at a time. Z heights
    # and intensities therefore get their individual arrays
    biomap_z = coordsfinal.pivot_table(index=[0], columns=[1], values=[2])
    biomap_z_np = biomap_z.to_numpy(dtype=float)  # Conversion to numpy arrays is mandatory for proper indexing
    biomap_int = coordsfinal.pivot_table(index=[0], columns=[1], values=[3])
    biomap_int_np = biomap_int.to_numpy(dtype=float)

    # Computes all positions in X and Y to feed the 2D interpolator
    orderX = biomap.iloc[:, 0]
    orderX = orderX.drop_duplicates()
    res = orderX.iloc[1] - orderX.iloc[0]  # Determines the resolution of the map

    orderY = biomap.iloc[:, 1]
    orderY = orderY.drop_duplicates()

    # Methods for 2D interpolation (str): linear, nearest, slinear, cubic, quintic, pchip
    interp_grid_z = scipy.interpolate.RegularGridInterpolator((orderX, orderY), biomap_z_np, method=itp_type)
    if is_segmentation == 0:
        interp_grid_int = scipy.interpolate.RegularGridInterpolator((orderX, orderY), biomap_int_np, method=itp_type)
    elif is_segmentation == 1:
        interp_grid_int = scipy.interpolate.RegularGridInterpolator((orderX, orderY), biomap_int_np, method='nearest')

    # Computes every position in X and Y for which we want interpolated data
    neworderX = numpy.arange(min(orderX), max(orderX) + res/interpol, res/interpol)
    neworderX = neworderX.round(5)
    neworderX = neworderX[neworderX <= max(orderX)]

    neworderY = numpy.arange(min(orderY), max(orderY) + res/interpol, res/interpol)  # Should work in theory, but floats are garbage
    neworderY = neworderY.round(5)
    neworderY = neworderY[neworderY <= max(orderY)]
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
    ovspcoords = ovspcoords.to_numpy()
else:
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
