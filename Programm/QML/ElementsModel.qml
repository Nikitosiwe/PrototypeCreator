import QtQuick 2.4


//Модель для списка элементов
ListModel {
       id: dataModel

       ListElement {
           color: "grey"
           name: "Прямоугольник"
           elementName: "rectangleBlock"
       }
       ListElement {
           color: "orange"
           name: "Текст"
           elementName:"textBlock"
       }
   }
