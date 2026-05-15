import os
import re
import sys

sys.path.append("..")

from coloraide import Color
from copy import copy
import numpy as np
import pandas as pd
from PIL import Image
import scipy
from PySide6.QtWidgets import (QApplication, QButtonGroup, QCheckBox, QColorDialog, QComboBox, QDoubleSpinBox,
                               QFileDialog, QGraphicsScene, QGraphicsLineItem, QGraphicsPolygonItem, QGraphicsView,
                               QGroupBox, QGridLayout, QHeaderView, QInputDialog, QHBoxLayout, QLabel, QLayout, QMainWindow,
                               QMessageBox, QProgressBar, QProgressDialog, QPushButton, QScrollArea, QSizePolicy,
                               QSlider, QSplitter, QTreeWidget, QTreeWidgetItem, QVBoxLayout, QWidget)
from PySide6.QtCore import Qt, QByteArray, QLineF, QPointF, QRect, QThread, QTimer, Signal, Slot
from PySide6.QtGui import QIcon, QPainter, QPainterPath, QPen, QPixmap, QPolygonF
from PySide6.QtSvgWidgets import QSvgWidget, QGraphicsSvgItem
from PySide6.QtSvg import QSvgRenderer
import pyqtgraph as pg
from qtawesome import icon
from superqt import QLabeledDoubleRangeSlider

from CSV_Visualizer_ROC_Window import GlobalRocPanel
from CSV_Visualizer_ROC_Display_Popup import GlobalRocDisplay
from utils import parse_imaging_file
from workers.workers import Worker
import CSV_Visualizer_utils as cvu

class ZoomableGraphicsView(QGraphicsView):
    roi_drawn = Signal()
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._zoom = 0
        self._zoom_step = 1.25
        self._zoom_range = (-10, 20)

        self.draw_mode = False
        self.pen = None
        self.points = []
        self.polygon_points = []
        #self.preview_line = None #TODO
        self.scale_pixmap = None
        self.scale_rect = None
        self.scene_polygon = None
        self.snap_distance = 3
        self.temp_lines = []

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

    def mousePressEvent(self, event):
        if self.draw_mode and event.button() == Qt.LeftButton:
            pt = self.mapToScene(event.pos())
            if len(self.points) >= 3:
                if self.is_near_first_point(pt):
                    self.close_polygon()
                    return
            self.points.append(pt)

            # Draw lines
            if len(self.points) >= 2:
                temp_line = QLineF()
                temp_line.setPoints(self.points[-1], self.points[-2])
                self.temp_lines.append(temp_line)

                self.scene().addLine(temp_line, pen=self.pen)
            return

        super().mousePressEvent(event)

    def is_near_first_point(self, pt):
        first = self.points[0]
        return (pt - first).manhattanLength() < self.snap_distance

    def close_polygon(self):
        for item in self.scene().items():
            if type(item) is QGraphicsLineItem:
                self.scene().removeItem(item)

        poly = QPolygonF(self.points)
        self.scene_polygon = self.scene().addPolygon(poly, pen=self.pen)
        self.draw_mode = False

        path = QPainterPath()
        path.addPolygon(poly)

        scene_rect = self.sceneRect()

        # Loop through each point to check if it is found in the polygon
        # Direct conversion to integers since each square corresponds to 1px
        for x in range(int(scene_rect.width())):
            for y in range(int(scene_rect.height())):
                # Look for the point's center
                point = QPointF(x+0.5, y+0.5)
                if path.contains(point):
                    self.polygon_points.append([x,y])

        self.roi_drawn.emit()

    def drawForeground(self, painter, rect):
        super().drawForeground(painter, rect)

        if self.scale_pixmap is None:
            return

        painter.setOpacity(1)
        painter.save()
        painter.resetTransform()

        painter.drawPixmap(self.scale_rect, self.scale_pixmap)
        painter.restore()

class MSI_Visualizer(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("STORM-MSI Visualizer")
        self.setWindowIcon(QIcon(QPixmap("resources\\STORM-MSI_Visualizer-roc.svg")))
        self.setWindowState(Qt.WindowMaximized)

        # Initialize default values
        ## Class-wide interface values
        self.central_mz = None
        self.central_mz_region = None
        self.clustering = False
        self.cluster_nb = None
        self.former_project = None # Temporarily stores the old project's name for deletion purposes
        self.current_project = None  # Stores project index, for the project dictionary
        self.cutoff_percentiles = None
        self.gradient_name = None
        self.global_roc_display = None
        self.global_thresholding = False # Determines whether signal thresholding is applied during cross-project ROC
        self.itp_type = None
        self.main_cluster = None
        self.progressDialog = None # Used for progress updates during reconstruction
        self.projects= {} # Stores project values
        self.roc_panel = None
        self.selected_dtype = None
        self.smoothing = False  # If True, Gaussian smoothing is applied to the image
        self.smoothing_sigma = None  # Standard deviation of smoothed values, higher increases the smoothing
        self.thresholding = False
        self.tolerance = None

        # Dictionaries
        self.colours_dict = {
            "Viridian": [Color("srgb", [0, 0.25, 1]), Color("srgb", [1, 0.7, 0]), Color("srgb", [0, 1, 0]), "linear"],
            "Fusion": [Color("srgb", [1, 1, 0]), Color("srgb", [0, 0.25, 1]), Color("srgb", [1, 0, 0]), "linear"],
            "Halloween": [Color("srgb", [1, 0.4, 0]), Color("srgb", [0.2, 0.1, 0.8]), Color("srgb", [0.3, 1, 0.2]),
                          "linear"],
            "Easter": [Color("srgb", [0, 0, 1]), Color("srgb", [1, 0.6, 0.8]), Color("srgb", [1, 0.6, 0]), "linear"],
            "Magic": [Color("srgb", [0.2, 0.1, 0.66]), Color("srgb", [0, 1, 0]), Color("srgb", [1, 0.8, 0]),
                      "continuous"],
            "Viridis": [Color("srgb", [0.267, 0.004, 0.329]), Color("srgb", [0.213, 0.322, 0.545]),
                        Color("srgb", [0.129, 0.569, 0.549]), Color("srgb", [0.369, 0.788, 0.384]),
                        Color("srgb", [0.992, 0.906, 0.145]), "linear"]
            }

        self.interp_dict = {
            "Linear": "linear",
            "Nearest": "nearest",
            "SLinear": "slinear",
            "Cubic": "cubic",
            "Quintic": "quintic",
            "PChip": "pchip"}

        # Default Icon Colours
        self.icon_colours = {"rest": "darkblue",
                             "set": "limegreen",
                             "error": "orangered"}

        # Workers
        self.workers = {"msi":None,
                        "roc":None}

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
        settings_layout.setSpacing(0)

        # File loading and data selection, combined in a single widget
        load_widget = QWidget()
        load_layout = QHBoxLayout(load_widget)
        load_layout.setSpacing(1)

        load_btn = QPushButton()
        load_btn.setIcon(icon("ei.file-new"))
        load_btn.setFixedWidth(32)
        load_btn.setToolTip("Load an imaging (CSV/Parquet) file from STORM-MSI")
        load_btn.clicked.connect(self.upload_action)

        screenshot_btn = QPushButton()
        screenshot_btn.setIcon(icon("ei.camera"))
        screenshot_btn.setFixedWidth(32)
        screenshot_btn.setToolTip("Take a picture of the current spectrum and MSI data")
        screenshot_btn.clicked.connect(lambda:cvu.take_screenshot(self))

        self.data_cbbx = QComboBox()
        self.data_cbbx.setEditable(False)
        self.data_cbbx.currentIndexChanged.connect(self.on_dtype_selection)

        load_layout.addWidget(load_btn)
        load_layout.addWidget(screenshot_btn)
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

        #TODO: Phase-out interpolation, as it is not really useful since smoothing has been implemented
        self.interp_lbl = QLabel("Interpolation: x1")

        self.interp_widget = QWidget()
        self.interp_layout = QHBoxLayout(self.interp_widget)
        self.interp_slider = QSlider(Qt.Horizontal)
        self.interp_slider.setMinimum(1)
        self.interp_slider.setMaximum(10)
        self.interp_slider.setValue(1)
        self.interp_slider.setTickInterval(1)
        self.interp_slider.setTickPosition(QSlider.TickPosition.TicksBelow)
        self.interp_slider.valueChanged.connect(self.update_interp)

        self.interp_cbbx = QComboBox()
        self.interp_cbbx.setEditable(False)
        self.interp_cbbx.addItems(list(self.interp_dict.keys()))

        self.interp_layout.addWidget(self.interp_slider)
        self.interp_layout.addWidget(self.interp_cbbx)

        # Create a subwidget for clustering
        clustering_widget = QWidget()
        clustering_layout = QHBoxLayout(clustering_widget)

        self.clustering_chkbx = QPushButton()
        self.clustering_chkbx.setIcon(QIcon(QPixmap("resources\\clustering-off.svg")))
        self.clustering_chkbx.setFixedWidth(32)
        self.clustering_chkbx.clicked.connect(self.toggle_clustering)
        #self.clustering_chkbx = QCheckBox("Clustering")
        self.clustering_chkbx.setToolTip("Performs clustering on the entire image")

        self.thresholding_btn = QPushButton()
        self.thresholding_btn.setIcon(QIcon(QPixmap("resources\\noise_level_detection_off.svg")))
        self.thresholding_btn.setFixedWidth(32)
        self.thresholding_btn.clicked.connect(self.toggle_thresholding)
        self.thresholding_btn.setToolTip("Applies an automatic threshold to each pixel for clustering. This operation,\n"
                                         "while expensive, helps with clustering accuracy. Note that it is only performed\n"
                                         "once per project to save computation time.")
        self.thresholding_btn.setEnabled(False)

        self.cluster_nb_spnbx = QDoubleSpinBox()
        self.cluster_nb_spnbx.setToolTip("Determines how many clusters are formed")
        self.cluster_nb_spnbx.setRange(2,100)
        self.cluster_nb_spnbx.setValue(2)
        self.cluster_nb_spnbx.setSingleStep(1)
        self.cluster_nb_spnbx.setDecimals(0)
        self.cluster_nb_spnbx.setSuffix(" Clusters")
        self.cluster_nb_spnbx.setEnabled(False)

        clustering_layout.addWidget(self.clustering_chkbx)
        clustering_layout.addWidget(self.thresholding_btn)
        clustering_layout.addWidget(self.cluster_nb_spnbx)

        # Create subwidget for smoothing
        smoothing_widget = QWidget()
        smoothing_layout = QHBoxLayout(smoothing_widget)

        self.smoothing_chkbx = QPushButton()
        self.smoothing_chkbx.setIcon(QIcon(QPixmap("resources\\smoothing-off.svg")))
        self.smoothing_chkbx.setFixedWidth(32)
        self.smoothing_chkbx.clicked.connect(self.toggle_smoothing)
        self.smoothing_chkbx.setToolTip("Adds Gaussian Smoothing to the data\nto preserve features as much as possible.")

        self.smoothing_sigma_field = QDoubleSpinBox()
        self.smoothing_sigma_field.setRange(0, 100)
        self.smoothing_sigma_field.setValue(0.6)
        self.smoothing_sigma_field.setSingleStep(0.1)
        self.smoothing_sigma_field.setSuffix(" Sigma")
        self.smoothing_sigma_field.setEnabled(False)
        smoothing_layout.addWidget(self.smoothing_chkbx)
        smoothing_layout.addWidget(self.smoothing_sigma_field)

        self.min_max_threshold_widget = QWidget()
        min_max_threshold_layout = QHBoxLayout(self.min_max_threshold_widget)
        min_max_threshold_label = QLabel("Intensity Cutoffs")
        self.min_max_threshold_dbsldr = QLabeledDoubleRangeSlider(Qt.Orientation.Horizontal)
        self.min_max_threshold_dbsldr.setRange(0, 100)
        self.min_max_threshold_dbsldr.setSingleStep(1)
        self.min_max_threshold_dbsldr.setDecimals(0)
        self.min_max_threshold_dbsldr.setValue((0, 95))
        self.min_max_threshold_dbsldr.setBarMovesAllHandles(False)
        self.min_max_threshold_dbsldr._min_label.setReadOnly(True)
        self.min_max_threshold_dbsldr._max_label.setReadOnly(True)

        min_max_threshold_layout.addWidget(min_max_threshold_label)
        min_max_threshold_layout.addWidget(self.min_max_threshold_dbsldr)

        self.gradient_update_widget = QWidget()
        self.gradient_update_layout = QHBoxLayout(self.gradient_update_widget)
        self.gradient_cbbx = QComboBox()
        self.gradient_cbbx.setEditable(False)
        self.gradient_cbbx.addItems(list(self.colours_dict.keys()))

        # Set Viridis as default gradient, as it seems to be the most pleasing
        if "Viridis" in self.colours_dict.keys():
            viridis_idx = list(self.colours_dict.keys()).index("Viridis")
            self.gradient_cbbx.setCurrentIndex(viridis_idx)

        update_btn = QPushButton("Update")
        update_btn.setIcon(icon("ei.refresh"))
        update_btn.clicked.connect(self.forceUpdate)
        self.gradient_update_layout.addWidget(self.gradient_cbbx)
        self.gradient_update_layout.addWidget(update_btn)

        # Populate the settings widget
        settings_layout.addWidget(load_widget)
        settings_layout.addWidget(tolerance_widget)
        settings_layout.addWidget(clustering_widget)
        settings_layout.addWidget(smoothing_widget)
        settings_layout.addWidget(self.min_max_threshold_widget)
        settings_layout.addWidget(self.gradient_update_widget)

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
        roc_analysis_btn.setIcon(icon("ei.cog"))
        roc_analysis_btn.clicked.connect(lambda:self.render_msi_wrapper(origin="ROC_Analysis"))
        self.roc_main_cluster_spnbx = QDoubleSpinBox(prefix= "Main Cluster: ", decimals=0, minimum=0,
                                                     maximum=self.cluster_nb_spnbx.value()-1, singleStep=1)
        roc_export_btn = QPushButton()
        roc_export_btn.setIcon(icon("ei.download-alt"))
        roc_export_btn.setFixedWidth(32)
        roc_export_btn.clicked.connect(self.export_roc)
        self.custom_roi_btn = QPushButton()
        self.custom_roi_btn.setIcon(icon("ei.edit"))
        self.custom_roi_btn.setFixedWidth(32)
        self.custom_roi_btn.clicked.connect(self.create_roi)

        #TODO; Check back on this
        self.scroll_view = QScrollArea()
        self.scroll_view.setWidgetResizable(True)
        self.scroll_view.setVerticalScrollBarPolicy(Qt.ScrollBarPolicy.ScrollBarAsNeeded)
        self.scroll_view.setHorizontalScrollBarPolicy(Qt.ScrollBarPolicy.ScrollBarAlwaysOff)
        self.scroll_container = QWidget()
        self.spectrum_view_widget = QGroupBox("Toggle Spectra")
        self.spectrum_view_widget.setFlat(True)
        self.scroll_view.setWidget(self.scroll_container)
        self.spectrum_view_layout = QGridLayout(self.scroll_container)

        self.roi_widget = QButtonGroup(exclusive=True)
        self.roi_widget.buttonClicked.connect(self.on_button_clicked)
        self.roi_widget.buttonPressed.connect(self.on_button_pressed)

        analysis_btns_layout.addWidget(roc_analysis_btn)
        analysis_btns_layout.addWidget(self.roc_main_cluster_spnbx)
        analysis_btns_layout.addWidget(roc_export_btn)
        analysis_btns_layout.addWidget(self.custom_roi_btn)

        analysis_layout.addWidget(analysis_btns_widget)
        analysis_layout.addWidget(self.scroll_view)

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
        self.file_tree.header().setSectionsMovable(False)
        self.file_tree.setColumnWidth(0, 180)
        self.file_tree.setColumnWidth(1, 20)
        self.file_tree.setHorizontalScrollBarPolicy(Qt.ScrollBarPolicy.ScrollBarAlwaysOff)
        self.file_tree.currentItemChanged.connect(self.project_changed)

        cross_project_roc_widget = QWidget()
        cross_project_roc_layout = QHBoxLayout(cross_project_roc_widget)

        cross_project_roc_btn = QPushButton("Cross-Project Analysis")
        cross_project_roc_btn.setIcon(icon("ei.cogs"))
        cross_project_roc_btn.clicked.connect(self.cross_project_roc_wrapper)

        self.cross_project_roc_noise_btn = QPushButton()
        self.cross_project_roc_noise_btn.setIcon(QIcon(QPixmap("resources\\noise_level_detection_off.svg")))
        self.cross_project_roc_noise_btn.setFixedWidth(32)
        self.cross_project_roc_noise_btn.clicked.connect(self.toggle_global_thresholding)
        cross_project_roc_layout.addWidget(self.cross_project_roc_noise_btn)
        cross_project_roc_layout.addWidget(cross_project_roc_btn)

        file_tree_layout.addWidget(self.file_tree)
        file_tree_layout.addWidget(cross_project_roc_widget)

        # Create and populate a widget to handle settings and MSI data
        settings_msi_widget = QSplitter(Qt.Horizontal)
        settings_msi_layout = QHBoxLayout(settings_msi_widget)
        settings_msi_layout.addWidget(stgs_anls_widget)
        settings_msi_layout.addWidget(self.topo_frag_view)
        settings_msi_layout.addWidget(file_tree_widget)
        settings_msi_widget.setSizes([145, 800, 200])
        settings_msi_widget.handle(2).setEnabled(False)

        # Create the final layout
        main_layout.addWidget(settings_msi_widget)
        main_layout.addWidget(self.spectrum_widget)
        central_widget.setSizes([400,200])

        # Connect Click event
        self.spectrum_widget.scene().sigMouseClicked.connect(self.on_mouse_clicked)

    def toggle_smoothing(self):
        if self.smoothing:
            self.smoothing = False
            self.smoothing_sigma_field.setEnabled(False)
            self.smoothing_chkbx.setIcon(QIcon(QPixmap("resources\\smoothing-off.svg")))

        else:
            self.smoothing = True
            self.smoothing_sigma_field.setEnabled(True)
            self.smoothing_chkbx.setIcon(QIcon(QPixmap("resources\\smoothing-on.svg")))

    def toggle_clustering(self):
        if self.clustering:
            self.clustering = False
            self.cluster_nb_spnbx.setEnabled(False)
            self.clustering_chkbx.setIcon(QIcon(QPixmap("resources\\clustering-off.svg")))
            self.thresholding_btn.setEnabled(False)

        else:
            self.clustering = True
            self.cluster_nb_spnbx.setEnabled(True)
            self.clustering_chkbx.setIcon(QIcon(QPixmap("resources\\clustering-on.svg")))
            self.thresholding_btn.setEnabled(True)

    def toggle_thresholding(self):
        if self.thresholding:
            self.thresholding = False
            self.thresholding_btn.setIcon(QIcon(QPixmap("resources\\noise_level_detection_off.svg")))
        else:
            self.thresholding = True
            self.thresholding_btn.setIcon(QIcon(QPixmap("resources\\noise_level_detection_on.svg")))

    def toggle_global_thresholding(self):
        if self.global_thresholding:
            self.global_thresholding = False
            self.cross_project_roc_noise_btn.setIcon(QIcon(QPixmap("resources\\noise_level_detection_off.svg")))
        else:
            self.global_thresholding = True
            self.cross_project_roc_noise_btn.setIcon(QIcon(QPixmap("resources\\noise_level_detection_on.svg")))

    def upload_action(self, *args):
        if args:
            # Hijacks this function for ROI definition, no longer used
            roi_name = args[0]
            temp_filename = self.projects[idx]["current_filename"].split(".")
            filename = f"{temp_filename[0]}-{roi_name}.{temp_filename[1]}"
        else:
            initial_dir = os.path.dirname(os.path.abspath(__file__))
            filename = QFileDialog.getOpenFileName(self, "CSV File Selection", initial_dir,
                                                   "STORM-MSI File (*.csv *.parquet)")[0]
            if not filename:
                print("error")
                return
            filename = filename.replace("/", "\\")

        if len(self.projects.keys()) == 0:
            idx = 0
        else:
            # Finds the first unused index and uses it
            idx = max(self.projects.keys())+1
            for i in range(max(self.projects.keys())+1):
                if self.projects.get(i) is None:
                    idx = i
                    break

        self.create_project(idx)

        self.projects[idx]["current_filename"] = filename
        self.projects[idx]["full_csv"], _ = parse_imaging_file(filename)
        data_list = self.projects[idx]["full_csv"].index
        data_list = data_list.to_list()
        binning_win = round((float(data_list[12]) - float(data_list[11])), 5)  # Recovers the CSV binning

        # Populate the file tree
        filename_tree = os.path.split(filename)[1]
        tree_entry = QTreeWidgetItem({filename_tree: []})
        tree_entry.setToolTip(0, filename_tree)
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

        # Set TIC as default value, as it is more expressive than XYZ
        if "TIC" in data_list:
            self.data_cbbx.currentIndexChanged.disconnect()
            self.data_cbbx.addItems(data_list)
            self.data_cbbx.currentIndexChanged.connect(self.on_dtype_selection)
            tic_idx = data_list.index("TIC")
            self.data_cbbx.setCurrentIndex(tic_idx)
        else:
            self.data_cbbx.addItems(data_list)

    def create_project(self, idx):
        self.projects[idx] = {
            "data_list":None,
            "clusters":None,
            "current_filename":None,
            "full_csv":None,
            "mass_range":None,
            "plots":{},
            "roi_names":[],
            "svg":None,
            "thresholds":None,
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
        full_spectrum = self.projects[self.current_project]["full_csv"].drop(data_list, axis=0)
        xvals = full_spectrum.index.values.to_numpy().astype(float)
        yvals = full_spectrum.mean(axis=1).astype(float)
        full_vals = np.array([xvals, yvals])
        self.plot_spectrum("Global_Avg", full_vals[0], full_vals[1], pg.mkPen(color="b", width=1), True)

        self.spectrum_widget.setLimits(xMin=xvals.min(), xMax=xvals.max(), yMin=0, yMax=1.05)
        self.spectrum_widget.setRange(xRange=(xvals.min(), xvals.max()), yRange =(0, yvals.max()), padding=0.1)

        self.projects[self.current_project]["mass_range"] = [xvals.min(),xvals.max()]

    def on_dtype_selection(self):
        if self.data_cbbx.currentText() == "" or self.file_tree.topLevelItemCount() == 0:
            return
        if self.data_cbbx.currentText() != "m/Z":
            self.tolerance_spnbx.setEnabled(False)
        else:
            self.tolerance_spnbx.setEnabled(True)
        self.get_settings()
        self.render_msi_wrapper("Data_Type_Selection")

    def on_mouse_clicked(self, event):
        if event._button == Qt.LeftButton:
            if self.spectrum_widget.sceneBoundingRect().contains(event.scenePos()):
                mouse_point = self.spectrum_widget.plotItem.vb.mapSceneToView(event.scenePos())
                x = mouse_point.x()
                y = mouse_point.y()
                self.central_mz = x

                self.get_settings()
                self.spectrum_widget.removeItem(self.central_mz_region)
                self.central_mz_region  = pg.LinearRegionItem(values=(x-self.tolerance, x+self.tolerance), orientation="vertical", brush=pg.mkBrush(color=(255, 0, 0, 100)))
                # Note: The region needs to be made persistent to be removable without clearing the full widget
                self.spectrum_widget.addItem(self.central_mz_region)

                self.render_msi_wrapper("m/Z_Selection")

    def get_settings(self):
        self.gradient_name = self.gradient_cbbx.currentText()
        self.itp_factor = self.interp_slider.value()
        self.itp_type = self.interp_dict.get(self.interp_cbbx.currentText())
        self.cluster_nb = int(self.cluster_nb_spnbx.value())
        self.main_cluster = int(self.roc_main_cluster_spnbx.value())
        self.selected_dtype = self.data_cbbx.currentText()
        self.smoothing_sigma = self.smoothing_sigma_field.value()
        self.tolerance = self.tolerance_spnbx.value()
        self.cutoff_percentiles = [int(i) for i in self.min_max_threshold_dbsldr.value()]

    def render_msi_wrapper(self, origin):
        self.progressDialog = QProgressDialog(autoClose=True, 
                                              labelText="Starting Reconstruction", 
                                              minimumDuration=5)
        self.progressDialog.setWindowIcon(QIcon(QPixmap("resources\\STORM-MSI_Visualizer-roc.svg")))
        self.progressDialog.setWindowTitle("Reconstruction In Progress...")
        self.workers["msi"] = Worker(self.process_msi, origin)
        self.workers["msi"].updateProgress.connect(lambda signal:[self.progressDialog.setLabelText(signal),
                                                     self.progressDialog.setValue(self.progressDialog.value()+1)])
        self.workers["msi"].updateProgressMax.connect(lambda signal:self.progressDialog.setMaximum(signal))
        self.workers["msi"].finished.connect(self.render_msi)
        self.workers["msi"].start()

    def process_msi(self, origin, **kwargs):
        if kwargs.get("origin") is not None:
            origin = kwargs.get("origin")

        if not self.central_mz and self.selected_dtype == "m/Z":
            # Duplicate with the forceUpdate function, but fails silently instead
            return

        # Recover certain variables prior to function call
        clustering_flag = self.clustering
        csv = self.projects[self.current_project]["full_csv"]
        cutoff_percentiles = self.cutoff_percentiles
        gradient = self.colours_dict.get(self.gradient_name)
        roc_flag = False
        roi_mask = None
        thresholds = self.projects[self.current_project]["thresholds"]

        if self.selected_dtype != "m/Z":
            tolerance = None
            central_mz = None
        else:
            tolerance = self.tolerance
            central_mz = self.central_mz

        if self.selected_dtype in self.projects[self.current_project]["roi_names"]:
            # Perform segmentation and/or ROC on the cluster region alone
            roi = self.selected_dtype
            clustering_flag = True
            roi_mask = self.projects[self.current_project]["plots"][roi]["mask"]

        if origin == "ROC_Analysis":
            # Overrides settings to ensure proper behaviour
            clustering_flag = True
            roc_flag = True

        self.projects[self.current_project]["svg"], viewbox, roc_aucs, clustering_lbls, cluster_colours, scale, thresholds = (
            cvu.process_csv(self.workers["msi"], self.projects[self.current_project]["current_filename"], csv,
                            self.selected_dtype, central_mz, tolerance, self.itp_factor, self.itp_type,
                            gradient, cutoff_percentiles, self.smoothing, self.smoothing_sigma, clustering_flag,
                            self.cluster_nb, self.main_cluster, roc_flag, roi_mask, self.thresholding, thresholds))

        if thresholds is not None:
            self.projects[self.current_project]["thresholds"] = thresholds

        return viewbox, roc_aucs, clustering_lbls, clustering_flag, cluster_colours, roc_flag, roi_mask, scale, origin

    def render_msi(self, result):
        if result is None:
            return
        else:
            viewbox, roc_aucs, clustering_lbls, clustering_flag, cluster_colours, roc_flag, roi_mask, scale, origin = result

        # Update maximum progress
        update_total = self.progressDialog.maximum()
        # Updating Scale, SVG and Viewbox - 3
        update_total += 3
        if roc_flag:
            # Render ROC analysis
            update_total += 1
        if clustering_flag:
            # Render each cluster
            update_total += len(np.unique(clustering_lbls))
        self.progressDialog.setMaximum(update_total)

        # Renders the new colour scale
        self.workers["msi"].updateProgress.emit("Rendering Colour Scale")
        self.update_scale(scale)
        self.workers["msi"].updateProgress.emit("Updating Image")
        self.update_svg(self.projects[self.current_project]["svg"].encode("utf-8"), viewbox)
        self.workers["msi"].updateProgress.emit("Updating Viewbox")
        self.projects[self.current_project]["viewbox"] = viewbox

        if origin == "ROC_Analysis":
            self.projects[self.current_project]["clusters"] = clustering_lbls
            self.plot_clustering(roc_aucs, clustering_lbls, cluster_colours, roc_flag)
        elif clustering_flag:
            if roi_mask is not None:
                roi = self.selected_dtype
                self.projects[self.current_project]["plots"][roi]["clusters"] = clustering_lbls
            else:
                self.projects[self.current_project]["clusters"] = clustering_lbls
            # Display average spectra found from clustering
            self.plot_clustering(roc_aucs, clustering_lbls, cluster_colours, roc_flag)
        else:
            self.progressDialog.destroy()
        self.workers["msi"].deleteLater()

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
            self.render_msi_wrapper("Forced_Update")

    def plot_clustering(self, roc_aucs, clustering_lbls, cluster_colours, roc_flag):
        indices = list(self.projects[self.current_project]["plots"]["Global_Avg"].get("plot").xData)

        # Lone exception that will not be normalized, as the maximum value is already 1
        self.clear_spectra("Current", "ROC", True)

        if roc_flag:
            self.workers["msi"].updateProgress.emit("Plotting ROC Analysis")
            if self.selected_dtype in self.projects[self.current_project]["roi_names"]:
                prefix = f"{self.selected_dtype}-"
            else:
                prefix = ""
            self.plot_spectrum(f"{prefix}ROC_Analysis", indices, roc_aucs, pg.mkPen(color="lightgrey", width=1), False)

        global_data = self.projects[self.current_project]["full_csv"].copy()
        global_data.drop(self.projects[self.current_project]["data_list"], axis=0, inplace=True)
        if self.selected_dtype in self.projects[self.current_project]["roi_names"]:
            roi = self.selected_dtype
            mask = self.projects[self.current_project]["plots"][roi]["mask"]
            global_data = global_data.loc[:,mask]

        global_data.columns = clustering_lbls

        if self.selected_dtype in self.projects[self.current_project]["roi_names"]:
            # Perform segmentation and/or ROC on the cluster region alone
            plot_name_prefix = f"{self.selected_dtype}-Cluster"
        else:
            plot_name_prefix = "Cluster"

        # Plot the average spectrum of each cluster
        for idx, label in enumerate(np.unique(clustering_lbls)):
            cluster_name = f"{plot_name_prefix}_{label}"
            self.workers["msi"].updateProgress.emit(f"Plotting {cluster_name}")
            parsed_data = global_data[label]
            if type(parsed_data) == pd.Series:
                # In cases where clusters are made of a single pixel
                avg_spectrum = pd.DataFrame([parsed_data.index, parsed_data]).T.astype(np.float32)
            else:
                avg_spectrum = parsed_data.mean(axis=1).reset_index().set_axis([0, 1], axis=1).astype(np.float32)
            self.plot_spectrum(f"{plot_name_prefix}_{label}", avg_spectrum[0], avg_spectrum[1], pg.mkPen(cluster_colours[idx], width=1))
            # Add children to the file tree for later cluster analysis
            child = QTreeWidgetItem({f"{plot_name_prefix}_{label}":[]})
            child.setFlags(child.flags() | Qt.ItemIsUserCheckable)
            child.setCheckState(1, Qt.Checked)
            self.projects[self.current_project]["tree_entry"].addChild(child)

        self.projects[self.current_project]["tree_entry"].setExpanded(True)

        self.progressDialog.destroy()

    def plot_spectrum(self, name:str, spectrum_x, spectrum_y, pen:pg.mkPen, normalize=True, *args):
        # Helper function that can normalize spectra before rendering them, helpful for ROC visualization
        if normalize:
            spectrum_y = spectrum_y/spectrum_y.max()
        plot = pg.PlotDataItem(spectrum_x, spectrum_y, pen=pen)
        plot.setZValue(len(self.projects[self.current_project]["plots"]) + 1)
        self.spectrum_widget.addItem(plot)

        # Support for toggling ROI display
        if len(args)!=0:
            roi = args[0]
            self.create_checkbox(name, plot, roi)
        else:
            self.create_checkbox(name, plot)

    def create_checkbox(self, name, plot, *args):
        # Create a checkbox for the spectrum
        checkbox = QCheckBox(name)
        if len(args) != 0:
            checkbox.toggled.connect(lambda state: [plot.setVisible(state), self.sort_plots(name, checkbox),
                                                   args[0].setVisible(state)])
        else:
            checkbox.toggled.connect(lambda state: [plot.setVisible(state), self.sort_plots(name, checkbox)])
        checkbox.setChecked(True)

        self.projects[self.current_project]["plots"][name] = {"checkbox":checkbox, "plot":plot}

        count = self.spectrum_view_layout.count()
        row = count // 2
        col = count % 2

        # Add to either the exclusive ROI widget or the global widget
        if len(args) != 0:
            self.roi_widget.addButton(checkbox)
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

        if self.selected_dtype in self.projects[self.current_project]["roi_names"]:
            for roi in self.projects[self.current_project]["roi_names"]:
                # Protect ROIs
                whitelist["ROC"].append(roi)
                whitelist["Clusters"].append(roi)

        target_ids = []
        for name in self.projects[idx]["plots"].keys():
            if name not in whitelist[extent]:
                checkbox = self.projects[idx]["plots"][name]["checkbox"]
                plot = self.projects[idx]["plots"][name]["plot"]

                # removeWidget apparently is not the command needed to properly delete: https://stackoverflow.com/questions/9899409/pyside-removing-a-widget-from-a-layout
                # Remove widget/item do not destroy the item, they just break the parent/child link
                self.projects[idx]["plots"][name]["checkbox"].setVisible(False)
                #self.spectrum_view_layout.removeWidget(self.projects[idx]["plots"][name]["checkbox"])
                self.spectrum_widget.removeItem(self.projects[idx]["plots"][name]["plot"])

                if name in self.projects[idx]["roi_names"]:
                    # Remove the ROI polygon
                    self.projects[idx]["plots"][name]["polygon"].setVisible(False)

                target_ids.append(name)

        # When Dict culling happens, completely remove items from memory
        if dict_culling:
            for name in target_ids:
                polygon = self.projects[idx]["plots"][name].get("polygon")
                if polygon is not None:
                    self.topo_frag_view.scene().removeItem(polygon)

                tree_entry = self.projects[self.current_project]["tree_entry"]
                for child_idx in range(tree_entry.childCount()):
                    if name == tree_entry.child(child_idx).text(0):
                        tree_entry.takeChild(child_idx)
                        break

                checkbox = self.projects[idx]["plots"][name]["checkbox"]

                self.projects[idx]["plots"].pop(name) # Drops the entry from the dictionary
                checkbox_idx = self.spectrum_view_layout.indexOf(checkbox)
                delete_order = self.spectrum_view_layout.takeAt(checkbox_idx)
                delete_order.widget().deleteLater()

    def export_roc(self):
        #TODO: Overhaul based on the later export function
        if not self.projects[self.current_project]["plots"]:
            return
        if not self.projects[self.current_project]["plots"]["ROC_Analysis"]:
            QMessageBox.warning(self, "Error", "Please perform a ROC analysis first, and try again." )
            return
        else:
            roc_aucs_df = pd.DataFrame([self.projects[self.current_project]["plots"]["ROC_Analysis"].get("plot").xData,
                                self.projects[self.current_project]["plots"]["ROC_Analysis"].get("plot").yData],
                               index=["m/Z", "ROC Score"]).T
            filename = self.projects[self.current_project]["current_filename"]
            export_name = f"{os.path.split(filename)[0]}\\ROC\\{os.path.split(filename)[1].split(".")[0]}-ROC.csv"

            # Create folder if non-existent
            if not os.path.isdir(os.path.split(export_name)[0]):
                os.mkdir(os.path.split(export_name)[0])

            # Renames the file if existent
            if os.path.isfile(export_name):
                idx = 1
                export_name_raw = export_name.split(".")[0]
                export_name = f"{export_name_raw}({idx}).csv"
                while os.path.isfile(export_name):
                    idx += 1
                    export_name = f"{export_name_raw}({idx}).csv"
            roc_aucs_df.to_csv(export_name, index=None, header=None, columns=None, sep=",")
            QMessageBox.information(self, "Sucess", f"ROC exported in {os.path.split(export_name)[0]}.")

        # Not going to implement this yet
        #main_cluster_keys = [key for key, value in clusters.items() if value == 1]
        #alternative_cluster_keys = [key for key, value in clusters.items() if value == 0]

        with open(export_name, "a", newline="") as roc_export:
            roc_export.write(f"#Cross-Project ROC Analysis from STORM-MSI's visualizer,\n"
                             f"#Cluster 1 is the chosen reference, corresponding to high on the ROC analysis,\n"
                             f"#Cluster 1 ROI: {self.main_cluster},\n"
                             f"#Cluster 2 is the alternative, containing every other cluster created prior to analysis,\n"
                             f"#Change the main cluster in the global ROC panel for other references,\n")
                             #f"#Cluster 2 ROIs: {',\n#'.join(alternative_cluster_keys)},\n")

            roc_aucs_df.to_csv(roc_export, index=None, header=None, columns=["m/Z", "ROC Score"], sep=",")
        QMessageBox.information(self, "Sucess", f"ROC exported in {os.path.split(export_name)[0]}.")

    def project_changed(self, item, previous):
        new_project_flag = False
        if item is None:
            return

        if item.parent() is not None or item == previous:
            # Filter only parent items
            return

        if self.current_project == self.file_tree.indexOfTopLevelItem(item):
            self.clear_spectra("Former", "Total", False)
            new_project_flag = True

        # Populating the new project
        self.former_project = copy(self.current_project)
        self.current_project = self.file_tree.indexOfTopLevelItem(item)

        if self.projects[self.current_project]["mass_range"] is None:
            new_project_flag = True

        if not new_project_flag:
            self.data_cbbx.clear()
            self.clear_spectra("Former", "Total", False)

        if self.former_project == -1 or new_project_flag:
            # Spots the initial project and new projects thereafter
            return
        else:
            # Restore the data type list
            local_list = copy(self.projects[self.current_project]["data_list"])
            local_list.append("m/Z")
            for roi in self.projects[self.current_project]["roi_names"]:
                local_list.append(roi)

            # Set TIC as default value, as it is more expressive than XYZ
            if "TIC" in local_list:
                self.data_cbbx.currentIndexChanged.disconnect()
                self.data_cbbx.addItems(local_list)
                self.data_cbbx.currentIndexChanged.connect(self.on_dtype_selection)
                tic_idx = local_list.index("TIC")
                self.data_cbbx.setCurrentIndex(tic_idx)
            else:
                self.data_cbbx.addItems(local_list)

            self.spectrum_widget.setLimits(xMin=self.projects[self.current_project]["mass_range"][0],
                                           xMax=self.projects[self.current_project]["mass_range"][1])
            self.spectrum_widget.setRange(xRange=(self.projects[self.current_project]["mass_range"][0],
                                                  self.projects[self.current_project]["mass_range"][1]), padding=1)

            # Update checkboxes
            for item in self.projects[self.current_project]["plots"].keys():
                plot = self.projects[self.current_project]["plots"][item]["plot"]
                self.spectrum_widget.addItem(plot)
                self.projects[self.current_project]["plots"][item]["checkbox"].setVisible(True)
            # Update plots
            if self.projects[self.current_project]["svg"] is not None:
                self.update_svg(self.projects[self.current_project]["svg"], self.projects[self.current_project]["viewbox"])

    def cross_project_roc_wrapper(self):
        # Security check in case nothing is in the tree
        if self.file_tree.topLevelItemCount() == 0:
            QMessageBox.warning(self, "Error", "Open one or more projects first, create ROIs through\n"
                                               "ROC analysis or custom region selection (TBD), and try again.")
            return
        self.progressDialog = QProgressDialog(autoClose=True,
                                              labelText="Recovering Target Clusters...",
                                              minimumDuration=1)
        self.progressDialog.setWindowIcon(QIcon(QPixmap("resources\\STORM-MSI_Visualizer-roc.svg")))
        self.progressDialog.setWindowTitle("Global ROC Analysis")
        #TODO: Using one progressDialog for both workers is not best practice, might be worth instancing them at some point

        self.workers["roc"] = Worker(self.preprocess_cross_project_roc)
        self.workers["roc"].updateProgress.connect(lambda signal: [self.progressDialog.setLabelText(signal),
                                                                   self.progressDialog.setValue(
                                                                       self.progressDialog.value() + 1)])
        self.workers["roc"].updateProgressMax.connect(lambda signal: self.progressDialog.setMaximum(signal))

        self.workers["roc"].runFunc.connect(lambda myfunc, args, kwargs: myfunc(*args, **kwargs))
        self.workers["roc"].start()

    def preprocess_cross_project_roc(self):
        # Find out what elements are in the tree
        # Retrieve all indices currently in use
        indices = self.projects.keys()

        # Loops through each parent, each child, and find the state of each checkbox
        checked_rois = {}
        for idx in indices:
            project = self.file_tree.topLevelItem(idx)
            if project.childCount() != 0:
               local_checked_rois = {}
               for child_idx in range(project.childCount()):
                   child = project.child(child_idx)
                   if child.checkState(1) == Qt.Checked:
                       # Add to list
                       label = child.text(0)
                       roi_name = f"{project.text(0)}/{label}"
                       cluster_idx = None
                       if "Cluster" in label:
                           # Clusters derived from k-means
                           # roi_cluster = self.projects[idx]["clusters"]
                           cluster_idx = int(label.split("_")[-1])
                       local_checked_rois[child_idx] = {"name":roi_name,
                                                        "idx":cluster_idx}
               checked_rois[idx] = local_checked_rois

        self.workers["roc"].updateProgressMax.emit(len(checked_rois)+2) # n for processing, 1 for cluster assignment, 1 for saving
        self.workers["roc"].updateProgress.emit("Assigning Clusters...")
        self.workers["roc"].runFunc.emit(self.launch_roc_panel, (), {"checked_rois":checked_rois})

    def launch_roc_panel(self, *args, **kwargs):
        if kwargs:
            for kwarg in kwargs.keys():
                if kwarg == "checked_rois":
                    checked_rois = kwargs["checked_rois"]
        else:
            print("Missing kwarg: 'checked_rois' in self.launch_roc_panel")

        self.roc_panel = GlobalRocPanel(checked_rois)
        self.roc_panel.export_ready.connect(self.start_cross_project_roc)
        self.roc_panel.show()
        self.roc_panel.setAttribute(Qt.WidgetAttribute.WA_DeleteOnClose)

    def start_cross_project_roc(self):
        # Retrieve clusters and run a simplified ROC export
        clusters = self.roc_panel.cluster_dict
        cluster_data_dict = {}

        for key in clusters.keys():
            project_filename = key.split(".")[0]
            project_roi = key.split("/")[-1]
            project_subregion = None
            full_region = None

            if "Cluster" in project_roi:
                project_roi_idx = int(project_roi.split("_")[-1])
                full_region = False
            else:
                # Custom region, the following logic will be part of the region's definition
                project_roi_idx = 1

            # Find clusters from a sub-region
            if "-" in project_roi:
                project_subregion = project_roi.split("-")[0]
                full_region = False

            if full_region is None:
                # If full_region was not defined beforehand, conditions have been met for it to be true
                full_region = True

            project_idx = None

            for p in self.projects.keys():
                name = self.projects[p]["current_filename"]
                if project_filename in name:
                    project_idx = p

            if project_idx is None:
                QMessageBox.warning(self, "Error", f"No matches found between any project filename and the cluster's filename.\n"
                                                   f"Reported Name: {key}")
                return
            else:
                if full_region:
                    data_indices = self.projects[project_idx]["plots"][project_roi]["mask"]
                else:
                    if project_subregion:
                        data_clusters = self.projects[project_idx]["plots"][project_subregion]["clusters"]
                    else:
                        data_clusters = self.projects[project_idx]["clusters"]
                    # Find indices of values of interest in the CSV
                    data_indices = np.where(data_clusters == project_roi_idx)[0]
                sorted_data = self.projects[project_idx]["full_csv"].iloc[:, data_indices]
                sorted_data.columns = range(len(sorted_data.columns))

                data_list_regex = '|'.join(self.projects[project_idx]["data_list"])
                sorted_data = sorted_data[~sorted_data.index.str.contains(data_list_regex)]
                cluster_data_dict[len(cluster_data_dict)] = {"data":sorted_data,
                                                            "cluster":clusters[key]}

        roc_aucs, mz = cvu.cross_project_roc(self.workers["roc"], cluster_data_dict, self.global_thresholding)
        roc_aucs_df = pd.DataFrame([mz, roc_aucs], index=["m/Z", "ROC Score"]).T

        # Save the ROC analysis
        self.workers["roc"].updateProgress.emit("Writing ROC CSV")
        filename = self.projects[self.current_project]["current_filename"]
        export_name = f"{os.path.split(filename)[0]}\\ROC\\Global-ROC.csv"

        # Create folder if non-existent
        if not os.path.isdir(os.path.split(export_name)[0]):
            os.mkdir(os.path.split(export_name)[0])

        # Renames the file if existent
        if os.path.isfile(export_name):
            idx = 1
            export_name_raw = export_name.split(".")[0]
            export_name = f"{export_name_raw}({idx}).csv"
            while os.path.isfile(export_name):
                idx+=1
                export_name = f"{export_name_raw}({idx}).csv"

        main_cluster_keys = [key for key, value in clusters.items() if value == 1]
        alternative_cluster_keys = [key for key, value in clusters.items() if value == 0]

        with open(export_name, "a", newline="") as roc_export:
            roc_export.write(f"#Cross-Project ROC Analysis from STORM-MSI's visualizer,\n"
                             f"#Cluster 1 is the chosen reference, corresponding to high on the ROC analysis,\n"
                             f"#Cluster 1 ROIs: {',\n#'.join(main_cluster_keys)},\n"
                             f"#Cluster 2 is the alternative, containing every other cluster created prior to analysis,\n"
                             f"#Change the main cluster in the global ROC panel for other references,\n"
                             f"#Cluster 2 ROIs: {',\n#'.join(alternative_cluster_keys)},\n")

            roc_aucs_df.to_csv(roc_export, index=None, header=None, columns=["m/Z", "ROC Score"], sep=",")
        self.progressDialog.destroy()
        QMessageBox.information(self, "Sucess", f"ROC exported in {os.path.split(export_name)[0]}.")

        # Destroy the popup window
        self.roc_panel.close()
        self.roc_panel = None

        cluster_keys = [main_cluster_keys, alternative_cluster_keys]
        #TODO: Run create_roc_display from the main thread somehow
        self.workers["roc"].runFunc.emit(self.create_roc_display, (), {"cluster_keys":cluster_keys, "roc_aucs_df":roc_aucs_df})

    def create_roc_display(self, **kwargs):
        if kwargs:
            for kwarg in kwargs.keys():
                if kwarg == "cluster_keys":
                    cluster_keys = kwargs["cluster_keys"]
                elif kwarg == "roc_aucs_df":
                    roc_aucs_df = kwargs["roc_aucs_df"]
        else:
            print("Missing kwargs for create_roc_display")
            return

        self.global_roc_display = GlobalRocDisplay(cluster_keys, roc_aucs_df)
        self.global_roc_display.setAttribute(Qt.WidgetAttribute.WA_DeleteOnClose)
        self.global_roc_display.show()

    def create_roi(self):
        if self.current_project is None or self.current_project == -1:
            return

        roi_name, result = QInputDialog.getText(self, "ROI Name", "New ROI Name:")
        if "Cluster" in roi_name:
            QMessageBox.warning(self, "Error", "Writing 'Cluster' in the name can affect downstream processing. Please\n"
                                               "pick another name and try again.")
            return

        roi_colour = QColorDialog.getColor(parent=self, title="ROI Colour Choice")
        self.topo_frag_view.pen = QPen(roi_colour)
        self.topo_frag_view.pen.setWidth(1)

        if result and roi_name.strip() != "" and roi_name not in self.projects[self.current_project]["roi_names"]:
            self.topo_frag_view.draw_mode = True
            self.topo_frag_view.polygon_points.clear()
            self.topo_frag_view.points.clear()
            self.topo_frag_view.roi_drawn.connect(lambda:self.store_roi(roi_name, roi_colour))
        else:
            QMessageBox.warning(self, "Error", "Please specify a colour and a non-taken name for this project,\n"
                                               "and try again.")
            return

    def store_roi(self, roi_name, roi_colour):
        roi_points = self.topo_frag_view.polygon_points
        polygon = self.topo_frag_view.scene_polygon

        # Adapt the CSV locally
        local_csv = self.projects[self.current_project]["full_csv"].copy()
        width = self.projects[self.current_project]["viewbox"][2]
        roi_idx = [x  + y * width for x, y  in roi_points]
        local_csv.columns = range(len(local_csv.columns))
        if max(roi_idx) > len(local_csv.columns):
            #TODO: Investigate why this part sometimes breaks
            breakpoint()
        local_csv = local_csv.iloc[:, roi_idx]

        local_csv = local_csv.drop(self.projects[self.current_project]["data_list"], axis=0)
        xvals = local_csv.index.values.to_numpy().astype("float64")
        yvals = local_csv.mean(axis=1).astype("float64")
        avg_spectrum = pd.DataFrame([xvals, yvals]).T

        self.plot_spectrum(roi_name, avg_spectrum[0], avg_spectrum[1], pg.mkPen(roi_colour, width=1), True, polygon)

        # Add children to the file tree for later cluster analysis
        child = QTreeWidgetItem({roi_name:[]})
        child.setFlags(child.flags() | Qt.ItemIsUserCheckable)
        child.setCheckState(1, Qt.Checked)

        self.projects[self.current_project]["tree_entry"].addChild(child)
        self.projects[self.current_project]["tree_entry"].setExpanded(True)
        self.projects[self.current_project]["plots"][roi_name]["polygon"] = polygon
        self.projects[self.current_project]["plots"][roi_name]["colour"] = roi_colour
        mask_range = range(len(self.projects[self.current_project]["full_csv"].columns))
        self.projects[self.current_project]["plots"][roi_name]["mask"] = [i in roi_idx for i in mask_range]
        self.projects[self.current_project]["plots"][roi_name]["clusters"] = None # Stores clustering information for regions separately from global clustering
        self.projects[self.current_project]["roi_names"].append(roi_name)
        self.data_cbbx.addItem(roi_name)
        self.topo_frag_view.roi_drawn.disconnect()

    def update_scale(self, scale):
        scale_item = QPixmap.fromImage(scale)
        painter = QPainter(self.topo_frag_view.viewport())

        scale_dimensions = [scale_item.width(), scale_item.height()]
        scene_w = self.topo_frag_view.viewport().width()
        scene_h = self.topo_frag_view.viewport().height()

        # Downsize if the scale appears too large
        if scale_dimensions[0] > 0.2 * scene_w:
            factor = (0.3 * scene_w) / scale_dimensions[0]
            w = round(scale_dimensions[0] * factor)
            h = round(scale_dimensions[1] * factor)
        else:
            w, h = scale_dimensions

        rect = QRect(scene_w - w - 10, scene_h - h, w, h)

        self.topo_frag_view.scale_pixmap = scale_item
        self.topo_frag_view.scale_rect = rect
        self.topo_frag_view.viewport().update()

    def on_button_pressed(self, button):
        # If the pressed button is already checked, allow it to be unchecked
        if button.isChecked():
            self.roi_widget.setExclusive(False)

    def on_button_clicked(self, button):
        # Re-enable exclusivity after the click is processed
        self.roi_widget.setExclusive(True)