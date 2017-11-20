import sys

from PyQt5.QtCore import QUrl, QObject, pyqtSignal, pyqtSlot

import PageModel as PM
import PreviewWindow as PW

class Context(QObject):
    def __init__(self, parent):
        QObject.__init__(self)
        self.pageList=[]
        self.parent = parent


    createPageSignal = pyqtSignal(int,int,int, arguments=['ID','X','Y'])
    addElementToPageSignal= pyqtSignal(str,int,int,int, arguments=['ElementName','X','Y', 'pageID'])



    @pyqtSlot(int,int,int,int,int,str)
    def createPage(self, isPreview, x, y, width, height, color):
        print("CreatePage", x, y, width, height, color)
        id = 1
        if len(self.pageList) > 0:
            id =  self.pageList[-1].id+1

        self.pageList.append(PM.PageModel(id, x, y, width, height, color))
        if isPreview==0:
            self.createPageSignal.emit(id, x, y)

    @pyqtSlot(int,str,int,int,int,int,int,str)
    def addElementToPage(self,isPreview, elementName, pageId, x, y, width, height, color):
        #print("AddElement", self.pageList)
        self.pageList[pageId-1].addElement(elementName, x, y, width, height , color)
        if isPreview == 0:
            self.addElementToPageSignal.emit(elementName, x, y, pageId)


    @pyqtSlot(str)
    def printConsoleMessage(self, text):
        print(text)

    @pyqtSlot()
    def clearModel(self):
        self.pageList.clear()

    @pyqtSlot()
    def showPreview(self):

        previewWindow = PW.PreviewWindow(self.parent)

        for p in self.pageList:
            print("Page:",p.id,p.color)
            for e in p.elementList:
                print("element",e.id)

