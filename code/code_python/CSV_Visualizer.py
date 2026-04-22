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
from copy import copy
import numpy as np
import pandas as pd
from PIL import Image
import scipy
from PySide6.QtWidgets import (QApplication, QCheckBox, QComboBox, QDoubleSpinBox, QFileDialog, QGraphicsScene,
                               QGraphicsView, QGroupBox, QGridLayout, QHBoxLayout, QLabel, QLayout, QMainWindow, QMessageBox, QPushButton,
                               QRadioButton, QSizePolicy, QSlider, QSplitter, QTreeWidget, QTreeWidgetItem, QVBoxLayout, QWidget)
from PySide6.QtCore import Qt, QByteArray
from PySide6.QtSvgWidgets import QSvgWidget, QGraphicsSvgItem
from PySide6.QtSvg import QSvgRenderer
import pyqtgraph as pg
from qtawesome import icon
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
        ## Global interface values
        self.central_mz = None
        self.clustering = None
        self.cluster_nb = None
        self.former_project = None # Temporarily stores the old project's name for deletion purposes
        self.current_project = None  # Stores project index, for the project dictionary
        self.gradient_name = None
        self.itp_type = None
        self.projects= {} # Stores project values
        self.selected_dtype = None
        self.smoothing = None  # If True, Gaussian smoothing is applied to the image
        self.smoothing_sigma = None  # Standard deviation of smoothed values, higher increases the smoothing
        self.tolerance = None
        #TODO: Add clipping here

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
        stgs_anls_layout.setContentsMargins(5, 0, 0, 0)
        stgs_anls_layout.setSpacing(0)

        # Initialize the data ingestion sublayout
        settings_widget = QGroupBox("Settings")
        settings_layout = QVBoxLayout(settings_widget)
        settings_layout.setContentsMargins(5, 0, 5, 5)
        settings_layout.setSpacing(1)

        # File loading and data selection, combined in a single widget
        load_widget = QWidget()
        load_layout = QHBoxLayout(load_widget)

        load_btn = QPushButton("CSV")
        load_btn.setIcon(icon("ei.file"))
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

        self.smoothing_chkbx = QCheckBox("Smoothing")
        self.smoothing_chkbx.setToolTip("Adds Gaussian Smoothing to the data\nto preserve features as much as possible.")

        self.smoothing_sigma_field = QDoubleSpinBox()
        self.smoothing_sigma_field.setRange(0, 100)
        self.smoothing_sigma_field.setValue(0.3)
        self.smoothing_sigma_field.setSingleStep(0.1)
        self.smoothing_sigma_field.setSuffix(" Sigma")
        smoothing_layout.addWidget(self.smoothing_chkbx)
        smoothing_layout.addWidget(self.smoothing_sigma_field)

        update_btn = QPushButton("Update")
        update_btn.setIcon(icon("ei.refresh"))
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
        analysis_layout = QVBoxLayout(analysis_widget)
        analysis_layout.setContentsMargins(5, 0, 5, 5)
        analysis_layout.setSpacing(0)

        analysis_btns_widget = QWidget()
        analysis_btns_widget.setMaximumHeight(30)
        analysis_btns_layout = QHBoxLayout(analysis_btns_widget)
        analysis_btns_layout.setContentsMargins(0, 0, 0, 0)
        analysis_btns_layout.setSpacing(0)
        roc_analysis_btn = QPushButton("ROC")
        roc_analysis_btn.setFixedWidth(70)
        roc_analysis_btn.setIcon(icon("ei.cogs"))
        roc_analysis_btn.clicked.connect(self.plot_roc_analysis)
        self.roc_main_cluster_spnbx = QDoubleSpinBox(prefix= "Main Cluster: ", decimals=0, minimum=0,
                                                     maximum=self.cluster_nb_spnbx.value()-1, singleStep=1)
        roc_export_btn = QPushButton()
        roc_export_btn.setIcon(icon("ei.download-alt"))
        roc_export_btn.setFixedWidth(30)
        roc_export_btn.clicked.connect(self.export_roc)

        self.spectrum_view_widget = QGroupBox("Toggle Spectra")
        self.spectrum_view_widget.setFlat(True)
        self.spectrum_view_layout = QGridLayout(self.spectrum_view_widget)
        analysis_btns_layout.addWidget(roc_analysis_btn)
        analysis_btns_layout.addWidget(self.roc_main_cluster_spnbx)
        analysis_btns_layout.addWidget(roc_export_btn)

        analysis_layout.addWidget(analysis_btns_widget)
        analysis_layout.addWidget(self.spectrum_view_widget)

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

        # Create a file tree widget
        file_tree_widget = QGroupBox("Files in Project")
        file_tree_layout = QVBoxLayout(file_tree_widget)
        file_tree_layout.setContentsMargins(0, 0, 0, 0)

        self.file_tree = QTreeWidget(columnCount=2)
        self.file_tree.setHeaderHidden(True)
        #self.file_tree.header().setSectionResizeMode(0, QHeaderView.Stretch)
        #self.file_tree.header().setSectionResizeMode(1, QHeaderView.Fixed)
        self.file_tree.setHorizontalScrollBarPolicy(Qt.ScrollBarPolicy.ScrollBarAlwaysOff)
        self.file_tree.setColumnWidth(0, 180)
        self.file_tree.setColumnWidth(1, 20)
        self.file_tree.currentItemChanged.connect(self.project_changed)
        file_tree_layout.addWidget(self.file_tree)

        # Create and populate a widget to handle settings and MSI data
        settings_msi_widget = QSplitter(Qt.Horizontal)
        settings_msi_layout = QHBoxLayout(settings_msi_widget)
        settings_msi_layout.addWidget(stgs_anls_widget)
        settings_msi_layout.addWidget(self.topo_frag_view)
        settings_msi_layout.addWidget(file_tree_widget)
        settings_msi_widget.setSizes([145, 800, 200])

        # Create the final layout
        main_layout.addWidget(settings_msi_widget)
        main_layout.addWidget(self.spectrum_widget)
        central_widget.setSizes([400,200])

        # Connect Click event
        self.spectrum_widget.scene().sigMouseClicked.connect(self.on_mouse_clicked)

    def upload_action(self):
        initial_dir = os.path.dirname(os.path.abspath(__file__))
        filename = QFileDialog.getOpenFileName(self, "CSV File Selection", initial_dir, "STORM-MSI File (*.csv)")[0]
        if not filename:
            return
        filename = filename.replace("/", "\\")

        if len(self.projects.keys()) == 0:
            idx = 0
        else:
            # Finds the first unused index and uses it
            idx = max(self.projects.keys())+1
            for i in range(max(self.projects.keys())):
                if self.project.get(idx) is None:
                    idx = i
                    return
        self.create_project(idx)

        self.projects[idx]["current_filename"] = filename
        self.projects[idx]["full_csv"] = pd.read_csv(filename, sep=',', index_col='Data Type', low_memory=False)
        data_list = self.projects[idx]["full_csv"].index
        data_list = data_list.to_list()
        binning_win = round((float(data_list[12]) - float(data_list[11])), 5)  # Recovers the CSV binning

        # Populate the file tree
        filename_tree = os.path.split(filename)[1]
        tree_entry = QTreeWidgetItem({filename_tree: []})
        self.projects[idx]["tree_entry"] = tree_entry
        self.file_tree.addTopLevelItem(tree_entry)
        delete_btn = QPushButton()
        delete_btn.setIcon(icon("ei.trash"))
        delete_btn.clicked.connect(lambda: [self.clear_spectra(idx, "Total", True),
                                   self.file_tree.takeTopLevelItem(self.file_tree.indexOfTopLevelItem(tree_entry)),
                                   self.projects.pop(idx)
                                   ])
        self.file_tree.setItemWidget(tree_entry, 1, delete_btn)

        # Only retains non-mz entries
        pattern = "[0-9]"
        data_list = [d for d in data_list if not re.search(pattern, d)]
        self.projects[idx]["data_list"] = copy(data_list) # Useful for later analyses

        #self.clear_spectra("Former", "Total", False) # We cannot rely on the valueChanged callback for this one
        self.file_tree.setCurrentItem(tree_entry)
        self.plot_average_spectrum(data_list)

        data_list.append("m/Z")
        self.data_cbbx.clear()
        self.data_cbbx.addItems(data_list)

    def create_project(self, idx):
        self.projects[idx] = {
            "data_list":None,
            "current_filename":None,
            "full_csv":None,
            "mass_range":None,
            "plots":{},
            "region":None,
            "svg":None,
            "tree_entry":None,
            "viewbox":None
        }
        # Update the current and former project
        if self.former_project is None:
            self.former_project = -1
        else:
            self.former_project = copy(self.current_project)
        self.current_project = idx

    def clear_class_vars(self): # Seems to cause more issues than it solves now
        self.projects[self.current_project]["plots"] = {}
        self.projects[self.current_project]["region"] = None
        self.spectrum_widget.removeItem(self.projects[self.current_project]["region"])

    def update_interp(self):
        value = self.interp_slider.value()
        self.interp_lbl.setText(f"Interpolation: x{str(value)}")

    def plot_average_spectrum(self, data_list):
        avg_spectrum = self.projects[self.current_project]["full_csv"].drop(data_list, axis=0).mean(axis=1).reset_index().set_axis([0, 1], axis=1).astype("float64")
        self.plot_spectrum("Global_Avg", avg_spectrum[0], avg_spectrum[1], pg.mkPen(color="b", width=1), True)

        self.spectrum_widget.setLimits(xMin= avg_spectrum[0].min(), xMax= avg_spectrum[0].max(), yMin= 0, yMax= 1)
        self.spectrum_widget.setRange(xRange=(avg_spectrum[0].min(), avg_spectrum[0].max()), yRange =(0, avg_spectrum[1].max()), padding=1)

        self.projects[self.current_project]["mass_range"] = [avg_spectrum[0].min(), avg_spectrum[0].max()]

    def on_dtype_selection(self):
        if self.data_cbbx.currentText() == "":
            return
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
                self.spectrum_widget.removeItem(self.projects[self.current_project]["region"])
                self.projects[self.current_project]["region"]  = pg.LinearRegionItem(values=(x-self.tolerance, x+self.tolerance), orientation="vertical", brush=pg.mkBrush(color=(255, 0, 0, 100)))
                # Note: The region needs to be made persistent to be removable without clearing the full widget
                self.spectrum_widget.addItem(self.projects[self.current_project]["region"])

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
            self.projects[self.current_project]["svg"], viewbox, roc_aucs, clustering_lbls, cluster_colours = cvu.process_csv(self.projects[self.current_project]["current_filename"],
                                                                           self.projects[self.current_project]["full_csv"],
                                                                           self.selected_dtype, self.central_mz,
                                                                           self.tolerance, self.itp_factor,
                                                                           self.itp_type, gradient, cutoff_percentiles,
                                                                           self.smoothing,
                                                                           self.smoothing_sigma, True,
                                                                           self.cluster_nb, True)
            self.update_svg(self.projects[self.current_project]["svg"].encode("utf-8"), viewbox)
            return roc_aucs, clustering_lbls, cluster_colours

        else:
            self.projects[self.current_project]["svg"], viewbox, _, _, _ = cvu.process_csv(self.projects[self.current_project]["current_filename"],
                                            self.projects[self.current_project]["full_csv"],
                                            self.selected_dtype, self.central_mz, self.tolerance, self.itp_factor,
                                            self.itp_type, gradient, cutoff_percentiles, self.smoothing,
                                            self.smoothing_sigma, self.clustering, self.cluster_nb, False)
        self.update_svg(self.projects[self.current_project]["svg"].encode("utf-8"), viewbox)
        self.projects[self.current_project]["viewbox"] = viewbox

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
        if not self.projects[self.current_project]["current_filename"]:
            QMessageBox.warning(self, "Error", "Please select a CSV file exported from STORM-MSI, and try again.")
            return
        if not self.central_mz and self.selected_dtype == "m/Z":
            QMessageBox.warning(self, "Error", "Please select a peak on the average spectrum, and try again.")
            return
        else:
            self.render_msi("Forced_Update")

    def plot_roc_analysis(self):
        roc_aucs, clustering_lbls, cluster_colours = self.render_msi(origin="ROC_Analysis")

        indices = list(self.projects[self.current_project]["plots"]["Global_Avg"].get("plot").xData)

        # Lone exception that will not be normalized, as the maximum value is already 1
        self.clear_spectra("Current", "ROC", True)
        self.plot_spectrum("ROC_Analysis", indices, roc_aucs, pg.mkPen(color="lightgrey", width=1), False)

        global_data = self.projects[self.current_project]["full_csv"].copy()
        global_data.columns = clustering_lbls
        # Plot the average spectrum of each cluster
        for idx, label in enumerate(np.unique(clustering_lbls)):
            avg_spectrum = global_data[label].drop(self.projects[self.current_project]["data_list"], axis=0).mean(
                axis=1).reset_index().set_axis([0, 1], axis=1).astype("float64")
            self.plot_spectrum(f"Cluster_{label}", avg_spectrum[0], avg_spectrum[1], pg.mkPen(cluster_colours[idx], width=1))
            # Add children to the file tree for later cluster analysis
            child = QTreeWidgetItem({f"Cluster_{label}":[]})
            child.setFlags(child.flags() | Qt.ItemIsUserCheckable)
            child.setCheckState(1, Qt.Checked)
            self.projects[self.current_project]["tree_entry"].addChild(child)
        self.projects[self.current_project]["tree_entry"].setExpanded(True)

    def plot_spectrum(self, name:str, spectrum_x, spectrum_y, pen:pg.mkPen, normalize=True):
        # Helper function that can normalize spectra before rendering them, helpful for ROC visualization
        if normalize:
            spectrum_y = spectrum_y/spectrum_y.max()
        plot = pg.PlotDataItem(spectrum_x, spectrum_y, pen=pen)
        plot.setZValue(len(self.projects[self.current_project]["plots"]) + 1)
        self.spectrum_widget.addItem(plot)
        self.create_checkbox(name, plot)

    def create_checkbox(self, name, plot):
        # Create a checkbox for the spectrum
        checkbox = QCheckBox(name)
        checkbox.toggled.connect(lambda state: [plot.setVisible(state), self.sort_plots(name, checkbox)])
        checkbox.setChecked(True)

        self.projects[self.current_project]["plots"][name] = {"checkbox":checkbox, "plot":plot}

        count = self.spectrum_view_layout.count()
        row = count // 2
        col = count % 2

        self.spectrum_view_layout.addWidget(checkbox, row, col)

    def sort_plots(self, name, checkbox):
        # Recomputes which element is in the foreground, if and only if the target spectrum has already been drawn once.
        # Otherwise, they default on the foreground
        if self.projects[self.current_project]["plots"] and name in self.projects[self.current_project]["plots"].keys() and checkbox.isChecked():
            z_values = pd.DataFrame(columns=["name", "z_value"])
            for idx, plot_name in enumerate(self.projects[self.current_project]["plots"].keys()):
                z_values.loc[idx, :] = [plot_name, self.projects[self.current_project]["plots"][plot_name].get("plot").zValue()]

            z_values[z_values["name"] == name] = [name, len(self.projects[self.current_project]["plots"].keys())*2]
            z_values.sort_values("z_value", ascending=True, inplace=True)
            z_values["z_value"] = range(len(self.projects[self.current_project]["plots"].keys()))

            for i in range(len(self.projects[self.current_project]["plots"])):
                self.projects[self.current_project]["plots"][z_values.loc[i, "name"]].get("plot").setZValue(i)
            self.topo_frag_view.update()

    def clear_spectra(self, project, extent="Total", dict_culling = True):
        # Extent: Total = Everything / ROC = ROC Analysis & Clusters / Clusters = Cluster Average Spectra Only
        # Project = "Former", "Current", or project index

        if type(project) is int:
            idx = project
        elif project == "Former":
            idx = self.former_project
        else:
            idx = self.current_project

        if idx == -1:
            # Aborts if there is no former project to actually clear
            return

        whitelist = {"Total": [],
                     "ROC": ["Global_Avg"],
                     "Clusters": ["Global_Avg", "ROC_Analysis"]}

        target_ids = []
        for name in self.projects[idx]["plots"].keys():
            if name not in whitelist[extent]:
                checkbox = self.projects[idx]["plots"][name]["checkbox"]
                plot = self.projects[idx]["plots"][name]["plot"]
                checkbox_idx = self.spectrum_view_layout.indexOf(checkbox)
                delete_order = self.spectrum_view_layout.takeAt(checkbox_idx)
                delete_order.widget().deleteLater()
                # removeWidget apparently is not the command needed to properly delete: https://stackoverflow.com/questions/9899409/pyside-removing-a-widget-from-a-layout
                self.spectrum_view_layout.removeWidget(self.projects[idx]["plots"][name]["checkbox"])
                self.spectrum_widget.removeItem(self.projects[idx]["plots"][name]["plot"])

                target_ids.append(name)

        # Dict culling must come later to avoid errors related to dictionary size changing during iterations
        if dict_culling:
            for name in target_ids:
                self.projects[idx]["plots"].pop(name) # Drops the entry from the dictionary

    def export_roc(self):
        if not self.projects[self.current_project]["plots"]:
            return
        if not self.projects[self.current_project]["plots"]["ROC_Analysis"]:
            QMessageBox.warning(self, "Error", "Please perform a ROC analysis first, and try again." )
            return
        else:
            roc = pd.DataFrame([self.projects[self.current_project]["plots"]["ROC_Analysis"].get("plot").xData,
                                self.projects[self.current_project]["plots"]["ROC_Analysis"].get("plot").yData]).T
            filename = self.projects[self.current_project]["current_filename"]
            export_name = f"{os.path.split(filename)[0]}\\ROC\\{os.path.split(filename)[1].split(".")[0]}-ROC.csv"
            os.mkdir(os.path.split(export_name)[0])
            roc.to_csv(export_name, index=None, header=None, columns=None, sep=",")
            QMessageBox.information(self, "Sucess", f"ROC exported in {os.path.split(export_name)[0]}.")

    def project_changed(self, item, previous): # Should work fine outside project creation
        #print(f"Change: idx{self.current_project} -> idx{self.file_tree.indexOfTopLevelItem(item)}\nFormer Project Idx: {self.former_project}")
        new_project_flag = False
        if item is None:
            return
        if (item.parent() is not None
                or item == previous):
                #or self.current_project == self.file_tree.indexOfTopLevelItem(item)):
            # Filter only parent items
            # Discard project creations
            return

        if self.current_project == self.file_tree.indexOfTopLevelItem(item):
            self.clear_spectra("Former", "Total", False)
            new_project_flag = True

        # Populating the new project
        self.former_project = copy(self.current_project)
        self.current_project = self.file_tree.indexOfTopLevelItem(item)
        if not new_project_flag:
            self.data_cbbx.clear()
            self.clear_spectra("Former", "Total", False)

        if self.former_project == -1 or new_project_flag:
            # Spots the initial project and new projects after that
            return
        else:
            local_list = copy(self.projects[self.current_project]["data_list"])
            local_list.append("m/Z")
            self.data_cbbx.addItems(local_list)
            self.spectrum_widget.setLimits(xMin=self.projects[self.current_project]["mass_range"][0],
                                           xMax=self.projects[self.current_project]["mass_range"][1])
            self.spectrum_widget.setRange(xRange=(self.projects[self.current_project]["mass_range"][0],
                                                  self.projects[self.current_project]["mass_range"][1]), padding=1)

            # Update checkboxes
            for item in self.projects[self.current_project]["plots"].keys():
                plot = self.projects[self.current_project]["plots"][item]["plot"]
                self.spectrum_widget.addItem(plot)
                self.create_checkbox(item, plot)
            # Update plots
            if self.projects[self.current_project]["svg"] is not None:
                self.update_svg(self.projects[self.current_project]["svg"], self.projects[self.current_project]["viewbox"])

if __name__ == "__main__":
    app = QApplication(sys.argv)
    gui = MSI_Visualizer()
    gui.show()

    sys.exit(app.exec())