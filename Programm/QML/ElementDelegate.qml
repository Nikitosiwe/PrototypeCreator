import QtQuick 2.0


//Делегат для елементов списка
Item {
    id: root
    width: parent.width
    height: 50
    MouseArea {
        id: dragArea

        property bool held: false

        anchors { left: parent.left; right: parent.right }
        height: parent.height
        width: parent.width

        drag.target: held ? content : undefined
        drag.axis: Drag.XandYAxis

        onPressed:  held = true
        onReleased: {content.Drag.drop(); held = false; }



        //Содержимое елемента списка
        Rectangle {
            id: content

            Drag.active: dragArea.drag.active
            Drag.hotSpot.x: parent.width/2
            Drag.hotSpot.y: parent.height/2
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
            width: parent.width; height: parent.height

            border.width: 1
            border.color: "lightsteelblue"

            color: dragArea.held ? "lightsteelblue" : "white"
            Behavior on color { ColorAnimation { duration: 100 } }

            radius: 2

            states: State {
                when: dragArea.held

                ParentChange { target: content; parent: root }
                AnchorChanges {
                    target: content
                    anchors { horizontalCenter: undefined; verticalCenter: undefined }
                }
            }
            Text { text: model.name }
        }
    }
}
