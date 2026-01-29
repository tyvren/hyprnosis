import QtQuick
import QtQuick.Controls
import qs.Themes

Switch {
    id: control
    indicator: Rectangle {
        implicitWidth: 44 
        implicitHeight: 22 
        radius: 11 
        color: control.checked ? Theme.colAccent : Theme.colMuted 
        opacity: control.checked ? 1.0 : 0.5

        Rectangle {
            x: control.checked ? parent.width - width - 2 : 2 
            y: 2 
            width: 18 
            height: 18 
            radius: 9
            color: control.checked ? Theme.colBg : Theme.colAccent

            Behavior on x { 
                NumberAnimation { 
                    duration: 150 
                    easing.type: Easing.OutQuad 
                } 
            }
        }
    }
}
