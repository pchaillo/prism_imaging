from copy import copy

import PySide6.QtWidgets
from coloraide import Color
from functools import partial
from multiprocessing import Pool
import numpy as np
import re
from scipy.ndimage import gaussian_filter
from scipy.sparse import hstack
from PLY_ColourScale_Headless import generate_scale
from snr_compute import noise_estimation_np

def process_csv(worker, full_csv, data_type, main_mz, tolerance, gradient_base,
                cutoff_percentiles, smoothing_flag, smoothing_sigma, clustering_flag, cluster_nb, main_cluster,
                roc_flag, roi_mask, noise_thresholding, thresholds=None):
    """
    Converts selected parts of the CSV file into an images
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
    worker.updateProgress.emit("Recovering File Dimensions")

    # Parse the file to limit unneeded cells in memory
    # TODO: Finalize the conversion to numpy for increased efficiency with sparse files
    
    pattern = "[0-9]"
    data_head_names = np.array([key for key in full_csv.index if not re.search(pattern, key)]) # Contains everything but m/z values
    data_head_mask = full_csv.index.isin(data_head_names)
    data_mz_mask = ~data_head_mask
    data_mz_names = full_csv.index[data_mz_mask].to_numpy()
    
    full_csv_np = full_csv.to_numpy()
    data_head = full_csv_np[data_head_mask]
    data_mz = full_csv_np[data_mz_mask]
    full_csv_idx = full_csv.index.to_numpy()
    full_csv_cols = full_csv.columns.to_numpy()
    
    del full_csv, full_csv_np, data_mz_mask, data_head_mask
    if data_type != "m/Z" and not clustering_flag:
        del data_mz

    # Dimensions recovery, necessary for CSV files
    yvals = np.unique(data_head[0])
    yvals = len(yvals)  # Number of acquired pixels in the Y axis

    xvals = np.unique(data_head[1])
    xvals = len(xvals)  # Number of acquired pixels in the X axis
    
    # Estimate the number of steps for each workflow
    # Dimensions recovery - 1
    total_steps = 1
    if clustering_flag:
        # Preprocessing - 1 / Clustering Proper - 1
        total_steps += 2
        if smoothing_flag:
            # Smoothing - Data Cube Creation - 1 per pixel / Gaussian Filtering - 1
            total_steps += data_mz.shape[1] + 1
        if noise_thresholding:
            if thresholds is None:
                # Per-pixel thresholding
                total_steps += data_mz.shape[1] // 10 # Takes into account the reduction in updates
            # DataFrame rebuilding and masking
            total_steps += 2
        if roi_mask:
            # ROI masking
            total_steps += 1
        if roc_flag:
            total_steps += data_mz.shape[1]
    else:
        # Recovery of the portion of interest
        total_steps += 1
    if smoothing_flag and not clustering_flag:
        # Easier smoothing
        total_steps += 1
    # Assembling coordinates, interpolating colours, creating the SVG and the colour scale
    total_steps += 4
    worker.updateProgressMax.emit(total_steps)

    dimX = xvals
    dimY = yvals
    
    vertices = int(dimX * dimY)
    faces = (dimX - 1) * (dimY - 1)
    faces = int(faces)

    coordsfinal = np.transpose(data_head[np.where(np.isin(data_head_names, ["x", "y", "z"]))[0]])

    # Recover the data of interest
    # Catch the edge case where data is X, Y or Z
    #TODO: Check if clustering works as expected in this format 
    if clustering_flag:
        from sklearn.cluster import KMeans
        worker.updateProgress.emit("Preprocessing for Clustering")

        if smoothing_flag:
            # Try smoothing the data before clustering
            w, h, d = [yvals, xvals, len(data_mz[0])]
            total = w*h
            input_cube = np.zeros((w, h, d))
            for width in range(w):
                for height in range(h):
                    idx = width * height + height
                    input_cube[width, height, :] = data_mz[idx, :].values
                    worker.updateProgress.emit(f"Preparing Full-File Smoothing: {idx}/{total}")
            worker.updateProgress.emit("Gaussian Filtering")
            smoothed_cube = gaussian_filter(input_cube, sigma=(smoothing_sigma, smoothing_sigma, 0))
            data_mz = smoothed_cube.reshape(-1, d)

        #TODO: Do we normalize internally before clustering? Note that we already normalize on TIC. If so, we would
        # ensure that clustering is performed only based on spectral profile rather than intensity, but intensity
        # should already be accounted for by normalization, so maybe this is redundant? Ponder this.

        # Perform noise thresholding if enabled
        if noise_thresholding:
            if thresholds is None:
                thresholds = np.zeros(xvals*yvals)
                # Multiprocessing no longer seems useful for this, as it creates more problems than it solves
                for idx, row in enumerate(np.transpose(data_mz)):
                    if idx % 10 == 0:
                        worker.updateProgress.emit(f"Computing Signal Thresholds: {idx}/{vertices}")
                    threshold = noise_estimation_np(row)
                    thresholds[idx - 1] = threshold

                #with Pool() as pool:
                #    tasks = (
                #        (idx, data_mz[idx])
                #        for idx in range(len(data_mz))
                #    )
                    #worker.updateProgress.emit("Computing Signal Thresholds")
                #    for idx, threshold in pool.imap_unordered(noise_estimation_wrapper, tasks, chunksize=100):
                #        worker.updateProgress.emit(f"Computing Signal Thresholds: {idx}/{vertices}")
                #        thresholds[idx-1] = threshold

            worker.updateProgress.emit(f"Thresholds Recovered. Applying the mask...")
            mask = data_mz >= thresholds
            data_mz[mask] = 0

        if roi_mask:
            worker.updateProgress.emit("Parsing ROI")
            # Second round of trimming if an ROI was specified
            data_mz = data_mz[:, roi_mask]
            data_idx = np.where(np.array(roi_mask)==True)
        else:
            data_idx = range(len(data_mz[0]))

        worker.updateProgress.emit("Performing Clustering")
        kmeans = KMeans(n_clusters=cluster_nb, init='k-means++', random_state=42)

        # Fit the full dataset
        kmeans.fit(np.transpose(data_mz))
        clustering_labels = kmeans.labels_

        # Now accomodates masking properly
        # Modify the clustering to include -1 values for proper padding
        # Those -1 entries will be transparent on the final SVG
        coordsfinal = np.column_stack((coordsfinal, np.full(xvals*yvals,-1)))
        coordsfinal[data_idx, 3] = clustering_labels

        # ROC analysis
        if roc_flag:
            from sklearn.metrics import roc_auc_score
            roc_aucs = []
            y_true = clustering_labels == main_cluster
            total_length = len(data_mz)
            for idx in range(total_length):
                worker.updateProgress.emit(f"Computing ROC Scores: {idx}/{total_length}")
                auc = roc_auc_score(y_true, data_mz[idx], average="weighted")
                roc_aucs.append(auc)

    elif data_type != "m/Z":
        worker.updateProgress.emit("Grabbing Data")
        coordsfinal = np.append(coordsfinal, np.transpose(data_head[np.where(data_head_names == data_type)[0]]), axis=1)

    else:
        #Greatly simplified this logic
        worker.updateProgress.emit("Recovering m/Z window")
        mz_min = main_mz - tolerance
        mz_max = main_mz + tolerance

        # Find columns of interest, choosing bins closest to the specified edges
        mz_vals = data_mz_names.astype(np.float64)
        bin_min = mz_vals[mz_vals - mz_min >= 0].min()
        bin_max = mz_vals[mz_vals - mz_max >= 0].min()
        bin_min_idx = np.where(mz_vals == bin_min)[0][0]
        bin_max_idx = np.where(mz_vals == bin_max)[0][0]
        coordsfinal = np.column_stack((coordsfinal, np.sum(data_mz[bin_min_idx:bin_max_idx+1], axis=0)))
    
    # Gaussian Smoothing
    if smoothing_flag and not clustering_flag:
        worker.updateProgress.emit("Smoothing Selected Data")    
        preprocessed_coords = np.reshape(coordsfinal[:,3], (yvals, xvals))  
        coordinates_smoothed = gaussian_filter(preprocessed_coords, sigma=smoothing_sigma)
        coordsfinal[:,3] = coordinates_smoothed.ravel()
        del preprocessed_coords, coordinates_smoothed

    #In the current iteration, interpolation has been removed as it is mostly used for 3D files 
    intensities = coordsfinal[:, 3]

    worker.updateProgress.emit("Interpolating Colour Values")

    col = Color.interpolate(gradient_base[:-1],
                            space="oklab",
                            method=gradient_base[-1])
    colours = np.zeros(shape=(vertices, 3))
    rank = 0

    max_cutoff = np.percentile(intensities, cutoff_percentiles[1])
    if roi_mask:
        min_cutoff = max(np.percentile(intensities, cutoff_percentiles[0]), 0)
    else:
        min_cutoff = np.percentile(intensities, cutoff_percentiles[0])
    for i in intensities:
        if clustering_flag:
            scaled_value = (i - min(intensities)) / (max(intensities) - min(intensities))
            hue = col(scaled_value)
        else:
            if i >= int(max_cutoff):
                hue = col(1)
            elif i <= int(min_cutoff):
                hue = col(0)
            else:
                scaled_value = (i - min_cutoff) / (max_cutoff - min_cutoff)
                hue = col(scaled_value)
        hue = Color.convert(hue, "srgb")
        colours[rank] = ([hue['r'] * 255, hue['g'] * 255, hue['b'] * 255])
        rank = rank + 1

    # Retrieve cluster colours for ROC analysis and/or clustering
    if clustering_flag:
        cluster_colours = [colour for colour in np.unique(colours, axis=0)]

    # SVG Creation and Exportation
    worker.updateProgress.emit("Creating SVG visual")
    colours_export = colours.reshape((int(dimY), int(dimX), 3))

    h, w, _ = colours_export.shape

    msi_svg = f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {w} {h}">\n'
    idx = 0
    for y in range(h):
        for x in range(w):
            if intensities[idx] == -1 and roi_mask:
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
    worker.updateProgress.emit("Generating Colour Scale")
    scale = generate_scale(name="",
                           gradient=col,
                           intensities_min=0,
                           intensities_max=100,
                           min_cutoff=cutoff_percentiles[0],
                           max_cutoff=cutoff_percentiles[1],
                           export_path_scale="",
                           save=False,
                           central_mz=main_mz,
                           tolerance=tolerance)

    if roc_flag:
        return msi_svg, viewbox, roc_aucs, clustering_labels, cluster_colours, scale, thresholds
    elif clustering_flag:
        return msi_svg, viewbox, None, clustering_labels, cluster_colours, scale, thresholds
    else:
        return msi_svg, viewbox, None, None, None, scale, thresholds

def noise_estimation_wrapper(args):
    spectrum_idx, local_spectrum = args
    threshold = noise_estimation_np(local_spectrum, False)
    return spectrum_idx, threshold

def cross_project_roc(worker, cluster_data_dict, noise_thresholding):
    full_labels = []
    full_data_list = []
    data_indices_list = []
    pool = Pool()

    tasks = [(cluster_data_dict[key], noise_thresholding) for key in cluster_data_dict]

    for idx, (cluster_labels, cluster_data, data_indices) in enumerate(pool.imap_unordered(process_clusters, tasks)):
        full_labels.append(cluster_labels)
        full_data_list.append(cluster_data)
        data_indices_list.append(data_indices)
        worker.updateProgress.emit(f"Processed Clusters: {idx+1}/{len(cluster_data_dict)}")

    # Assume that there are at list two elements, and perform an inner join on the index list
    full_indices = np.intersect1d(data_indices_list[0], data_indices_list[1]).astype(float)
    if len(data_indices_list) > 2:
        for idx in range(2, len(data_indices_list)):
            full_indices = np.intersect1d(full_indices, data_indices_list[idx])
    full_indices = full_indices.astype(float)
    full_indices = np.sort(full_indices)

    # Find out which rows haves indices found in full_indices, so that the eventual array only contains m/z found across all ROIs
    index_masks = []
    for idx in range(len(data_indices_list)):
        mask = np.isin(data_indices_list[idx].astype(float), full_indices)
        index_masks.append(mask)

    joined_data_list = [full_data_list[idx][index_masks[idx]] for idx in range(len(data_indices_list))]
    full_data = hstack(joined_data_list)
    full_data = full_data.toarray()
    full_labels = [label for sublist in full_labels for label in sublist]
    
    worker.updateProgress.emit("Computing ROC-AUCs")
    tasks = [(full_data[mz], full_labels, mz) for mz in range(full_data.shape[0])]
    roc_aucs = [None]*full_data.shape[0]

    for _, (auc, mz) in enumerate(pool.imap_unordered(roc_wrapper, tasks)):
        roc_aucs[mz] = auc

    # Exports the aucs and the mz array so that the file may be saved
    return roc_aucs, full_indices

def process_clusters(arguments):
    # Note: cluster is cluster_data_dict[key]
    cluster, noise_thresholding = arguments
    del arguments

    # Concatenate labels
    cluster_data = cluster["data"]
    intensity_max = cluster_data.max()
    # Normalize the data and multiply it by 100000 to limit the risk of floating point errors
    cluster_data = (cluster_data/intensity_max)*100000
    data_indices = cluster["mz_array"]

    # Perform noise thresholding if enabled
    if noise_thresholding:
        thresholds = np.zeros(len(data_indices))
        # Multiprocessing no longer seems useful for this, as it creates more problems than it solves
        for idx, row in enumerate(cluster_data):
            threshold = noise_estimation_np(row)
            thresholds[idx - 1] = threshold

        mask = cluster_data >= thresholds[:, None]
        cluster_data[mask] = 0

    cluster_labels = [cluster["cluster"]] * cluster_data.shape[1]

    return cluster_labels, cluster_data, data_indices

def roc_wrapper(arguments):
    from sklearn.metrics import roc_auc_score
    data, labels, mz = arguments
    auc = roc_auc_score(labels, data, average="weighted")
    return auc, mz

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