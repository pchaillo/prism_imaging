# Validated on Python 3.14
# To run manually through MatLab:
#   path(path, 'code/code_python')
#   pyrunfile('#FILE_NAME#.py')
# If not working:
# _Make sure that Python 3.14 is installed properly
# _Verify that the Matlab version is compatible with Python 3.14
# _Verify that Matlab is using the proper Python environment (i.e: Python 3.14). If not, set it up.
# This code being newer, the interface will be run on PySide instead of Tkinter

import os
import re
import sys

sys.path.insert(0, os.getcwd() + "\\code\\code_python") # Needed so that MatLab can actually find the dependency

from coloraide import Color
import numpy as np
import pandas as pd
from PIL import Image
import scipy
from PySide6.QtWidgets import (QApplication, QCheckBox, QComboBox, QDoubleSpinBox, QFileDialog, QGraphicsScene,
                               QGraphicsView, QGroupBox, QHBoxLayout, QLabel, QMainWindow, QMessageBox, QPushButton,
                               QRadioButton, QSlider, QSplitter, QVBoxLayout, QWidget)
from PySide6.QtCore import Qt, QByteArray
from PySide6.QtSvgWidgets import QSvgWidget, QGraphicsSvgItem
from PySide6.QtSvg import QSvgRenderer
import pyqtgraph as pg
import utils.CSV_Visualizer_utils as cvu
from utils.utils import file_name_recovery

colours_dict = {"Viridian": [Color("srgb", [0, 0.25, 1]), Color("srgb", [1, 0.7, 0]), Color("srgb", [0, 1, 0]), "linear"],
                "Fusion": [Color("srgb", [1, 1, 0]), Color("srgb", [0, 0.25, 1]), Color("srgb", [1, 0, 0]), "linear"],
                "Halloween": [Color("srgb", [1, 0.4, 0]), Color("srgb", [0.2, 0.1, 0.8]), Color("srgb", [0.3, 1, 0.2]), "linear"],
                "Easter": [Color("srgb", [0, 0, 1]), Color("srgb", [1, 0.6, 0.8]), Color("srgb", [1, 0.6, 0]), "linear"],
                "Magic": [Color("srgb", [0.2, 0.1, 0.66]), Color("srgb", [0, 1, 0]), Color("srgb", [1, 0.8, 0]), "continuous"],
                "Viridis": [Color("srgb", [0.267, 0.004, 0.329]), Color("srgb", [0.213, 0.322, 0.545]),
                            Color("srgb", [0.129, 0.569, 0.549]), Color("srgb", [0.369, 0.788, 0.384]),
                            Color("srgb", [0.992, 0.906, 0.145]), "linear"]
                }

interp_dict = {"Linear": "linear",
           "Nearest": "nearest",
           "SLinear": "slinear",
           "Cubic": "cubic",
           "Quintic": "quintic",
           "PChip": "pchip"}

class ZoomableGraphicsView(QGraphicsView):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._zoom = 0
        self._zoom_step = 1.25
        self._zoom_range = (-10, 20)

        self.setTransformationAnchor(QGraphicsView.AnchorUnderMouse)
        self.setResizeAnchor(QGraphicsView.AnchorUnderMouse)

    def wheelEvent(self, event):
        if event.angleDelta().y() == 0:
            return

        direction = 1 if event.angleDelta().y() > 0 else -1
        new_zoom = self._zoom + direction

        if not (self._zoom_range[0] <= new_zoom <= self._zoom_range[1]):
            return

        factor = self._zoom_step if direction > 0 else 1 / self._zoom_step
        self.scale(factor, factor)
        self._zoom = new_zoom

class MSI_Visualizer(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("STORM-MSI Visualizer")
        self.setWindowState(Qt.WindowMaximized)

        # Initialize default values
        self.central_mz = None
        self.clustering = None
        self.cluster_nb = None
        self.data_list = None
        self.filename = None
        self.full_csv = None
        self.gradient_name = None
        self.itp_type = None
        self.plots = {}
        self.region = None
        self.selected_dtype = None
        self.smoothing = None # If True, Gaussian smoothing is applied to the image
        self.smoothing_sigma = None # Standard deviation of smoothed values, higher increases the smoothing
        self.svg = None
        self.tolerance = None

        # Default Icon Colours
        self.icon_colours = {"rest": "darkblue",
                             "set": "limegreen",
                             "error": "orangered"}

        # Worker
        self.worker = None

        # Initialize the central widget and layout
        central_widget = QSplitter(Qt.Vertical)
        self.setCentralWidget(central_widget)
        main_layout = QVBoxLayout(central_widget)

        # Initialize the overarching data ingestion and analysis layout
        stgs_anls_widget = QWidget()
        stgs_anls_layout = QVBoxLayout(stgs_anls_widget)

        # Initialize the data ingestion sublayout
        settings_widget = QGroupBox("Settings")
        settings_layout = QVBoxLayout(settings_widget)

        # File loading and data selection, combined in a single widget
        load_widget = QWidget()
        load_layout = QHBoxLayout(load_widget)

        load_btn = QPushButton("CSV")
        load_btn.clicked.connect(self.upload_action)

        self.data_cbbx = QComboBox()
        self.data_cbbx.setEditable(False)
        self.data_cbbx.currentIndexChanged.connect(self.on_dtype_selection)

        load_layout.addWidget(load_btn)
        load_layout.addWidget(self.data_cbbx)

        ## Subwidget for m/Z tolerance
        tolerance_widget = QWidget()
        tolerance_layout = QHBoxLayout(tolerance_widget)

        self.tolerance_lbl = QLabel("Tolerance: +/-")
        self.tolerance_spnbx = QDoubleSpinBox()
        self.tolerance_spnbx.setRange(0, 1000)
        self.tolerance_spnbx.setSingleStep(0.01)
        self.tolerance_spnbx.setValue(0.1)
        self.tolerance_spnbx.setSuffix(" m/Z")

        tolerance_layout.addWidget(self.tolerance_lbl)
        tolerance_layout.addWidget(self.tolerance_spnbx)
        ##

        self.gradient_cbbx = QComboBox()
        self.gradient_cbbx.setEditable(False)
        self.gradient_cbbx.addItems(list(colours_dict.keys()))

        self.interp_lbl = QLabel("Interpolation: x1")

        self.interp_slider = QSlider(Qt.Horizontal)
        self.interp_slider.setMinimum(1)
        self.interp_slider.setMaximum(10)
        self.interp_slider.setValue(1)
        self.interp_slider.setTickInterval(1)
        self.interp_slider.setTickPosition(QSlider.TickPosition.TicksBelow)
        self.interp_slider.valueChanged.connect(self.update_interp)

        self.interp_cbbx = QComboBox()
        self.interp_cbbx.setEditable(False)
        self.interp_cbbx.addItems(list(interp_dict.keys()))

        # Create a subwidget for clustering
        clustering_widget = QWidget()
        clustering_layout = QHBoxLayout(clustering_widget)

        self.clustering_chkbx = QCheckBox("Clustering")
        self.clustering_chkbx.setToolTip("Performs clustering on the entire image")

        self.cluster_nb_spnbx = QDoubleSpinBox()
        self.cluster_nb_spnbx.setToolTip("Determines how many clusters are formed")
        self.cluster_nb_spnbx.setRange(2,100)
        self.cluster_nb_spnbx.setValue(2)
        self.cluster_nb_spnbx.setSingleStep(1)
        self.cluster_nb_spnbx.setDecimals(0)
        self.cluster_nb_spnbx.setSuffix(" Clusters")

        clustering_layout.addWidget(self.clustering_chkbx)
        clustering_layout.addWidget(self.cluster_nb_spnbx)

        # Create subwidget for smoothing
        smoothing_widget = QWidget()
        smoothing_layout = QHBoxLayout(smoothing_widget)

        self.smoothing_chkbx = QCheckBox("Gaussian Smoothing")

        self.smoothing_sigma_field = QDoubleSpinBox()
        self.smoothing_sigma_field.setRange(0, 100)
        self.smoothing_sigma_field.setValue(0.3)
        self.smoothing_sigma_field.setSingleStep(0.1)
        self.smoothing_sigma_field.setSuffix(" Sigma")
        smoothing_layout.addWidget(self.smoothing_chkbx)
        smoothing_layout.addWidget(self.smoothing_sigma_field)

        update_btn = QPushButton("Update")
        update_btn.clicked.connect(self.forceUpdate)

        # Populate the settings widget
        settings_layout.addWidget(load_widget)
        settings_layout.addWidget(tolerance_widget)
        settings_layout.addWidget(self.gradient_cbbx)
        settings_layout.addWidget(self.interp_lbl)
        settings_layout.addWidget(self.interp_slider)
        settings_layout.addWidget(self.interp_cbbx)
        settings_layout.addWidget(clustering_widget)
        settings_layout.addWidget(smoothing_widget)
        settings_layout.addWidget(update_btn)

        # Create an analysis widget
        analysis_widget = QGroupBox("Analysis")
        self.analysis_layout = QVBoxLayout(analysis_widget)

        roc_analysis_btn = QPushButton("ROC Analysis")
        roc_analysis_btn.clicked.connect(self.plot_roc_analysis)
        roc_export_btn = QPushButton("ROC Export")
        spectrum_view = QGroupBox("Toggle Spectra")
        spectrum_view.setFlat(True)

        self.analysis_layout.addWidget(roc_analysis_btn)
        self.analysis_layout.addWidget(roc_export_btn)
        self.analysis_layout.addWidget(spectrum_view)

        # Populate the Settings/Analysis Widget
        stgs_anls_layout.addWidget(settings_widget)
        stgs_anls_layout.addWidget(analysis_widget)

        # Initialize the MSI visualizer
        self.topological_renderer = QSvgRenderer()
        self.topological_item = QGraphicsSvgItem()
        self.topological_item.setSharedRenderer(self.topological_renderer)
        self.topo_frag_scene = QGraphicsScene()
        self.topo_frag_scene.addItem(self.topological_item)
        self.topo_frag_scene.setBackgroundBrush(Qt.GlobalColor.darkGray)
        self.topo_frag_view = ZoomableGraphicsView(self.topo_frag_scene)

        self.topo_frag_view.setDragMode(QGraphicsView.ScrollHandDrag)
        self.topo_frag_view.setTransformationAnchor(QGraphicsView.AnchorUnderMouse)

        # Initialize the spectrum visualizer
        pg.setConfigOption('background', 'w')  # White background
        pg.setConfigOption('foreground', 'k')  # Black axes/grid

        self.spectrum_widget = pg.PlotWidget()
        self.spectrum_widget.setLabel('bottom', 'm/Z')
        self.spectrum_widget.setLabel('left', 'Intensity (A.U.)')
        self.spectrum_widget.setLimits(xMin=0, yMin=0)

        # Create and populate a widget to handle settings and MSI data
        settings_msi_widget = QSplitter(Qt.Horizontal)
        settings_msi_layout = QHBoxLayout(settings_msi_widget)
        settings_msi_layout.addWidget(stgs_anls_widget)
        settings_msi_layout.addWidget(self.topo_frag_view)
        settings_msi_widget.setSizes([100, 1000])


        # Create the final layout
        main_layout.addWidget(settings_msi_widget)
        main_layout.addWidget(self.spectrum_widget)
        central_widget.setSizes([400,200])

        # Connect Click event
        self.spectrum_widget.scene().sigMouseClicked.connect(self.on_mouse_clicked)


    def upload_action(self):
        initial_dir = os.path.dirname(os.path.abspath(__file__))
        filename = QFileDialog.getOpenFileName(self, "CSV File Selection", initial_dir, "STORM-MSI File (*.csv)")[0]
        self.filename = filename.replace("/", "\\")
        self.full_csv = pd.read_csv(filename, sep=',', index_col='Data Type', low_memory=False)
        data_list = self.full_csv.index
        data_list = data_list.to_list()
        binning_win = round((float(data_list[12]) - float(data_list[11])), 5)  # Recovers the CSV binning

        self.data_list = data_list # Useful for later analyses

        # Only retains non-mz entries
        pattern = "[0-9]"
        data_list = [d for d in data_list if not re.search(pattern, d)]

        data_list.append("m/Z")

        self.clear_spectra("Total")
        self.clear_class_vars()
        self.data_cbbx.addItems(data_list)
        self.plot_average_spectrum(data_list[:-1]) # Removes the last entry for this purpose, as it is not a proper label

    def clear_class_vars(self):
        self.central_mz = None
        self.clustering = None
        self.cluster_nb = None
        self.gradient_name = None
        self.itp_type = None
        self.plots = {}
        self.region = None
        self.selected_dtype = None
        self.smoothing = None  # If True, Gaussian smoothing is applied to the image
        self.smoothing_sigma = None  # Standard deviation of smoothed values, higher increases the smoothing
        self.svg = None
        self.tolerance = None

        self.data_cbbx.clear()

    def update_interp(self):
        value = self.interp_slider.value()
        self.interp_lbl.setText(f"Interpolation: x{str(value)}")

    def plot_average_spectrum(self, data_list):
        avg_spectrum = self.full_csv.drop(data_list, axis=0).mean(axis=1).reset_index().set_axis([0, 1], axis=1).astype("float64")
        self.spectrum_widget.clear()
        self.plot_spectrum("Global_Avg", avg_spectrum[0], avg_spectrum[1], pg.mkPen(color="b", width=1), True)

        self.spectrum_widget.setLimits(xMin= avg_spectrum[0].min(), xMax= avg_spectrum[0].max(), yMin= 0, yMax= 1)
        self.spectrum_widget.setRange(xRange=(avg_spectrum[0].min(), avg_spectrum[0].max()), yRange =(0, avg_spectrum[1].max()), padding=1)

    def on_dtype_selection(self):
        if self.data_cbbx.currentText() != "m/Z":
            self.tolerance_spnbx.setEnabled(False)
            self.spectrum_widget.setEnabled(False)
        else:
            self.tolerance_spnbx.setEnabled(True)
            self.spectrum_widget.setEnabled(True)
        self.get_settings()
        self.render_msi("Data_Type_Selection")

    def on_mouse_clicked(self, event):
        if event._button == Qt.LeftButton:
            if self.spectrum_widget.sceneBoundingRect().contains(event.scenePos()):
                mouse_point = self.spectrum_widget.plotItem.vb.mapSceneToView(event.scenePos())
                x = mouse_point.x()
                y = mouse_point.y()
                self.central_mz = x

                self.get_settings()
                self.spectrum_widget.removeItem(self.region)
                self.region = pg.LinearRegionItem(values=(x-self.tolerance, x+self.tolerance), orientation="vertical", brush=pg.mkBrush(color=(255, 0, 0, 100)))
                # Note: The region needs to be made persistent to be removable without clearing the full widget
                self.spectrum_widget.addItem(self.region)

                self.render_msi("m/Z_Selection")

    def get_settings(self):
        self.gradient_name = self.gradient_cbbx.currentText()
        self.itp_factor = self.interp_slider.value()
        self.itp_type = self.interp_slider.value()
        self.clustering = self.clustering_chkbx.isChecked()
        self.cluster_nb = int(self.cluster_nb_spnbx.value())
        self.selected_dtype = self.data_cbbx.currentText()
        self.smoothing = self.smoothing_chkbx.isChecked()
        self.smoothing_sigma = self.smoothing_sigma_field.value()
        self.tolerance = self.tolerance_spnbx.value()

    def render_msi(self, origin):
        # TODO: Implement an overlay with key information, like the colour scale
        if not self.central_mz and self.selected_dtype == "m/Z":
            # Duplicate with the forceUpdate function, but fails silently instead
            return
        gradient = colours_dict.get(self.gradient_name)
        cutoff_percentiles = [0, 100] #TODO: Put this back in the interface

        if origin == "ROC_Analysis":
            # Overrides settings to ensure proper behaviour
            self.svg, viewbox, roc_aucs, clustering_lbls = cvu.process_csv(self.filename, self.full_csv,
                                                                           self.selected_dtype, self.central_mz,
                                                                           self.tolerance, self.itp_factor,
                                                                           self.itp_type, gradient, cutoff_percentiles,
                                                                           self.smoothing,
                                                                           self.smoothing_sigma, True,
                                                                           self.cluster_nb, True)
        else:
            self.svg, viewbox, roc_aucs, clustering_lbls = cvu.process_csv(self.filename, self.full_csv,
                                            self.selected_dtype, self.central_mz, self.tolerance, self.itp_factor,
                                            self.itp_type, gradient, cutoff_percentiles, self.smoothing,
                                            self.smoothing_sigma, self.clustering, self.cluster_nb, False)
        self.update_svg(self.svg.encode("utf-8"), viewbox)

        return roc_aucs, clustering_lbls

    def update_svg(self, picture, viewbox):
        self.topological_img = QByteArray(picture)
        self.topological_renderer.load(self.topological_img)

        # This forces an update somehow
        self.topological_item.setSharedRenderer(self.topological_renderer)

        # Tell Qt the item's geometry changed
        self.topo_frag_scene.setSceneRect(viewbox[0], viewbox[1], viewbox[2], viewbox[3])
        self.topo_frag_view.fitInView(self.topo_frag_scene.sceneRect(), Qt.KeepAspectRatio)

    def forceUpdate(self):
        self.get_settings()
        if not self.filename:
            QMessageBox.warning(self, "Error", "Please select a CSV file exported from STORM-MSI, and try again.")
            return
        if not self.central_mz and self.selected_dtype == "m/Z":
            QMessageBox.warning(self, "Error", "Please select a peak on the average spectrum, and try again.")
            return
        else:
            self.render_msi("Forced_Update")

    def plot_roc_analysis(self):
        roc_aucs, clustering_lbls = self.render_msi(origin="ROC_Analysis")

        indices = list(self.plots["Global_Avg"].get("plot").xData)

        # Lone exception that will not be normalized, as the maximum value is already 1
        self.clear_spectra("ROC")
        self.plot_spectrum("ROC_Analysis", indices, roc_aucs, pg.mkPen(color="lightgrey", width=1), False)

    def plot_spectrum(self, name:str, spectrum_x, spectrum_y, pen:pg.mkPen, normalize=True):
        # Helper function that can normalize spectra before rendering them, helpful for ROC visualization
        if normalize:
            spectrum_y = spectrum_y/spectrum_y.max()
        plot = pg.PlotDataItem(spectrum_x, spectrum_y, pen=pen)
        plot.setZValue(len(self.plots) + 1)
        self.spectrum_widget.addItem(plot)

        # Create a checkbox for the spectrum
        checkbox = QCheckBox(name)
        checkbox.setChecked(True)
        checkbox.toggled.connect(lambda state:[plot.setVisible(state), self.sort_plots(name, checkbox)])

        self.plots[name] = {"checkbox":checkbox, "plot":plot}
        self.analysis_layout.addWidget(checkbox)

    def sort_plots(self, name, checkbox):
        # Recomputes which element is in the foreground, if and only if the target spectrum has already been drawn once.
        # Otherwise, they default on the foreground
        if self.plots and name in self.plots.keys() and checkbox.isChecked():
            z_values = pd.DataFrame(columns=["name", "z_value"])
            for idx, plot_name in enumerate(self.plots.keys()):
                z_values.loc[idx, :] = [plot_name, self.plots[plot_name].get("plot").zValue()]

            z_values[z_values["name"] == name] = [name, len(self.plots.keys())*2]
            z_values.sort_values("z_value", ascending=True, inplace=True)
            z_values["z_value"] = range(len(self.plots.keys()))

            for i in range(len(self.plots)):
                self.plots[z_values.loc[i, "name"]].get("plot").setZValue(i)

    def clear_spectra(self, extent="Total"):
        # Extent: Total = Everything / ROC = ROC Analysis & Clusters / Clusters = Cluster Average Spectra Only
        whitelist = {"Total": None,
                     "ROC": ["Global_Avg"],
                     "Clusters": ["Global_Avg", "ROC_Analysis"]}
        target_ids = []
        for name in self.plots.keys():
            if name not in whitelist[extent]:
                self.analysis_layout.removeWidget(self.plots[name].get("checkbox"))
                self.spectrum_widget.removeItem(self.plots[name].get("plot"))
                target_ids.append(name)
        # Dict culling must come later to avoid errors related to dictionary size changing during iterations
        for name in target_ids:
                self.plots.pop(name) # Drops the entry from the dictionary

if __name__ == "__main__":
    app = QApplication(sys.argv)
    gui = MSI_Visualizer()
    gui.show()

    sys.exit(app.exec())