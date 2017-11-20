import QtQuick 2.0

Rectangle {
    id: selComp

    property string type: "element"
    property bool isSelect: true
    property int rulersSize: 5
    property color rulersColor: "steelblue"

    property int minimumHeight: 20
    property int minimumWidth: 20

    property int myScale: parent.myScale

    property int linkId: 2


    property int relHeight: 1
    property int relWidth: 1

    property int relX: 1
    property int relY: 1

    property string elementName: "rectangleBlock"



/*
    width: parent.width/relWidth
    height: parent.height/relHeight

    x:relX
    y:relY*/


    color: "#354682"

    border {
        width: 1
        color: isSelect ? color : "steelblue"
    }



    MouseArea {     // drag mouse area
        anchors.fill: parent
        drag{
            target: parent.isSelect ? undefined : parent
            minimumX: - parent.width/2
            minimumY: - parent.height/2
            maximumX: parent.parent.width - parent.width/2
            maximumY: parent.parent.height - parent.height/2
            smoothed: false
        }
        onClicked: {
            if(parent.state!="close")
                parent.isSelect = !parent.isSelect
        }
        onMouseXChanged: {
            selComp.relX = selComp.parent.width/selComp.x
        }
        onMouseYChanged: {
            selComp.relY = selComp.parent.height/selComp.y
        }

        onDoubleClicked: {
            parent.destroy()        // destroy component
        }
    }



    states: [
            State {
                name:"close"
                when: parent.state==""
                PropertyChanges {
                    target: selComp;
                    //color:"green";
                    x:x/selComp.myScale;
                    y:y/selComp.myScale;
                    width:width/selComp.myScale;
                    height:height/selComp.myScale;
                    isSelect: true;
                }
            }
        ]


    //Top Left
    Rectangle {
        width: rulersSize
        height: rulersSize
        radius: rulersSize
        color: rulersColor
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: -rulersSize/2
        anchors.leftMargin: -rulersSize/2
        visible: !parent.isSelect

        MouseArea {
            anchors.fill: parent
            drag{ target: parent;}
            onMouseXChanged: {
                if(drag.active){
                    if(selComp.width - mouseX >=minimumWidth){
                        selComp.x = selComp.x + mouseX
                        selComp.width = selComp.width - mouseX
                    }
                    else{
                       selComp.x =  selComp.x + selComp.width - minimumWidth
                       selComp.width = minimumWidth
                    }
                }
            }
           onMouseYChanged: {
               if(drag.active){
                   if(selComp.height - mouseY >=minimumHeight){
                       selComp.y = selComp.y + mouseY
                       selComp.height = selComp.height - mouseY
                   }
                   else{
                      selComp.y =  selComp.y + selComp.height - minimumHeight
                      selComp.height = minimumHeight
                   }
               }
            }
        }
    }


    //Right Top
    Rectangle {
        width: rulersSize
        height: rulersSize
        radius: rulersSize
        color: rulersColor
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: -rulersSize/2
        anchors.rightMargin: -rulersSize/2
        visible: !parent.isSelect

        MouseArea {
            anchors.fill: parent
            drag{ target: parent;}
            onMouseXChanged: {
                if(drag.active){
                    if(selComp.width + mouseX >=minimumWidth){
                        selComp.width = selComp.width + mouseX
                    }
                    else{
                        selComp.width = minimumWidth
                    }
                }
            }
           onMouseYChanged: {
               if(drag.active){
                   if(selComp.height - mouseY >=minimumHeight){
                       selComp.y = selComp.y + mouseY
                       selComp.height = selComp.height - mouseY
                   }
                   else{
                      selComp.y =  selComp.y + selComp.height - minimumHeight
                      selComp.height = minimumHeight
                   }
               }
            }
        }
    }


    //Left Bottom
    Rectangle {
        width: rulersSize
        height: rulersSize
        radius: rulersSize
        color: rulersColor
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.leftMargin: -rulersSize/2
        anchors.bottomMargin: -rulersSize/2
        visible: !parent.isSelect

        MouseArea {
            anchors.fill: parent
            drag{ target: parent;}
            onMouseXChanged: {
                if(drag.active){
                    if(selComp.width - mouseX >=minimumWidth){
                        selComp.x = selComp.x + mouseX
                        selComp.width = selComp.width - mouseX
                    }
                    else{
                       selComp.x =  selComp.x + selComp.width - minimumWidth
                       selComp.width = minimumWidth
                    }
                }
            }
           onMouseYChanged: {
               if(drag.active){
                   if(selComp.height + mouseY >=minimumHeight){
                       selComp.height = selComp.height + mouseY
                   }
                   else{
                       selComp.height = minimumHeight
                   }
               }
            }
        }
    }

    //Right Bottom
    Rectangle {
        width: rulersSize
        height: rulersSize
        radius: rulersSize
        color: rulersColor
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: -rulersSize/2
        anchors.bottomMargin: -rulersSize/2
        visible: !parent.isSelect

        MouseArea {
            anchors.fill: parent
            drag{ target: parent;}
            onMouseXChanged: {
                if(drag.active){
                    if(selComp.width + mouseX >=minimumWidth){
                        //selComp.x = selComp.x + mouseX
                        selComp.width = selComp.width + mouseX
                    }
                    else{
                       //selComp.x =  selComp.x + selComp.width - minimumWidth
                       selComp.width = minimumWidth
                    }
                }
            }
           onMouseYChanged: {
               if(drag.active){
                   if(selComp.height + mouseY >=minimumHeight){
                       selComp.height = selComp.height + mouseY
                   }
                   else{
                       selComp.height = minimumHeight
                   }
               }
            }
        }
    }


}
