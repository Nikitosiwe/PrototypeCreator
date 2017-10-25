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
