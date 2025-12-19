import QtQuick
import Quickshell.Io
import QtQuick.Effects

Item {
    id: menubutton
    implicitWidth: icon.implicitWidth
    implicitHeight: icon.implicitHeight
    anchors.verticalCenter: parent.verticalCenter

    Text {
        id: icon
        text: ""
        font.family: theme.fontFamily
        font.pixelSize: theme.fontSize
        color: theme.colAccent
        layer.enabled: true
        visible: false
    }

    MultiEffect {
        anchors.fill: parent
        source: icon
        shadowEnabled: true
        shadowBlur: 1
        shadowOpacity: 0.50
    }

    Process {
        id: openMenu
        command: ["sh", "-c", "qs ipc call mainmenu toggle"]
    }

    MouseArea {
        anchors.fill: parent
        onClicked: openMenu.startDetached()
    }
}
