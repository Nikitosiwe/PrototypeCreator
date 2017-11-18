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
            id: elementsPanel

            width: 200
            visible: true
            z:1
            anchors{
                top: parent.top
                bottom: parent.bottom
            }
            color: "lightgrey"

            //Список элементов
            ListView {
                id: view

                anchors { fill: parent; left: parent.left; top: parent.top; bottom: parent.bottom; margins: 2 }
                width: 100

                model: ElementsModel{}
                delegate:ElementDelegate{}

                spacing: 4
                cacheBuffer: 50
            }
        }



        /*Flickable {
            Layout.fillWidth: true
            z:0
            width:200
            height: 100
            anchors{
                top: parent.top
                bottom: parent.bottom
                margins: 10
            }
            contentWidth: createPlace.width*createPlace.scale
            contentHeight: createPlace.height*createPlace.scale

            Rectangle{
                id: createPlace
                transformOrigin: Item.TopLeft
                x: 0; y: 0;
                width:600
                height: 600
                color: "white"


                MouseArea{
                    anchors.fill: parent
                    onWheel:{
                        if(wheel.angleDelta.y > 0)  // zoom in
                            createPlace.scale += 0.2;
                        else
                            createPlace.scale -= 0.2;// zoom out
                    }
                }

                //Областьдля перетаскивания елементов из списка
                DropArea {
                    id: dragTarget
                    anchors.fill: parent

                    onEntered: {
                        //parent.color = "green"
                    }
                    onExited: {
                        //parent.color = "red"
                    }
                    onDropped: {
                        //parent.color = drag.source.color
                        mainContext.printConsoleMessage(drag.source.elementName)
                        var component = Qt.createComponent(drag.source.elementName+".qml");
                        if (component.status == Component.Ready)
                            component.createObject(parent, {"x": drag.x, "y": drag.y, "width": 100, "height":100});

                    }
                }
            }
        }*/ Rectangle {
            id: prototypingArea
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "lightgrey"
            z:0

            property Page selectedPage;


            MouseArea{
                anchors.fill: parent
                onDoubleClicked: {
                   mainContext.createPage(mouse.x, mouse.y, parent.width/6-3, parent.height/6-3, "white")
                }
                onClicked: {
                    if(parent.selectedPage != undefined){
                        parent.selectedPage.isSelected = false
                    }
                }
            }

            Button{
                id:buttonShowPreview
                width: 100
                height: 30
                text: qsTr("Предпросмотр")
                onClicked: {
                    mainContext.showPreview();
                }
            }

            function createPage(ID,X,Y){
                var component = Qt.createComponent("Page.qml");
                if (component.status == Component.Ready)
                    component.createObject(prototypingArea, {"elementId": ID,"x": X, "y": Y, "myScale": 6, "width": prototypingArea.width/6-3, "height":prototypingArea.height/6-3});
            }

        }

    }
    Connections {
        target: mainContext

        // Sum signal handler
        onCreatePageSignal: {
           prototypingArea.createPage(ID,X,Y);
       }


    }


}


