import QtQuick 2.0


//Делегат для елементов списка
Item {
    id: root
    width: dragArea.width
    height: dragArea.height
    MouseArea {
        id: dragArea

        property bool held: false

        anchors { left: parent.left; right: parent.right }
        height: content.height
        width: content.width

        drag.target: held ? content : undefined
        drag.axis: Drag.XandYAxis

        onPressed:  held = true
        onReleased: {content.Drag.drop(); held = false; }



        //Содержимое елемента списка
        Rectangle {
            id: content

            Drag.active: dragArea.drag.active
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
            width: 50; height: 50

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
