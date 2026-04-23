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
import sys

sys.path.insert(0, os.getcwd() + "\\code\\code_python") # Needed so that MatLab can actually find the dependency
sys.path.append("utils\\")
sys.path.append("gui\\")

from PySide6.QtWidgets import QApplication
from CSV_Visualizer_Main_Window import MSI_Visualizer


if __name__ == "__main__":
    app = QApplication(sys.argv)
    gui = MSI_Visualizer()
    gui.show()

    sys.exit(app.exec())