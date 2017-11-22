import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.1

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
            contextMenu_Link.isOpen = false
            contextMenu_Settings.isOpen = false
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

        property bool isOpen: false

        x: contextMenu_Link.x - width - 5
        y: 3

        color: "lightgreen"

        MouseArea{
            anchors.fill: parent
            onClicked: {
                contextMenu_Settings.isOpen = !contextMenu_Settings.isOpen
            }
        }

        Rectangle{
            id: settingsPanel
            color: "#fafafa"
            width: 180
            height: 260
            border.color: "lightgrey"
            border.width: 1
            radius: contextMenu_Settings.radius
            y: contextMenu_Settings.height + 5
            visible: contextMenu_Settings.isOpen
            anchors.right: contextMenu_Settings.right



            Column{
                anchors{
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                    topMargin: 10
                }
                spacing: 10
                Row{
                    anchors.right: parent.right
                    spacing: 10
                    Text{
                        text: "X: "
                        font.pointSize: 12
                    }
                    Row{
                        spacing: 3

                        Rectangle{
                            width: 20
                            height: parent.height
                            color: "lightgrey"
                            Text {
                                anchors.centerIn: parent
                                text: "-"
                                font.pointSize: 20
                                color: "#363636"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    contextMenu.parent.selectedElement.x-=1
                                }
                            }
                        }

                        TextField{
                            width: 50
                            font.pointSize: 12
                            horizontalAlignment: TextInput.AlignRight
                            validator: IntValidator{}
                            text: contextMenu.parent.selectedElement.x
                            onTextChanged: {
                                contextMenu.parent.selectedElement.x = text
                            }
                        }

                        Rectangle{
                            width: 20
                            height: parent.height
                            color: "lightgrey"
                            Text {
                                anchors.centerIn: parent
                                text: "+"
                                font.pointSize: 20
                                color: "#363636"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    contextMenu.parent.selectedElement.x+=1
                                }
                            }
                        }
                    }
                }
                Row{
                     anchors.right: parent.right
                    spacing: 10
                    Text{
                        text: "Y: "
                        font.pointSize: 12
                    }

                    Row{
                        spacing: 3
                        Rectangle{
                            width: 20
                            height: parent.height
                            color: "lightgrey"
                            Text {
                                anchors.centerIn: parent
                                text: "-"
                                font.pointSize: 20
                                color: "#363636"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    contextMenu.parent.selectedElement.y-=1
                                }
                            }
                        }

                        TextField{
                            width: 50
                            font.pointSize: 12
                            horizontalAlignment: TextInput.AlignRight
                            validator: IntValidator{}
                            text: contextMenu.parent.selectedElement.y
                            onTextChanged: {
                                contextMenu.parent.selectedElement.y = text
                            }
                        }
                        Rectangle{
                            width: 20
                            height: parent.height
                            color: "lightgrey"
                            Text {
                                anchors.centerIn: parent
                                text: "+"
                                font.pointSize: 20
                                color: "#363636"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    contextMenu.parent.selectedElement.y+=1
                                }
                            }
                        }
                    }
                }
                Row{
                    anchors.right: parent.right
                    spacing: 10
                    Text{
                        text: "Width: "
                        font.pointSize: 12
                    }
                    Row{
                        spacing: 3
                        Rectangle{
                            width: 20
                            height: parent.height
                            color: "lightgrey"
                            Text {
                                anchors.centerIn: parent
                                text: "-"
                                font.pointSize: 20
                                color: "#363636"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    contextMenu.parent.selectedElement.width-=1
                                }
                            }
                        }

                        TextField{
                            width: 50
                            font.pointSize: 12
                            horizontalAlignment: TextInput.AlignRight
                            validator: IntValidator{}
                            text: contextMenu.parent.selectedElement.width
                            onTextChanged: {
                                contextMenu.parent.selectedElement.width = text
                            }
                        }
                        Rectangle{
                            width: 20
                            height: parent.height
                            color: "lightgrey"
                            Text {
                                anchors.centerIn: parent
                                text: "+"
                                font.pointSize: 20
                                color: "#363636"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    contextMenu.parent.selectedElement.width+=1
                                }
                            }
                        }
                    }

                }
                Row{
                     anchors.right: parent.right
                    spacing: 10
                    Text{
                        text: "Height: "
                        font.pointSize: 12
                    }
                    Row{
                        spacing: 3
                        Rectangle{
                            width: 20
                            height: parent.height
                            color: "lightgrey"
                            Text {
                                anchors.centerIn: parent
                                text: "-"
                                font.pointSize: 20
                                color: "#363636"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    contextMenu.parent.selectedElement.height-=1
                                }
                            }
                        }

                        TextField{
                            width: 50
                            font.pointSize: 12
                            horizontalAlignment: TextInput.AlignRight
                            validator: IntValidator{}
                            text: contextMenu.parent.selectedElement.height
                            onTextChanged: {
                                contextMenu.parent.selectedElement.height = text
                            }
                        }
                        Rectangle{
                            width: 20
                            height: parent.height
                            color: "lightgrey"
                            Text {
                                anchors.centerIn: parent
                                text: "+"
                                font.pointSize: 20
                                color: "#363636"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    contextMenu.parent.selectedElement.height+=1
                                }
                            }
                        }
                    }

                }
                Row{
                     anchors.right: parent.right
                    spacing: 10
                    Text{
                        text: "Radius: "
                        font.pointSize: 12
                    }
                    Row{
                        spacing: 3
                        Rectangle{
                            width: 20
                            height: parent.height
                            color: "lightgrey"
                            Text {
                                anchors.centerIn: parent
                                text: "-"
                                font.pointSize: 20
                                color: "#363636"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    contextMenu.parent.selectedElement.radius-=1
                                }
                            }
                        }

                        TextField{
                            width: 50
                            font.pointSize: 12
                            horizontalAlignment: TextInput.AlignRight
                            validator: IntValidator{}
                            text: contextMenu.parent.selectedElement.radius
                            onTextChanged: {
                                contextMenu.parent.selectedElement.radius = text
                            }
                        }
                        Rectangle{
                            width: 20
                            height: parent.height
                            color: "lightgrey"
                            Text {
                                anchors.centerIn: parent
                                text: "+"
                                font.pointSize: 20
                                color: "#363636"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    contextMenu.parent.selectedElement.radius+=1
                                }
                            }
                        }
                    }

                }
                Row{
                     anchors.right: parent.right
                    spacing: 10
                    Text{
                        text: "Color: "
                        font.pointSize: 12
                    }
                    Rectangle{
                        width: 96
                        height: parent.height
                        color: contextMenu.parent.selectedElement.color
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                colorDialog1.open()
                            }
                        }
                    }
                }
                Row{
                     anchors.right: parent.right
                    spacing: 10
                    Text{
                        text: "B color: "
                        font.pointSize: 12
                    }
                    Rectangle{
                        width: 96
                        height: parent.height
                        color: contextMenu.parent.selectedElement.border.color
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                colorDialog2.open()
                            }
                        }
                    }
                }
                Row{
                     anchors.right: parent.right
                    spacing: 10
                    Text{
                        text: "B size: "
                        font.pointSize: 12
                    }
                    Row{
                        spacing: 3
                        Rectangle{
                            width: 20
                            height: parent.height
                            color: "lightgrey"
                            Text {
                                anchors.centerIn: parent
                                text: "-"
                                font.pointSize: 20
                                color: "#363636"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    contextMenu.parent.selectedElement.border.width-=1
                                }
                            }
                        }

                        TextField{
                            width: 50
                            font.pointSize: 12
                            horizontalAlignment: TextInput.AlignRight
                            validator: IntValidator{}
                            text: contextMenu.parent.selectedElement.border.width
                            onTextChanged: {
                                contextMenu.parent.selectedElement.border.width = text
                            }
                        }
                        Rectangle{
                            width: 20
                            height: parent.height
                            color: "lightgrey"
                            Text {
                                anchors.centerIn: parent
                                text: "+"
                                font.pointSize: 20
                                color: "#363636"
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    contextMenu.parent.selectedElement.border.width+=1
                                }
                            }
                        }
                    }

                }
            }

            ColorDialog {
                id: colorDialog1
                visible: false
                modality: Qt.WindowModal
                title: "Choose a color"
                color: "green"
                showAlphaChannel: true
                onAccepted: {contextMenu.parent.selectedElement.color = color}
            }

            ColorDialog {
                id: colorDialog2
                visible: false
                modality: Qt.WindowModal
                title: "Choose a color"
                color: "green"
                showAlphaChannel: true
                onAccepted: {contextMenu.parent.selectedElement.border.color = color}
            }




            /*Row{
                Column{
                    anchors.horizontalCenter: settingsPanel_column.horizontalCenter
                    id:col1
                    Text{
                        id:col1_X
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "X: "
                        font.pointSize: 12
                    }
                    Text{
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Y: "
                        font.pointSize: 12
                    }
                    Text{
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: " Width: "
                        font.pointSize: 12
                    }
                    Text{
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: " Height: "
                        font.pointSize: 12
                    }
                }
                Column{
                    anchors.horizontalCenter: settingsPanel_column.horizontalCenter
                    id:col2
                    TextField{
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: contextMenu.parent.selectedElement.x
                        font.pointSize: 12
                        width: 40
                        horizontalAlignment: TextInput.AlignHCenter
                        validator: IntValidator{}
                        onTextChanged: {
                            contextMenu.parent.selectedElement.x = text
                        }
                    }
                    TextField{
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: contextMenu.parent.selectedElement.y
                        font.pointSize: 12
                        width: 40
                        horizontalAlignment: TextInput.AlignHCenter
                        validator: IntValidator{}
                        onTextChanged: {
                            contextMenu.parent.selectedElement.y = text
                        }
                    }
                    TextField{
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: contextMenu.parent.selectedElement.height
                        font.pointSize: 12
                        width: 40
                        horizontalAlignment: TextInput.AlignHCenter
                        validator: IntValidator{}
                        onTextChanged: {
                            contextMenu.parent.selectedElement.height = text
                        }
                    }
                    TextField{
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: contextMenu.parent.selectedElement.width
                        font.pointSize: 12
                        width: 40
                        horizontalAlignment: TextInput.AlignHCenter
                        validator: IntValidator{}
                        onTextChanged: {
                            contextMenu.parent.selectedElement.width = text
                        }
                    }
                }
            }*/

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
