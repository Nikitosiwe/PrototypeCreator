from PyQt5.QtCore import QUrl, QObject, pyqtSignal, pyqtSlot

class ContextPreview(QObject):
    def __init__(self):
        QObject.__init__(self)


    someSignal = pyqtSignal(str,arguments=['color'])


    @pyqtSlot(str)
    def printConsoleMessage(self, text):
        print("PreviewWindow", text)
        self.someSignal.emit("blue")