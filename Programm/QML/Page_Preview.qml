import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: page_Preview
    color: "red"

    property int pageId:0

    property int  myScale: previewWindow.myScale

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

    anchors.centerIn: parent


    function createElementPreview(PageID,ElementName,X,Y,Width,Height,Color,LinkID){


        if (PageID==page_Preview.pageId){
            //previewContext.printConsoleMessage("asdasda"+ElementName);
            //page_Preview.color = "red";
            //previewContext.printConsoleMessage("asdasda"+ElementName);
            var s =page_Preview.myScale;
            //previewContext.printConsoleMessage(s);
            var component = Qt.createComponent(ElementName+"_Preview.qml");
            if (component.status == Component.Ready)
                component.createObject(page_Preview, {"x": X * s, "y": Y * s, "width":Width * s, "height":Height * s, "color": Color, "linkId":LinkID});

        }

    }


    Connections {
        target: previewContext

        // Sum signal handler
        onCreateElementPreviewSignal: {

           page_Preview.createElementPreview(PageID,ElementName,X,Y,Width,Height,Color,LinkID)

       }
    }

}
