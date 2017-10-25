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
            width: 100
            anchors{
                top: parent.top
                bottom: parent.bottom
            }
            color: "lightgrey"

            //Список элементов
            ListView {
                  id: view

                  anchors.margins: 10
                  anchors.fill: parent
                  spacing: 10
                  //ElementsModel - модель в отдельном файле
                  model: ElementsModel{}
                  clip: true

                  //Объект для выделения выбраного эелемнта в списке
                  highlight: Rectangle {
                      color: "skyblue"
                  }
                  highlightFollowsCurrentItem: true


                  //Объект который будет создаваться на каждый объект модели
                  delegate: Item {
                      id: listDelegate

                      property var view: ListView.view
                      property var isCurrent: ListView.isCurrentItem

                      width: view.width
                      height: 40

                      Rectangle {
                          anchors.margins: 5
                          anchors.fill: parent
                          radius: height / 2
                          color: model.color
                          border {
                              color: "black"
                              width: 1
                          }

                          Text {
                              anchors.centerIn: parent
                              renderType: Text.NativeRendering
                              text: "%1%2".arg(model.text).arg(isCurrent ? " *" : "")
                          }

                          //При клике на елемент текущий индекс списка изменяется
                          MouseArea {
                              anchors.fill: parent
                              onClicked: view.currentIndex = model.index
                          }
                      }
                  }
              }
        }


        //Пространство для проектирования прототипа
        Rectangle{
            Layout.fillWidth: true
            width:200
            height: 100
            anchors{
                top: parent.top
                bottom: parent.bottom
            }
            color: "white"
        }
    }

}
