import sys
# Класс QUrl предоставляет удобный интерфейс для работы с Urls
from PyQt5.QtCore import QUrl, QObject, pyqtSignal, pyqtSlot
from PyQt5.QtWidgets import QApplication
# Класс QQuickView предоставляет возможность отображать QML файлы.
from PyQt5.QtQuick import QQuickView


class Context(QObject):
    def __init__(self):
        QObject.__init__(self)

    @pyqtSlot(str)
    def printConsoleMessage(self, text):
        print(text)



if __name__ == '__main__':
    app = QApplication(sys.argv)
    # Объект QQuickView, в который грузится UI для отображения
    view = QQuickView()
    view.setSource(QUrl('QML/MainWindow.qml'))

    mainContext = Context()
    view.rootContext().setContextProperty("mainContext", mainContext)

    #view.show()
    app.exec_()
    sys.exit()