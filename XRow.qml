import QtQuick 2.0

Row {
    id: r
    property int zoomStatus: -1
    property int sections: 5
    property int yIndex: 0
    property int borderWidth: 2
    property int cellWidth: 2
    property int cellHeight: 2
    property int cx: 0
    property int cy: 0

    Repeater{
        model: r.sections
        Rectangle{
            width: r.cellWidth
            height: r.cellHeight
            border.width: app.zoomStatus!==2?(selected?r.borderWidth*2:r.borderWidth):0
            border.color: 'red'
            color: 'transparent'
            property bool selected: r.cx===index&&r.cy===r.yIndex
            Rectangle{
                width: app.zoomStatus!==2?5:parent.width
                height: app.zoomStatus!==2?width:parent.height
                color: 'red'
                radius: app.zoomStatus!==2?width*0.5:0
                anchors.centerIn: parent
                opacity: app.zoomStatus!==2?1.0:0.5
                //visible: app.zoomStatus!==2
            }
            Rectangle{
                anchors.fill: parent
                opacity: app.zoomStatus!==2?(parent.selected?0.25:0.0):parent.selected?0.5:0.0
            }
        }
    }
}
