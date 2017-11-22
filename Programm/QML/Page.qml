import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: page
    color: "white"
    property int rulersSize: page.width/15
    property color rulersColor: "transparent"

    property bool isSelected: false

    property int minimumHeight: 100
    property int minimumWidth: 100

    property int  myScale: 6
    property int elementId:0

    z:0
    //border.width: 1
    //border.color: page.color
    radius: 10
    layer.enabled: true
    layer.effect: DropShadow {
        transparentBorder: true
        //horizontalOffset: 80
        //verticalOffset: 80
        radius: 5
    }

   /* Rectangle{
        width: 20;
        height: 20;
        x:10;
        y:10;
        color: "blue"
    }

    Rectangle{
        width: 20;
        height: 20;
        x:page.width-30;
        y:page.height-30;
        color: "green"
    }*/

    state: "close"



    MouseArea{
        id: mouseArea
        hoverEnabled: true
        anchors.fill: parent
        z:1

        MouseArea{
            id: mouseArea2
            anchors{
                fill: parent
                margins: 5
            }
            drag{
                target: !page.isSelected ? page : undefined
                smoothed: false
            }
            onClicked: {
                //elementsPanel.visible = !elementsPanel.visible
                page.isSelected = true
                page.parent.selectedPage = page
            }
            onDoubleClicked: {
                 //page.isSelected = false
                //page.scale-=0.02
            }

            hoverEnabled: true
        }


    }

    states: [
            /*State {
                when: (mouseAreaTopRight.drag.active || mouseAreaTopLeft.drag.active || mouseAreaBottomLeft.drag.active || mouseAreaBottomRight.drag.active) && page.state!="open"
                PropertyChanges { target: page; border.color: "steelblue" }
            },
            State {
                when: (mouseAreaTopRight.containsMouse || mouseAreaTopLeft.containsMouse || mouseAreaBottomLeft.containsMouse || mouseAreaBottomRight.containsMouse) && page.state!="open"
                PropertyChanges { target: page; border.color: "steelblue" }
            },
            State {
                when: !mouseArea.containsMouse && page.state!="open"
                PropertyChanges { target: page; border.color: "white" }
            },*/
            State {
                name:"open"
                when: page.isSelected
                //PropertyChanges { target: page; color:"red"; width: page.parent.width-20; height: page.parent.height-20; x: 10; y: 10; z:1}
                PropertyChanges { target: page; /*color:"red";*/ width:width * myScale; height: height * myScale; z:1}
                PropertyChanges { target: mouseArea; z:0}
                AnchorChanges{target: page; anchors.horizontalCenter: page.parent.horizontalCenter; anchors.verticalCenter: page.parent.verticalCenter}
            }
        ]


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

            mainContext.addElementToPage(0,drag.source.elementName, page.elementId, drag.x, drag.y, 100, 100, "green", 0);



        }
    }

    function addElement(ElementName, X, Y, pageId){
        if (pageId==page.elementId){
            var component = Qt.createComponent(ElementName+".qml");
            if (component.status == Component.Ready)
                component.createObject(page, {"x": X, "y": Y, "width":100, "height":100});


            mainContext.printConsoleMessage(ElementName);
        }
    }

    Connections {
        target: mainContext

        // Sum signal handler
        onAddElementToPageSignal: {
          page.addElement(ElementName, X, Y, pageID);
       }
    }





/*
    //Top Left
    Rectangle {
        width: rulersSize
        height: rulersSize
        //radius: rulersSize
        color: rulersColor
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: -rulersSize/2
        anchors.leftMargin: -rulersSize/2
        visible: true

        MouseArea {
            id:mouseAreaTopLeft
            hoverEnabled: true
            anchors.fill: parent
            drag{ target: parent;}
            cursorShape: Qt.SizeFDiagCursor
            onMouseXChanged: {
                if(drag.active){
                    if(page.width - mouseX >=minimumWidth){
                        page.x = page.x + mouseX
                        page.width = page.width - mouseX
                    }
                    else{
                       page.x =  page.x + page.width - minimumWidth
                       page.width = minimumWidth
                    }
                }
            }
           onMouseYChanged: {
               if(drag.active){
                   if(page.height - mouseY >=minimumHeight){
                       page.y = page.y + mouseY
                       page.height = page.height - mouseY
                   }
                   else{
                      page.y =  page.y + page.height - minimumHeight
                      page.height = minimumHeight
                   }
               }
            }
        }
    }


    //Top Right
    Rectangle {
        width: rulersSize
        height: rulersSize
        //radius: rulersSize
        color: rulersColor
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: -rulersSize/2
        anchors.rightMargin: -rulersSize/2
        visible: true


        MouseArea {
            id:mouseAreaTopRight
            hoverEnabled: true
            anchors.fill: parent
            drag{ target: parent;}
            cursorShape: Qt.SizeBDiagCursor
            onMouseXChanged: {
                if(drag.active){
                    if(page.width + mouseX >=minimumWidth){
                        page.width = page.width + mouseX
                    }
                    else{
                        page.width = minimumWidth
                    }
                }
            }
           onMouseYChanged: {
               if(drag.active){
                   if(page.height - mouseY >=minimumHeight){
                       page.y = page.y + mouseY
                       page.height = page.height - mouseY
                   }
                   else{
                      page.y =  page.y + page.height - minimumHeight
                      page.height = minimumHeight
                   }
               }
            }
        }
    }



    //Bottom Left
    Rectangle {
        width: rulersSize
        height: rulersSize
        //radius: rulersSize
        color: rulersColor
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.leftMargin: -rulersSize/2
        anchors.bottomMargin: -rulersSize/2
        visible: true

        MouseArea {
            id: mouseAreaBottomLeft
            hoverEnabled: true
            anchors.fill: parent
            drag{ target: parent;}
            cursorShape: Qt.SizeBDiagCursor
            onMouseXChanged: {
                if(drag.active){
                    if(page.width - mouseX >=minimumWidth){
                        page.x = page.x + mouseX
                        page.width = page.width - mouseX
                    }
                    else{
                       page.x =  page.x + page.width - minimumWidth
                       page.width = minimumWidth
                    }
                }
            }
           onMouseYChanged: {
               if(drag.active){
                   if(page.height + mouseY >=minimumHeight){
                       page.height = page.height + mouseY
                   }
                   else{
                       page.height = minimumHeight
                   }
               }
            }
        }
    }


    //Bottom Right
    Rectangle {
        width: rulersSize
        height: rulersSize
        //radius: rulersSize
        color: rulersColor
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: -rulersSize/2
        anchors.bottomMargin: -rulersSize/2
        visible: true

        MouseArea {
            id: mouseAreaBottomRight
            hoverEnabled: true
            anchors.fill: parent
            drag{ target: parent;}
            cursorShape: Qt.SizeFDiagCursor
            onMouseXChanged: {
                if(drag.active){
                    if(page.width + mouseX >=minimumWidth){
                        //selComp.x = selComp.x + mouseX
                        page.width = page.width + mouseX
                    }
                    else{
                       //selComp.x =  selComp.x + selComp.width - minimumWidth
                       page.width = minimumWidth
                    }
                }
            }
           onMouseYChanged: {
               if(drag.active){
                   if(page.height + mouseY >=minimumHeight){
                       page.height = page.height + mouseY
                   }
                   else{
                       page.height = minimumHeight
                   }
               }
            }
        }
    }
*/



}
