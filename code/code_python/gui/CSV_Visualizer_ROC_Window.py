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
from PySide6.QtGui import QDrag, QIcon, QPixmap
from PySide6.QtSvgWidgets import QSvgWidget, QGraphicsSvgItem
from PySide6.QtSvg import QSvgRenderer
import pyqtgraph as pg
from qtawesome import icon

class DraggableLabel(QLabel):
    def mouseMoveEvent(self, event):
        if event.buttons() == Qt.LeftButton:
            drag = QDrag(self)

            mime = QMimeData()
            mime.setText(self.text())

            drag.setMimeData(mime)
            drag.exec_(Qt.MoveAction)

class DropBox(QGroupBox):
    def __init__(self, title):
        super().__init__(title)

        self.setAcceptDrops(True)

        self.layout = QVBoxLayout()
        self.setLayout(self.layout)

    def dragEnterEvent(self, event):
        if event.mimeData().hasText():
            event.acceptProposedAction()

    def dropEvent(self, event):
        text = event.mimeData().text()

        label = DraggableLabel(text)
        self.layout.addWidget(label)

        source = event.source()
        source.deleteLater()

        event.acceptProposedAction()

class GlobalRocPanel(QMainWindow):
    export_ready = Signal(str)

    def __init__(self, checked_rois):
        super().__init__()
        self.setWindowTitle("STORM-MSI Visualizer - Global ROC Panel")
        self.setWindowIcon(QIcon(QPixmap("resources\\STORM-MSI_Visualizer-roc.svg")))
        self.setWindowState(Qt.WindowState.WindowActive)

        # Create a class variable for clusters
        self.project_clusters = None
        self.checked_rois = checked_rois
        self.cluster_widget_dict = {}
        self.cluster_dict = {}

        # Create a layout
        central_widget = QGroupBox("Cluster Assignment")
        self.setCentralWidget(central_widget)
        main_layout = QVBoxLayout(central_widget)

        # Create a table widget
        self.global_cluster_widget = QWidget()
        self.global_cluster_layout = QHBoxLayout(self.global_cluster_widget)
        self.create_clusters(2)

        # Create control buttons
        control_widget = QWidget()
        control_layout = QHBoxLayout(control_widget)

        self.main_cluster_spbx = QDoubleSpinBox(prefix="Main Cluster: ",
                                           minimum=0,
                                           maximum=100,
                                           singleStep=1,
                                           decimals=0,
                                           value=0)
        add_cluster_btn = QPushButton("Add Cluster")
        add_cluster_btn.setIcon(icon("ei.plus-sign"))
        add_cluster_btn.clicked.connect(lambda:self.create_clusters(1))
        remove_cluster_btn = QPushButton("Remove Cluster")
        remove_cluster_btn.setIcon(icon("ei.minus-sign"))
        remove_cluster_btn.clicked.connect(lambda:self.remove_clusters(1))
        start_roc_btn = QPushButton("Start")
        start_roc_btn.setIcon(icon("ei.cogs"))
        start_roc_btn.clicked.connect(self.retrieve_clusters)

        control_layout.addWidget(self.main_cluster_spbx)
        control_layout.addWidget(add_cluster_btn)
        control_layout.addWidget(remove_cluster_btn)
        control_layout.addWidget(start_roc_btn)

        # Build the final layout
        main_layout.addWidget(self.global_cluster_widget)
        main_layout.addWidget(control_widget)

        self.populate_groups()

    def populate_groups(self):
        roi_list = []
        for idx in self.checked_rois.keys():
            # Searches each parent file
            for child in self.checked_rois[idx].keys():
                child_dict = self.checked_rois[idx][child]
                # Searches each child
                name = child_dict["name"]
                roi_list.append(name)

        for roi in roi_list:
            label = DraggableLabel(roi)

            self.cluster_widget_dict[0]["labels"].append(label)
            initial_layout = self.cluster_widget_dict[0]["layout"]
            initial_layout.addWidget(label)

    def create_clusters(self, nb):
        for i in range(nb):
            idx = len(self.cluster_widget_dict)

            cluster_widget = DropBox(f"Cluster_{len(self.cluster_widget_dict)}")
            cluster_layout = cluster_widget.layout
            cluster_layout.setSpacing(1)
            self.cluster_widget_dict[idx] = {"labels": [],
                                             "layout": cluster_layout,
                                             "widget": cluster_widget}
            self.global_cluster_layout.addWidget(self.cluster_widget_dict[idx]["widget"])

    def remove_clusters(self, nb):
        # Remove the latest n clusters
        for i in range(nb):
            idx = len(self.cluster_widget_dict)-1

            if idx <= 1:
                QMessageBox.warning(self, "Error", "At least two clusters are needed for ROC analysis.")
                return

            layout = self.cluster_widget_dict[idx]["layout"]

            if not layout.isEmpty():
                labels = []
                for child_idx in range(layout.count()):
                    # Move whatever labels are in the target group to the previous one
                    child = layout.itemAt(child_idx)
                    export_layout = self.cluster_widget_dict[idx-1]["layout"]
                    export_layout.addWidget(child.wid)

            delete_idx = self.global_cluster_layout.indexOf(self.cluster_widget_dict[idx]["widget"])
            delete_order = self.global_cluster_layout.takeAt(delete_idx)
            delete_order.widget().deleteLater()

            self.cluster_widget_dict.pop(idx)

    def retrieve_clusters(self):
        # Collapses the cluster list in a binary In/Out of main cluster list
        main_cluster = int(self.main_cluster_spbx.value())

        cluster_nb = len(self.cluster_widget_dict)

        cluster_dict = {}
        for idx in range(cluster_nb):
            layout = self.cluster_widget_dict[idx]["layout"]
            if layout.isEmpty():
                if idx == main_cluster:
                    QMessageBox.warning(self, "Error", "The main cluster must contain at least one region of interest.")
                else:
                    continue
            else:
                for child_idx in range(layout.count()):
                    child_widget = layout.itemAt(child_idx)
                    roi_name = child_widget.wid.text()
                    if idx == main_cluster:
                        roi_cluster = 1
                    else:
                        roi_cluster = 0
                    cluster_dict[roi_name] = roi_cluster

        self.cluster_dict = cluster_dict
        self.export_ready.emit(self.cluster_dict)
        self.showMinimized()
        return cluster_dict

if __name__ == "__main__":
    # Minimal test script
    checked_rois = {
        0:{
            0:{
                "name":"260327_GA_RB_4AC_TAGM_50_POS_05_06_Cluster_0",
                "idx":0
            },
            1:{
                "name":"260327_GA_RB_4AC_TAGM_50_POS_05_06_Cluster_1",
                "idx":1
            }
        },
        1:{
            0:{
                "name":"260227_GA_RB_FF_INF_CONT_250_NEG_07_02-TIC-norm_Cluster_0",
                "idx":0
            },
            1:{
                "name": "260227_GA_RB_FF_INF_CONT_250_NEG_07_02-TIC-norm_Cluster_1",
                "idx": 1
            }
        }
    }

    app = QApplication(sys.argv)
    gui = GlobalRocPanel(checked_rois)
    gui.show()
    sys.exit(app.exec())