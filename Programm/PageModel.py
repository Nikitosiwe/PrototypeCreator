import ElementModel as EM

class PageModel():
    def __init__(self, id, x, y, width, height, color):
        self.id = id
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.color = color
        self.elementList =[]

    def addElement(self, elementName, x, y, width, height, color):
        id =1
        if len(self.elementList)>0:
            id = self.elementList[-1].id + 1
        element = EM.ElementModel(id, elementName, x, y, width, height, color)
        self.elementList.append(element)

