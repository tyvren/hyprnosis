import QtQuick
import Quickshell.Io
import qs.Components
import qs.Modules.OSD
import qs.Themes
import qs.Services

Item {
    id: audiobutton
    implicitWidth: button.implicitWidth
    implicitHeight: button.implicitHeight

    BarButton {
        id: button
        icon: {
            if (Audio.sinkMuted) return ""
            if (Audio.sinkVolume < 0.25) return ""
            if (Audio.sinkVolume < 0.50) return ""
            return ""
        }
        
        onClicked: {
            let contentParent = audiobutton.parent
            if (contentParent) {
                for (let i = 0; i < contentParent.children.length; i++) {
                    let sibling = contentParent.children[i]
                    if (sibling.toString().includes("VolumeOSD")) {
                        sibling.requestShow(4000)
                        break
                    }
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.RightButton
            
            onClicked: (mouse) => {
                if (mouse.button === Qt.RightButton) {
                    Audio.toggleSinkMute()
                }
            }
        }
    }
}
