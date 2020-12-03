import QtQuick 2.7
import QtQuick.Controls 2.12
import QtQuick.Window 2.2
import Qt.labs.settings 1.1

ApplicationWindow {
    id: app
    visible: true
    visibility: "Windowed"
    width: Screen.width
    height: screen.height
    flags: Qt.FramelessWindowHint
    property string moduleName: 'umousekey'
    property int fs: width*0.02
    property int zoomStatus: 0
    color: 'transparent'
    Settings{
        id: apps
        fileName: app.moduleName+'.cfg'
        property int sections: 5
        property int ux1: 0
        property int uy1: 0
        property int ux2: 0
        property int uy2: 0
        property int ux3: 0
        property int uy3: 0
        onUx1Changed: {xGrid.opacity=1.0;tOutOpacity.restart()}
        onUy1Changed: {xGrid.opacity=1.0;tOutOpacity.restart()}
    }
    Item{
        id: xApp
        anchors.fill: parent
        XGrid{
            id: xGrid
            zoomStatus: 0
            sections: apps.sections
            cellWidth: app.width/apps.sections
            cellHeight: app.height/apps.sections
            //visible: app.zoomStatus===0
            onOpacityChanged: {
                if(opacity===1.0){
                    tOutOpacity.restart()
                    //app.clear()
                    //app.clearMicro()
                }
            }
            onSeted:{
                if(app.zoomStatus===0){
                    app.zoomStatus=1
                    apps.ux2=2
                    apps.uy2=2
                    xGrid.x=xApp.width/apps.sections*apps.ux1
                    xGrid.y=xApp.height/apps.sections*apps.uy1
                    xGrid.sections=apps.sections
                    xGrid.cellWidth=xGrid.cellWidth/apps.sections
                    xGrid.cellHeight=xGrid.cellHeight/apps.sections
                    return
                }
                if(app.zoomStatus===1){
                    app.zoomStatus=2
                    apps.ux3=2
                    apps.uy3=2
                    xGrid.x=xGrid.x+xGrid.cellWidth*apps.ux2
                    xGrid.y=xGrid.y+xGrid.cellHeight*apps.uy2
                    xGrid.sections=apps.sections
                    xGrid.cellWidth=xGrid.cellWidth/apps.sections
                    xGrid.cellHeight=xGrid.cellHeight/apps.sections
                    xGrid.borderWidth=1
                    return
                }
                if(app.zoomStatus===2){
                    app.zoomStatus=0
                    //apps.ux3=3
                    //apps.uy3=3
                    xGrid.x=0//xGrid.x+xGrid.cellWidth*apps.ux2
                    xGrid.y=0//xGrid.y+xGrid.cellHeight*apps.uy2
                    xGrid.sections=apps.sections
                    xGrid.cellWidth=app.width/apps.sections
                    xGrid.cellHeight=app.height/apps.sections
                    xGrid.opacity=0.0
                    return
                }
                /*if(app.zoomStatus===-1){
                    app.zoomStatus=0
                    return
                }*/
            }
            Behavior on opacity{
                NumberAnimation{duration: 500}
            }
            Timer{
                id: tOutOpacity
                running: false
                repeat: false
                interval: 2000
                //onTriggered: xGrid.opacity=0.0
            }
        }
        Text{
            text:  'ZE: '+app.zoomStatus//'X:'+apps.ux1+' Y:'+apps.uy1
            color: 'yellow'
            font.pixelSize: 50
            anchors.centerIn: parent
        }
    }
    Shortcut{
        sequence: 'Esc'
        onActivated: {
            Qt.quit()
        }
    }
    Shortcut{
        sequence: 'Right'
        onActivated: {
            if(xGrid.opacity===0.0){
                xGrid.opacity=1.0
                return
            }
            if(app.zoomStatus===0){
                if(apps.ux1<apps.sections-1){
                    apps.ux1++
                }else{
                    apps.ux1=0
                }
            }
            if(app.zoomStatus===1){
                if(apps.ux2<apps.sections-1){
                    apps.ux2++
                }else{
                    apps.ux2=0
                }
            }
            if(app.zoomStatus===2){
                if(apps.ux3<apps.sections-1){
                    apps.ux3++
                }else{
                    apps.ux3=0
                }
            }
            xGrid.toRight()
        }
    }
    Shortcut{
        sequence: 'Left'
        onActivated: {
            if(xGrid.opacity===0.0){
                xGrid.opacity=1.0
                return
            }
            if(app.zoomStatus===0){
                if(apps.ux1>0){
                    apps.ux1--
                }else{
                    apps.ux1=apps.sections-1
                }
            }
            if(app.zoomStatus===1){
                if(apps.ux2>0){
                    apps.ux2--
                }else{
                    apps.ux2=apps.sections-1
                }
            }
            if(app.zoomStatus===2){
                if(apps.ux3>0){
                    apps.ux3--
                }else{
                    apps.ux3=apps.sections-1
                }
            }
            xGrid.toLeft()
        }
    }
    Shortcut{
        sequence: 'Up'
        onActivated: {
            if(xGrid.opacity===0.0){
                xGrid.opacity=1.0
                return
            }
            if(app.zoomStatus===0){
                if(apps.uy1>0){
                    apps.uy1--
                }else{
                    apps.uy1=apps.sections-1
                }
            }
            if(app.zoomStatus===1){
                if(apps.uy2>0){
                    apps.uy2--
                }else{
                    apps.uy2=apps.sections-1
                }
            }
            if(app.zoomStatus===2){
                if(apps.uy3>0){
                    apps.uy3--
                }else{
                    apps.uy3=apps.sections-1
                }
            }
            xGrid.toUp()
        }
    }
    Shortcut{
        sequence: 'Down'
        onActivated: {
            if(xGrid.opacity===0.0){
                xGrid.opacity=1.0
                return
            }
            if(app.zoomStatus===0){
                if(apps.uy1<apps.sections-1){
                    apps.uy1++
                }else{
                    apps.uy1=0
                }
            }
            if(app.zoomStatus===1){
                if(apps.uy2<apps.sections-1){
                    apps.uy2++
                }else{
                    apps.uy2=0
                }
            }
            if(app.zoomStatus===2){
                if(apps.uy3<apps.sections-1){
                    apps.uy3++
                }else{
                    apps.uy3=0
                }
            }
            xGrid.toDown()
        }
    }
    Shortcut{
        sequence: 'Return'
        onActivated: {
            xGrid.toSelect()
            /*if(app.zoomStatus===0){
                xGrid2.x=xApp.width/apps.sections*apps.ux1
                xGrid2.y=xApp.height/apps.sections*apps.uy1
                xGrid2.sections=apps.sections
                xGrid2.cellWidth=xGrid.cellWidth/apps.sections
                xGrid2.cellHeight=xGrid.cellHeight/apps.sections
                app.zoomStatus=1
                return
            }
            if(app.zoomStatus===1){
                xGridMicro.x=xGrid2.x+xGrid2.cellWidth/xGrid2.sections*xGrid2.cx
                xGridMicro.y=xGrid2.y+xGrid2.cellHeight/xGrid2.sections*xGrid2.cy
                xGridMicro.cellWidth=xGrid2.cellWidth/xGridMicro.sections
                xGridMicro.cellHeight=xGrid2.cellHeight/xGridMicro.sections
                app.zoomStatus=2
                return
            }
            if(xGrid.opacity===0.0){
                xGrid.opacity=1.0
                return
            }*/
        }
    }
}
