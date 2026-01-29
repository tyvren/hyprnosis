import QtQuick
import Quickshell.Io
import qs.Components
import qs.Themes

Item {
    id: audiobutton
    implicitWidth: button.implicitWidth
    implicitHeight: button.implicitHeight

    BarButton {
        id: button
        icon: ""
        onClicked: openAudio.startDetached()
    }

    Process {
        id: openAudio
        command: ["pavucontrol"]
    }
}
