import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: page
    color: "white"
    property int rulersSize: page.width/15
    property color rulersColor: "transparent"

    property int minimumHeight: 100
    property int minimumWidth: 100
    z:1
    border.width: 2
    radius: 10
    layer.enabled: true
    layer.effect: DropShadow {
        transparentBorder: true
        //horizontalOffset: 80
        //verticalOffset: 80
        radius: 5
    }

    MouseArea{
        id: mouseArea
        hoverEnabled: true
        anchors.fill: parent

        MouseArea{
            id: mouseArea2
            anchors{
                fill: parent
                margins: 5
            }
            drag{
                target: page
                smoothed: false
            }
            onClicked: {
                elementsPanel.visible = !elementsPanel.visible
            }

            hoverEnabled: true
        }


    }

    states: [
            State {
                when: mouseAreaTopRight.drag.active || mouseAreaTopLeft.drag.active || mouseAreaBottomLeft.drag.active || mouseAreaBottomRight.drag.active
                PropertyChanges { target: page; border.color: "steelblue" }
            },
            State {
                when: mouseAreaTopRight.containsMouse || mouseAreaTopLeft.containsMouse || mouseAreaBottomLeft.containsMouse || mouseAreaBottomRight.containsMouse
                PropertyChanges { target: page; border.color: "steelblue" }
            },
            State {
                when: !mouseArea.containsMouse
                PropertyChanges { target: page; border.color: "white" }
            }
        ]



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




}
