import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.2

ApplicationWindow {
    title: qsTr("Preview Window")
    id: previewWindow
    visible: true
    width:300
    height: 400
    color: "green"

    property int  myScale: 6



    Rectangle{
        id: fon
        color: "blue"
        anchors.fill: parent
    }

    Button{
        id:buttonShowPreview
        width: 100
        height: 30
        text: qsTr("Предпросмотр")
        onClicked: {
            previewContext.initializeComponents();
        }
    }



    function createPagePreview(PageId,Width, Height, Color){
        var v = false
        if (PageId==1) v =true;
        var component = Qt.createComponent("Page_Preview.qml");
        if (component.status == Component.Ready)
            component.createObject(fon, {"pageId":PageId, "visible": v, "width": Width * myScale, "height": Height * myScale, "color":Color});
    }


    function changeLink(LinkId){
        previewWindow.color = "gold"
        for(var i=0; i<fon.children.length;i++){
           // previewContext.printConsoleMessage(fon.children[i])
           if (fon.children[i].pageId>0 && LinkId>0){
               //previewContext.printConsoleMessage("page"+fon.children[i].pageId)
                //previewWindow.color = "gold"
                fon.children[i].visible = false
                if (fon.children[i].pageId==LinkId){
                    fon.children[i].visible = true
                }
            }
        }

    }



    Connections {
        target: previewContext

        // Sum signal handler
        onCreatePagePreviewSignal: {
           previewWindow.createPagePreview(PageId,Width, Height, Color);
       }

        onChangeLinkSignal: {
            previewWindow.changeLink(LinkId);

        }
    }


}
