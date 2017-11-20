import sys
# Класс QUrl предоставляет удобный интерфейс для работы с Urls
from PyQt5.QtCore import QUrl, QObject, pyqtSignal, pyqtSlot
from PyQt5.QtWidgets import QApplication
# Класс QQuickView предоставляет возможность отображать QML файлы.
from PyQt5.QtQuick import QQuickView

import ContextPreview as CP
import MainContext as MC


class MainWindow(QQuickView):
    def __init__(self, parent=None):
        QQuickView.__init__(self, parent)

        self.setSource(QUrl('QML/MainWindow.qml'))
        self.mainContext = MC.Context(self)
        self.rootContext().setContextProperty("mainContext", self.mainContext)


if __name__ == '__main__':
    app = QApplication(sys.argv)

    mainWindow = MainWindow()

    sys.exit(app.exec_())