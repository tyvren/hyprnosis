import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.Components
import qs.Themes
import qs.Services

Item {
    id: root
    implicitWidth: 480
    implicitHeight: 28

    OSD {
        id: playerMain
        anchors.fill: parent
        active: States.timeDateOSDOpen

        Clock {
            id: clock
            anchors.centerIn: parent
            orientation: "horizontalFull" 
        }
    }
}
