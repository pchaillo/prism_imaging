from copy import copy
from coloraide import Color
import numpy as np
import pandas as pd
from PIL import Image
import re
import scipy

def process_csv(filename, data_type, main_mz, tolerance, itp_factor, itp_type, gradient_base, cutoff_percentiles, segmentation_flag):
    """
    Converts selected parts of the CSV file into an images
    :param filename: Full path (including name and extension) to the CSV file
    :param data_type: Data type selected to be displayed
    :param main_mz: Central m/Z selected on the average spectrum, used only if m/Z selected as data_type
    :param tolerance: m/Z tolerance, used only if m/Z selected as data_type
    :param itp_type: Interpolation type, unused if left at 1
    :param gradient_base: Gradient type used to reconstruct the image
    :param segmentation_flag: If true, data segmentation is locked to nearest neighbour
    :return: An SVG file of the image, to be displayed in the interface
    """
    full_csv = pd.read_csv(filename, sep=',', index_col='Data Type', low_memory=False)
    full_csv = full_csv.transpose()
    full_csv = full_csv.astype(float)

    # Dimensions recovery, necessary for CSV files
    yvals = full_csv.iloc[:, 0].drop_duplicates()
    res = yvals.iloc[1] - yvals.iloc[0]  # Determines the resolution of the map
    yvals = yvals.shape[0]  # Number of acquired pixels in the Y axis

    xvals = full_csv.iloc[:, 1].drop_duplicates()
    xvals = xvals.shape[0]  # Number of acquired pixels in the X axis

    if itp_factor == 1:
        dimX = xvals
        dimY = yvals
    else:
        dimX = (xvals * itp_factor) - (itp_factor - 1)
        dimY = (yvals * itp_factor) - (itp_factor - 1)
    oldimX = xvals
    oldimY = yvals
    vertices = int(dimX * dimY)
    old_vertices = int(oldimX * oldimY)
    edges = itp_factor * dimX * dimY - dimX - dimY  # See Grid Graphs properties, seems wrong
    faces = (dimX - 1) * (dimY - 1)
    faces = int(faces)

    coordsfinal = full_csv.iloc[:, 0:3]
    coordsfinal[np.isnan(coordsfinal)] = 0  # Probably redundant for CSV, but it doesn't hurt

    # Recover the data of interest
    # Catch the edge case where data is X, Y or Z
    if data_type in ["x", "y", "z"]:
        old_dtype = copy(data_type)
        data_type = data_type + "_data"

    if data_type != "m/Z":
        coordsfinal[data_type] = full_csv[old_dtype]
    else:
        mz_min = main_mz - tolerance
        mz_max = main_mz + tolerance

        # Find columns of interest, chosing bins closest to the specified edges
        pattern = "[0-9]"
        full_idx = full_csv.columns.to_list()
        mz_vals = [float(val) for val in full_idx if re.search(pattern, val)]

        mz_vals_min = [abs(mz - mz_min) for mz in mz_vals]
        mz_idx_min = mz_vals_min.index(min(mz_vals_min))
        mz_bin_min = str(mz_vals[mz_idx_min])
        true_min_idx = full_csv.columns.get_loc(mz_bin_min)

        mz_vals_max = [abs(mz - mz_max) for mz in mz_vals]
        mz_idx_max = mz_vals_max.index(min(mz_vals_max))
        mz_bin_max = str(mz_vals[mz_idx_max])
        true_max_idx = full_csv.columns.get_loc(mz_bin_max)

        coordsfinal["data"] = full_csv.iloc[:, true_min_idx-1:true_max_idx].sum(1)
    coordsfinal = coordsfinal.rename(columns={'x': 0, 'y': 1, 'z': 2, data_type: 3})

    if itp_factor != 1:
        # Data must be mapped in a grid for 2D interpolation. For 2D, we can only implement one dataset at a time. Z heights
        # and intensities therefore get their individual arrays
        full_csv_z = coordsfinal.pivot_table(index=[0], columns=[1], values=[2])
        full_csv_z_np = full_csv_z.to_numpy(dtype=float)  # Conversion to numpy arrays is mandatory for proper indexing
        full_csv_int = coordsfinal.pivot_table(index=[0], columns=[1], values=[3])
        full_csv_int_np = full_csv_int.to_numpy(dtype=float)

        # Computes all positions in X and Y to feed the 2D interpolator
        orderX = full_csv.iloc[:, 0]
        orderX = orderX.drop_duplicates()
        res = orderX.iloc[1] - orderX.iloc[0]  # Determines the resolution of the map

        orderY = full_csv.iloc[:, 1]
        orderY = orderY.drop_duplicates()

        # Methods for 2D interpolation (str): linear, nearest, slinear, cubic, quintic, pchip
        interp_grid_z = scipy.interpolate.RegularGridInterpolator((orderX, orderY), full_csv_z_np, method=itp_type)
        if is_segmentation == 0:
            interp_grid_int = scipy.interpolate.RegularGridInterpolator((orderX, orderY), full_csv_int_np, method=itp_type)
        elif is_segmentation == 1:
            interp_grid_int = scipy.interpolate.RegularGridInterpolator((orderX, orderY), full_csv_int_np, method='nearest')

        # Computes every position in X and Y for which we want interpolated data
        neworderX = np.arange(min(orderX), max(orderX) + res/itp_factor, res/itp_factor)
        neworderX = neworderX.round(5)
        neworderX = neworderX[neworderX <= max(orderX)]

        neworderY = np.arange(min(orderY), max(orderY) + res/itp_factor, res/itp_factor)  # Should work in theory, but floats are garbage
        neworderY = neworderY.round(5)
        neworderY = neworderY[neworderY <= max(orderY)]
        yy2, xx2 = np.meshgrid(neworderY, neworderX)

        # Creates a flattened array of X and Y couples, akin to an interpolated version of columns 1 and 2 of the full csv
        target_pts = np.vstack([xx2.ravel(), yy2.ravel()])
        target_pts = target_pts.transpose()

        # Returns the interpolated data
        z_interpol = interp_grid_z(target_pts)
        int_interpol = interp_grid_int(target_pts)

        # All data is then compiled into a single array for further analysis
        ovspcoords = np.vstack([z_interpol, int_interpol])
        ovspcoords = ovspcoords.transpose()
        ovspcoords = np.hstack([target_pts, ovspcoords])

    # MS intensities extraction
    if itp_factor == 1:
        intensities = coordsfinal.iloc[:, 3]
        ovspcoords = coordsfinal.iloc[:, :3]
        ovspcoords = ovspcoords.to_numpy()
    else:
        intensities = ovspcoords[:, 3]
        ovspcoords = ovspcoords[:, :3]
    imax = max(intensities)
    itstlst = []
    for i in intensities:
        itstlst.append(i)  # Creates a list of intensities

    col = Color.interpolate(gradient_base[:-1],
                            space="oklab",
                            method=gradient_base[-1])
    colours = np.zeros(shape=(vertices, 3))
    rank = 0

    max_cutoff = np.percentile(itstlst, cutoff_percentiles[1])
    min_cutoff = np.percentile(itstlst, cutoff_percentiles[0])

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

    # SVG Creation and Exportation

    #colours_int = colours.astype(int)
    colours_export = colours.reshape((int(dimY), int(dimX), 3))

    h, w, _ = colours_export.shape

    msi_svg = f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {w} {h}">\n'

    for y in range(h):
        for x in range(w):
            r, g, b = colours_export[y, x]
            msi_svg += (
                f'<rect x="{x}" y="{y}" width="{res*2}" height="{res*2}" '
                f'fill="rgb({r},{g},{b})"/>\n'
            )

    msi_svg += '</svg>'

    viewbox = [0, 0, w, h]
    return msi_svg, viewbox

