import QtQuick 2.0

Column {
    id: r
    property int zoomStatus: -1
    property int sections: 5
    property int borderWidth: 2
    property int cellWidth: 2
    property int cellHeight: 2
    property int cx: 0
    property int cy: 0
    property bool selected1: false
    signal seted
    Repeater{
        model: r.sections
        XRow{
            sections: r.sections
            cellWidth:r.cellWidth
            cellHeight:r.cellHeight
            yIndex: index
            borderWidth: r.borderWidth
            zoomStatus: r.zoomStatus
            cx:r.cx
            cy:r.cy
        }
    }
    Timer{
        running: true
        repeat: true
        interval: 100
        onTriggered: {
            if(app.zoomStatus===0){
                r.cx=apps.ux1
                r.cy=apps.uy1
            }
            if(app.zoomStatus===1){
                r.cx=apps.ux2
                r.cy=apps.uy2
            }
            if(app.zoomStatus===2){
                r.cx=apps.ux3
                r.cy=apps.uy3
            }
        }
    }

    Timer{
        id: tDestroy
        running: true
        repeat: false
        interval: 2000
        onTriggered: {
            if(r.zoomStatus===1){
//                if(r.zoomStatus!==2&&xGridZoom2.children.length<=0){
//                    //app.zoomStatus=0
//                }
                //app.clear()
                //r.destroy(1)
            }
        }
     }
    Component.onCompleted: {
        /*if(r.zoomStatus===1){
            //app.zoomStatus=1
            r.zoomStatus=1
            r.borderWidth=1
        }*/
    }
    function toRight(){
        if(r.cx<r.sections-1){
            r.cx++
        }else{
            r.cx=0
        }
        tDestroy.restart()
    }
    function toLeft(){
        if(r.cx>0){
            r.cx--
        }else{
            r.cx=r.sections-1
        }
        tDestroy.restart()
    }
    function toDown(){
        if(r.cy<r.sections-1){
            r.cy++
        }else{
            r.cy=0
        }
        tDestroy.restart()
    }
    function toUp(){
        if(r.cy>0){
            r.cy--
        }else{
            r.cy=r.sections-1
        }
        tDestroy.restart()
    }
    function toSelect(){
            r.seted()        
    }
}
