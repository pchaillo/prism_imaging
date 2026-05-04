from copy import copy

import PySide6.QtWidgets
from coloraide import Color
import numpy as np
import pandas as pd
from PIL import Image
import re
from scipy import interpolate
from scipy.ndimage import gaussian_filter
from PLY_ColourScale_Headless import generate_scale

def process_csv(filename, full_csv, data_type, main_mz, tolerance, itp_factor, itp_type, gradient_base,
                cutoff_percentiles, smoothing_flag, smoothing_sigma, clustering_flag, cluster_nb, main_cluster,
                roc_flag, roi_mask):
    """
    Converts selected parts of the CSV file into an images
    :param filename: Full path (including name and extension) to the CSV file
    :param full_csv: Preloaded CSV file to improve performance
    :param data_type: Data type selected to be displayed
    :param main_mz: Central m/Z selected on the average spectrum, used only if m/Z selected as data_type
    :param tolerance: m/Z tolerance, used only if m/Z selected as data_type
    :param itp_factor: Interpolation factor, higher creates more points
    :param itp_type: Interpolation type, unused if left at 1
    :param gradient_base: Gradient type used to reconstruct the image
    :param cutoff_percentiles: List of the min and max percentile above which the colour scale clips to better visualize central values
    :param smoothing_flag: If true, data smoothing is applied to the image
    :param smoothing_sigma: Sigma value [0-Infinity] of the Gaussian smoothing function, higher increases the smoothing
    :param clustering_flag
    :param cluster_nb: Number of clusters formed by k-means
    :param main_cluster: Cluster used as ground value for ROC analysis
    :param roc_flag: Determines whether to perform ROC analysis
    :param roi_mask: Sequential list that retrieves pixels found in the ROI
    :return: An SVG file of the image, to be displayed in the interface, several helper values
    """

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

    if clustering_flag:
        from sklearn.cluster import KMeans
        # Only retains non-mz entries
        pattern = "[0-9]"
        columns_list = [col for col in full_csv.columns if not re.search(pattern, col)]
        input_data = full_csv.drop(columns_list, axis=1)
        full_length = len(input_data)
        if roi_mask:
            # Second round of trimming if an ROI was specified
            input_data = input_data[roi_mask]

        kmeans = KMeans(n_clusters=cluster_nb, init='k-means++', random_state=42)

        # Fit the full dataset
        kmeans.fit(input_data)
        clustering_labels = kmeans.labels_

        # Now accomodates masking properly
        # Modify the clustering to include -1 values for proper padding
        # Those -1 entries will be transparent on the final SVG
        coordsfinal.loc[input_data.index, "data"] = clustering_labels
        coordsfinal.fillna({"data":-1}, inplace=True)

        # Test ROC analysis
        roc_aucs = []
        y_true = clustering_labels[clustering_labels == main_cluster]
        if roc_flag:
            from sklearn.metrics import roc_auc_score
            for idx, _ in enumerate(input_data):
                auc = roc_auc_score(clustering_labels, input_data.iloc[:, idx], average="weighted")
                roc_aucs.append(auc)

    elif data_type != "m/Z":
        coordsfinal["data"] = full_csv[data_type]

    else:
        mz_min = main_mz - tolerance
        mz_max = main_mz + tolerance

        # Find columns of interest, choosing bins closest to the specified edges
        pattern = "[0-9]"
        full_idx = full_csv.columns.to_list()
        mz_vals = [float(val) for val in full_idx if re.search(pattern, val)]

        pattern = ".[0]{1,}+(?![1-9])"
        mz_vals_min = [abs(mz - mz_min) for mz in mz_vals]
        mz_idx_min = mz_vals_min.index(min(mz_vals_min))
        mz_bin_min = str(mz_vals[mz_idx_min])
        if re.search(pattern, mz_bin_min):
            mz_bin_min = mz_bin_min.split(".")[0]
        true_min_idx = full_csv.columns.get_loc(mz_bin_min)

        mz_vals_max = [abs(mz - mz_max) for mz in mz_vals]
        mz_idx_max = mz_vals_max.index(min(mz_vals_max))
        mz_bin_max = str(mz_vals[mz_idx_max])
        if re.search(pattern, mz_bin_max):
            mz_bin_max = mz_bin_max.split(".")[0]
        true_max_idx = full_csv.columns.get_loc(mz_bin_max)

        coordsfinal["data"] = full_csv.iloc[:, true_min_idx-1:true_max_idx].sum(1)

    # Gaussian Smoothing
    if smoothing_flag and not clustering_flag:
        preprocessed_coords = coordsfinal.pivot_table(index="x", columns="y", values="data")
        coordinates_smoothed = gaussian_filter(preprocessed_coords, sigma=smoothing_sigma)
        coordsfinal["data"] = coordinates_smoothed.ravel()

    if itp_factor != 1:
        # Data must be mapped in a grid for 2D interpolation. For 2D, we can only implement one dataset at a time. Z heights
        # and intensities therefore get their individual arrays
        full_csv_z = coordsfinal.pivot_table(index="x", columns="y", values="z")
        full_csv_z_np = full_csv_z.to_numpy(dtype=float)  # Conversion to numpy arrays is mandatory for proper indexing
        full_csv_int = coordsfinal.pivot_table(index="x", columns="y", values="data")
        full_csv_int_np = full_csv_int.to_numpy(dtype=float)

        # Computes all positions in X and Y to feed the 2D interpolator
        orderX = full_csv.iloc[:, 0]
        orderX = orderX.drop_duplicates()
        res = orderX.iloc[1] - orderX.iloc[0]  # Determines the resolution of the map

        orderY = full_csv.iloc[:, 1]
        orderY = orderY.drop_duplicates()

        # Methods for 2D interpolation (str): linear, nearest, slinear, cubic, quintic, pchip
        # z is kept, but interpolated as nearest neighbour for now as it is unused. This also makes the usual
        # segmentation flag pointless, and it was thus removed
        interp_grid_z = interpolate.RegularGridInterpolator((orderX, orderY), full_csv_z_np, method="nearest")
        if clustering_flag:
            itp_type = "nearest"
        interp_grid_int = interpolate.RegularGridInterpolator((orderX, orderY), full_csv_int_np, method=itp_type)

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
        intensities = ovspcoords[:, 3]
        ovspcoords = ovspcoords[:, :3]

    # MS intensities extraction
    else:
        intensities = coordsfinal.iloc[:, 3]
        ovspcoords = coordsfinal.iloc[:, :3]
        ovspcoords = ovspcoords.to_numpy()

    imax = max(intensities)
    itstlst = [i for i in intensities]

    col = Color.interpolate(gradient_base[:-1],
                            space="oklab",
                            method=gradient_base[-1])
    colours = np.zeros(shape=(vertices, 3))
    rank = 0

    max_cutoff = np.percentile(itstlst, cutoff_percentiles[1])
    if roi_mask:
        min_cutoff = max(np.percentile(itstlst, cutoff_percentiles[0]), 0)
    else:
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

    # Retrieve cluster colours for ROC analysis and/or clustering
    if clustering_flag:
        cluster_colours = [colour for colour in np.unique(colours, axis=0)]

    # SVG Creation and Exportation

    colours_export = colours.reshape((int(dimY), int(dimX), 3))

    h, w, _ = colours_export.shape

    msi_svg = f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {w} {h}">\n'
    idx = 0
    coordsfinal.reset_index(inplace=True, drop=True)
    for y in range(h):
        for x in range(w):
            if coordsfinal.loc[idx, "data"] == -1 and roi_mask:
                opacity = 0
            else:
                opacity = 1
            r, g, b = colours_export[y, x]
            msi_svg += (
                f'<rect x="{x}" y="{y}" width="1" height="1" '
                f'fill="rgb({r},{g},{b})" fill-opacity="{opacity}"/>\n'
            )
            idx+=1

    msi_svg += '</svg>'

    viewbox = [0, 0, w, h]

    # Create the colour scale:
    # Note: Path names are optional since this function call does not save anything. Will update arguments to reflect
    # that at some point.
    scale = generate_scale(name="",
                           gradient=col,
                           intensities_min=round(min(intensities)),
                           intensities_max=round(max(intensities)),
                           min_cutoff=min_cutoff,
                           max_cutoff=max_cutoff,
                           export_path_scale="",
                           save=False)

    if roc_flag:
        return msi_svg, viewbox, roc_aucs, clustering_labels, cluster_colours, scale
    elif clustering_flag:
        return msi_svg, viewbox, None, clustering_labels, cluster_colours, scale
    else:
        return msi_svg, viewbox, None, None, None, scale

def cross_project_roc(cluster_data_dict):
    from sklearn.metrics import roc_auc_score

    roc_aucs = []
    full_labels = []
    full_data_list = []
    for key in cluster_data_dict:
        # Concatenate labels
        cluster_data = cluster_data_dict[key]["data"]
        full_labels.append([cluster_data_dict[key]["cluster"]] * len(cluster_data.iloc[0,:]))
        full_data_list.append(cluster_data)
    full_data = pd.concat(full_data_list, axis=1, join='inner', ignore_index=True).T
    full_labels = [label for sublist in full_labels for label in sublist]
    for mz in full_data:
        auc = roc_auc_score(full_labels, full_data.loc[:, mz], average="weighted")
        roc_aucs.append(auc)

    # Exports the aucs and the mz array so that the file may be saved
    return roc_aucs, full_data.columns.array

def save_project(app:PySide6.QtWidgets.QMainWindow):
    import json
    #TODO: Finalize and implement
    settings_dict = {}
    settings_dict["projects"] = app.projects
    settings_dict["visualizer"] = {
        "draw_mode": app.topo_frag_view.draw_mode,
        "pen": app.topo_frag_view.pen,
        "points": app.topo_frag_view.points,
        "polygon_points": app.topo_frag_view.polygon_points,
        "scale_pixmap": app.topo_frag_view.scale_pixmap,
        "scale_rect": app.topo_frag_view.scale_rect,
        "scene_polygon": app.topo_frag_view.scene_polygon,
        "snap_distance": app.topo_frag_view.snap_distance,
        "temp_lines":app.topo_frag_view.temp_lines
    }

    settings_dict = json.JSONEncoder.encode(settings_dict)

def take_screenshot(app):
    from PySide6.QtGui import QImage, QPixmap, QPainter
    from PySide6.QtCore import Qt
    from PySide6.QtWidgets import QMessageBox
    import os

    if app.current_project is None:
        QMessageBox.warning(app, "Error", "Please first load a file before trying to take a screenshot.")
        return

    # Screenshot the SVG Widget
    svg_pixmap = app.topo_frag_view.viewport().grab()
    svg_pixmap.setDevicePixelRatio(1)
    svg_width = svg_pixmap.width()
    svg_height = svg_pixmap.height()

    # Screenshot the corresponding spectrum
    spectrum_pixmap = app.spectrum_widget.viewport().grab()
    spectrum_pixmap.setDevicePixelRatio(1)
    spectrum_width = spectrum_pixmap.width()
    spectrum_height = spectrum_pixmap.height()

    # Resize the SVG pixmap to match the spectrum's width
    svg_scaled_pixmap = svg_pixmap.scaledToWidth(spectrum_width, Qt.TransformationMode.FastTransformation)
    svg_scaled_height = svg_scaled_pixmap.height()

    # Create an empty PixMap for export
    export = QImage(spectrum_width, svg_scaled_height + spectrum_height, QImage.Format.Format_ARGB32)

    painter = QPainter(export)
    painter.drawPixmap(0, 0, svg_scaled_pixmap)
    painter.drawPixmap(0, svg_scaled_height, spectrum_pixmap)
    painter.end()

    # Recover the export name
    project_filename = app.projects[app.current_project]["current_filename"]
    if app.clustering_chkbx.isChecked():
        #TODO: Implement a proper way to check that clustering data is displayed. This is weak
        dtype = "Clustering"
    else:
        dtype = app.selected_dtype
        if dtype == "m/Z":
            if app.central_mz is not None:
                central_mz = str(round(app.central_mz, 3)).replace(".", "-")
                dtype = f"mZ-{central_mz}"
            else:
                QMessageBox.warning(app, "Error", "No m/Z selected. To take a screenshot, select an m/Z or pick another category.")
                return
    export_folder = f"{os.path.split(project_filename)[0]}\\screenshots\\"
    if not os.path.isdir(export_folder):
        os.mkdir(export_folder)

    export_name = f"{export_folder}{os.path.split(project_filename)[1].split('.')[0]}-{dtype}.png"
    if os.path.isfile(export_name):
        export_name_raw = export_name.split(".")[0]
        idx = 1
        while os.path.isfile(export_name):
            export_name = f"{export_name_raw}({idx}).png"
            idx +=1

    export.save(export_name, quality=-1)
    QMessageBox.information(app, "Success", f"Screenshot saved in {export_folder}")