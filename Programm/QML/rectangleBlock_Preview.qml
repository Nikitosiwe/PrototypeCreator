import QtQuick 2.0

Rectangle {
    id: rectangleBlock

     property int linkId: 2


    MouseArea{
        anchors.fill: parent
        onClicked: {
            previewContext.changeLinkPage(linkId);
        }
    }

}
