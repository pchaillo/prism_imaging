from PySide6.QtCore import QObject, QThread, Signal
from qtawesome import Spin, icon
from PySide6.QtWidgets import QApplication
from PySide6.QtGui import QIcon

def loading_start(self, widget):
    self.animation = Spin(widget, autostart=True)
    old_icon = widget.icon()
    self.spin_icon = icon("mdi.loading", color="blue", animation=self.animation)
    widget.setIcon(self.spin_icon)

    # Force Qt to process events so the first frame is shown
    QApplication.processEvents()
    return old_icon

def loading_finished(self, widget, *args):
    if len(args) == 0:
        old_icon = QIcon()
    else:
        old_icon = args[0]
    self.animation.stop()
    widget.setIcon(old_icon)

class Worker(QThread):
    finished = Signal(object)  # emit a result when done
    updateProgress = Signal(str)
    updateProgressMax = Signal(int)
    runFunc = Signal(object, tuple, dict) # function, args, kwargs, Forces the main thread to run a function (i.e. instancing a class in this case)

    def __init__(self, func, *args, **kwargs):
        super().__init__()
        self.func = func
        self.args = args
        self.kwargs = kwargs

    def run(self):
        try:
            result = self.func(*self.args, **self.kwargs)
            self.finished.emit(result)
        except Exception as e:
            # Emit the exception if needed
            print(e)
            self.finished.emit(e)