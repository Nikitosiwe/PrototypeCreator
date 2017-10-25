import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.2

ApplicationWindow {
    title: qsTr("Prototype Creator")
    visible: true

    //Размер главного окна зависит от содержимого mainLayout
    width: mainLayout.implicitWidth
    height: mainLayout.implicitHeight
    minimumWidth: mainLayout.Layout.minimumWidth
    minimumHeight: mainLayout.Layout.minimumHeight

    color: "grey"

    //Компановщик главного окна
    GridLayout{
        id: mainLayout
        rows: 2
        anchors.fill: parent

        //Панель элементов
        Rectangle{
            width: 200
            z:1
            anchors{
                top: parent.top
                bottom: parent.bottom
            }
            color: "lightgrey"

            //Список элементов
            ListView {
                id: view

                anchors { left: parent.left; top: parent.top; bottom: parent.bottom; margins: 2 }
                width: 100

                model: ElementsModel{}
                delegate:ElementDelegate{}

                spacing: 4
                cacheBuffer: 50
            }
        }


        //Пространство для проектирования прототипа
        Rectangle{
            Layout.fillWidth: true
            z:0
            width:200
            height: 100
            anchors{
                top: parent.top
                bottom: parent.bottom
            }
            color: "white"

            //Областьдля перетаскивания елементов из списка
            DropArea {
                id: dragTarget
                anchors.fill: parent

                onEntered: {
                    parent.color = "green"
                }
                onExited: {
                    parent.color = "red"
                }
            }


        }
    }

}
