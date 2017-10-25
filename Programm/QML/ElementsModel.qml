import QtQuick 2.4


//Модель для списка элементов
ListModel {
       id: dataModel

       ListElement {
           color: "orange"
           text: "first"
       }
       ListElement {
           color: "lightgreen"
           text: "second"
       }
       ListElement {
           color: "orchid"
           text: "third"
       }
       ListElement {
           color: "tomato"
           text: "fourth"
       }
   }
