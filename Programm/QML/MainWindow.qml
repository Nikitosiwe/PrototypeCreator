import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.2

ApplicationWindow {
    title: qsTr("Prototype Creator")
    visible: true

    width: mainLayout.implicitWidth
    height: mainLayout.implicitHeight
    minimumWidth: mainLayout.Layout.minimumWidth
    minimumHeight: mainLayout.Layout.minimumHeight

    color: "grey"

    GridLayout{
        id: mainLayout
        rows: 2
        anchors.fill: parent

        Rectangle{
            width: 100
            anchors{
                top: parent.top
                bottom: parent.bottom
            }
            color: "lightgrey"

            ListView {
                  id: view

                  anchors.margins: 10
                  anchors.fill: parent
                  spacing: 10
                  model: ElementsModel{}
                  clip: true

                  highlight: Rectangle {
                      color: "skyblue"
                  }
                  highlightFollowsCurrentItem: true

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

                          MouseArea {
                              anchors.fill: parent
                              onClicked: view.currentIndex = model.index
                          }
                      }
                  }
              }



        }

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
