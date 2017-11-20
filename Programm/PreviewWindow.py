import sys

from PyQt5.QtCore import QUrl, QObject, pyqtSignal, pyqtSlot

from PyQt5.QtQuick import QQuickView

import ContextPreview as CP

class PreviewWindow(QQuickView):
    def __init__(self, parent=None):
        QQuickView.__init__(self, parent)

        self.parent = parent
        self.setSource(QUrl('QML/PreviewWindow.qml'))
        self.previewContext = CP.ContextPreview(self)
        self.rootContext().setContextProperty("previewContext", self.previewContext)





