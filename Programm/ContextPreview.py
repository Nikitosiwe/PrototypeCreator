from PyQt5.QtCore import QUrl, QObject, pyqtSignal, pyqtSlot

class ContextPreview(QObject):
    def __init__(self, parent):
        QObject.__init__(self)
        self.parent = parent


    createPagePreviewSignal = pyqtSignal(int,int,int,str,arguments=['PageId','Width','Height','Color'])

    createElementPreviewSignal = pyqtSignal(int, str, int, int, int, int, str,int, arguments=['PageID','ElementName', 'X', 'Y', 'Width', 'Height', 'Color', 'LinkID'])

    changeLinkSignal = pyqtSignal(int, arguments=['LinkId'])


    @pyqtSlot(str)
    def printConsoleMessage(self, text):
        print("PreviewWindow", text)


    @pyqtSlot(int)
    def changeLinkPage(self, linkId):
        self.changeLinkSignal.emit(linkId)


    @pyqtSlot()
    def initializeComponents(self):
        for PP in self.parent.parent.mainContext.pageList:
            print("page",PP.id, PP.width, PP.height, PP.color)
            self.createPagePreviewSignal.emit(PP.id, PP.width, PP.height, PP.color)
            for EP in PP.elementList:
                print("element", PP.id, EP.elementName, EP.x, EP.y, EP.width, EP.height, EP.color)
                self.createElementPreviewSignal.emit(PP.id, EP.elementName,
                                                     EP.x, EP.y, EP.width,
                                                     EP.height, EP.color,
                                                     EP.linkId)