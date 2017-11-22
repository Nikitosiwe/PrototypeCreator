import QtQuick 2.0

Rectangle {
    id: contextMenu

    x:parent.x+200
    y:parent.y+200


    visible: parent.selectedElement != null

    property bool isOpen: true

    property var changingElement: contextMenu.parent.selectedElement


    width: 50
    height: 50
    radius: 5

    z:2
    color:"lightgrey"


    MouseArea{
        anchors.fill: parent
        drag{
            target: parent
            minimumX: 0
            minimumY: 0
            maximumX: parent.parent.width - parent.width
            maximumY: parent.parent.height - parent.height
        }
        cursorShape: Qt.SizeAllCursor
        onClicked: {
            contextMenu.isOpen = !contextMenu.isOpen
        }
    }

    states: [
        State {
            name:"MenuOpen"
            when: contextMenu.isOpen
            PropertyChanges { target: contextMenu; color:"grey"; width:width+5; height: height +5;}
        }
    ]

    Rectangle{
        id: contextMenu_Link

        width: contextMenu.width - 5
        height: contextMenu.height - 5
        radius: contextMenu.radius

        visible: contextMenu.isOpen

        property bool isOpen: false

        x: - width - 5
        y: 3

        color: "lightblue"

        MouseArea{
            anchors.fill: parent
            onClicked: {
                parent.isOpen = !parent.isOpen
            }
        }

        function getCount(){
            var mas =[]
            for(var i=0; i<contextMenu.parent.children.length;i++){
                var p = contextMenu.parent.children[i];
                if(p.elementId>0){
                    mas.push(p.elementId)
                }
            }
            return mas
        }

        Column{
            id: link_subMenu
            y:contextMenu_Link.width+5
            visible: contextMenu_Link.isOpen
            spacing: 5
            Repeater {
                model: contextMenu_Link.getCount()
                Rectangle {
                    id:rect
                    width: contextMenu_Link.width; height: 20;
                    radius: contextMenu_Link.radius
                    color:contextMenu_Link.color
                    Text{
                        id:text
                        anchors.fill: parent
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Page "+ modelData
                        font.pointSize: 12
                    }
                    MouseArea{
                        id:hoverArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            contextMenu_Link.isOpen=false
                            contextMenu.parent.selectedElement.linkId = modelData
                        }
                    }
                    states: [
                        State {
                            name:"hover"
                            when: hoverArea.containsMouse
                            PropertyChanges { target: rect; color:"grey";}
                        }
                    ]

                }
            }
        }

    }

    Rectangle{
        id: contextMenu_Settings

        width: contextMenu.width - 5
        height: contextMenu.height - 5
        radius: contextMenu.radius

        visible: contextMenu.isOpen

        x: contextMenu_Link.x - width - 5
        y: 3

        color: "lightgreen"

        MouseArea{
            anchors.fill: parent
            onClicked: {
                changingElement.color = "gold"
            }
        }

    }

    Rectangle{
        id: contextMenu_Delete

        width: contextMenu.width - 5
        height: contextMenu.height - 5
        radius: contextMenu.radius

        visible: contextMenu.isOpen

        x: contextMenu_Settings.x - width - 5
        y: 3

        color: "#ff4c5b"

        MouseArea{
            anchors.fill: parent
            onClicked: {
                changingElement.destroy()
            }
        }

    }





}
