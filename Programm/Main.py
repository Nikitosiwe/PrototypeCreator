import sys
# Класс QUrl предоставляет удобный интерфейс для работы с Urls
from PyQt5.QtCore import QUrl, QObject, pyqtSignal, pyqtSlot
from PyQt5.QtWidgets import QApplication
# Класс QQuickView предоставляет возможность отображать QML файлы.
from PyQt5.QtQuick import QQuickView

import PageModel as PM


class Context(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.pageList=[]

    createPageSignal = pyqtSignal(int,int,int, arguments=['ID','X','Y'])
    addElementToPageSignal= pyqtSignal(str,int,int,int, arguments=['ElementName','X','Y', 'pageID'])

    @pyqtSlot(int,int,int,int,str)
    def createPage(self, x, y, width, height, color):
        print("CreatePage", x, y, width, height, color)
        id = 1
        if len(self.pageList) > 0:
            id =  self.pageList[-1].id+1

        self.pageList.append(PM.PageModel(id, x, y, width, height, color))
        self.createPageSignal.emit(id, x, y)

    @pyqtSlot(str,int,int,int,int,int,str)
    def addElementToPage(self, elementName, pageId, x, y, width, height, color):
        print("AddElement", self.pageList)
        self.pageList[pageId-1].addElement(elementName, x, y, width, height, color)
        self.addElementToPageSignal.emit(elementName, x, y, pageId)

    @pyqtSlot(str)
    def printConsoleMessage(self, text):
        print(text)

    @pyqtSlot()
    def showPreview(self):
        for p in self.pageList:
            print("Page:",p.id)
            for e in p.elementList:
                print("element",e.id)


        view1 = QQuickView()
        view1.setSource(QUrl('QML/PreviewWindow.qml'))


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