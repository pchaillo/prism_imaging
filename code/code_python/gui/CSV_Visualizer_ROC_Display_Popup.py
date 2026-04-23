import sys

from coloraide import Color
from copy import copy
import numpy as np
import pandas as pd
from PIL import Image
import scipy
from PySide6.QtWidgets import (QApplication, QAbstractItemView, QCheckBox, QComboBox, QDoubleSpinBox, QFileDialog, QGraphicsScene,
                               QGraphicsView, QGroupBox, QGridLayout, QHBoxLayout, QLabel, QLayout, QMainWindow, QMessageBox, QPushButton,
                               QRadioButton, QSizePolicy, QSlider, QSplitter, QTableWidget, QTableWidgetItem, QTreeWidget, QTreeWidgetItem, QVBoxLayout, QWidget)
from PySide6.QtCore import Qt, QByteArray, QMimeData, Signal
from PySide6.QtGui import QDrag
from PySide6.QtSvgWidgets import QSvgWidget, QGraphicsSvgItem
from PySide6.QtSvg import QSvgRenderer
import pyqtgraph as pg
from qtawesome import icon

class GlobalRocDisplay(QMainWindow):
    def __init__(self, cluster_keys, roc_auc):
        super().__init__()
        self.setWindowTitle("STORM-MSI Visualizer - Global ROC Display")
        self.setWindowState(Qt.WindowState.WindowActive)

        # Create a class variable for clusters
        self.cluster_keys = cluster_keys
        self.roc_auc = roc_auc

        # Create a layout
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        main_layout = QVBoxLayout(central_widget)

        # Create Group Boxes for each cluster
        global_cluster_widget = QWidget()
        global_cluster_layout = QHBoxLayout(global_cluster_widget)

        cluster_1_widget = QGroupBox("Cluster 1 (Reference)")
        self.cluster_1_layout = QVBoxLayout(cluster_1_widget)

        cluster_2_widget = QGroupBox("Cluster 2 (Alternative)")
        self.cluster_2_layout = QVBoxLayout(cluster_2_widget)

        global_cluster_layout.addWidget(cluster_1_widget)
        global_cluster_layout.addWidget(cluster_2_widget)

        # Initialize the spectrum visualizer
        pg.setConfigOption('background', 'w')  # White background
        pg.setConfigOption('foreground', 'k')  # Black axes/grid

        self.roc_spectrum_widget = pg.PlotWidget()
        self.roc_spectrum_widget.setLabel('bottom', 'm/Z')
        self.roc_spectrum_widget.setLabel('left', 'Intensity (A.U.)')
        self.roc_spectrum_widget.setLimits(xMin=0, yMin=0, yMax=1)

        # Build the final layout
        main_layout.addWidget(self.roc_spectrum_widget)
        main_layout.addWidget(global_cluster_widget)

        self.populate_window()

    def populate_window(self):
        # Populate the reference layout
        for cluster in self.cluster_keys[0]:
            label = QLabel(cluster)
            self.cluster_1_layout.addWidget(label)

        for cluster in self.cluster_keys[1]:
            label = QLabel(cluster)
            self.cluster_2_layout.addWidget(label)

        mz = self.roc_auc["m/Z"].astype(float)
        plot = pg.PlotDataItem(mz, self.roc_auc["ROC Score"].astype(float), pen=pg.mkPen(color="b", width=1))

        self.roc_spectrum_widget.addItem(plot)
        self.roc_spectrum_widget.setRange(xRange(mz.min(), mz.max()), yRange=(0, 1), padding=0.1)
