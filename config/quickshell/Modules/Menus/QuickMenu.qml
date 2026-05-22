import QtQuick 
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Widgets
import qs.Components
import qs.Themes

PopupWindow {
    id: quickMenuRoot
    implicitWidth: 200
    implicitHeight: 220
    color: "transparent"

    HyprlandFocusGrab {
        id: focusGrab
        windows: [quickMenuRoot]
        onCleared: quickMenuRoot.visible = false
    }

    onVisibleChanged: {
        if (visible) {
            focusGrab.active = true
        } else {
            focusGrab.active = false
        }
    }

    Rectangle {
        id: container
        anchors.fill: parent
        radius: 15
        color: Theme.colBg
        opacity: quickMenuRoot.visible ? 1.0 : 0.0
        focus: true

        Keys.onEscapePressed: quickMenuRoot.visible = false

        Behavior on opacity {
            NumberAnimation {
                duration: 300
            }
        }

        ColumnLayout {
            id: menuLayout
            anchors.fill: parent
            anchors.margins: 15
            spacing: 6

            StyledButton {
                text: "Settings"
                icon: ""
                Layout.fillWidth: true
                Layout.preferredHeight: 36
                onClicked: {
                    settingsProcess.startDetached()
                    quickMenuRoot.visible = false
                }
            }

            DividerLine {
                Layout.fillWidth: true
            }

            StyledButton {
                text: "Lock"
                icon: "󰌾"
                Layout.fillWidth: true
                Layout.preferredHeight: 36
                onClicked: {
                    lockProcess.startDetached()
                    quickMenuRoot.visible = false
                }
            }

            StyledButton {
                text: "Restart"
                icon: "󰜉"
                Layout.fillWidth: true
                Layout.preferredHeight: 36
                onClicked: {
                    restartProcess.startDetached()
                    quickMenuRoot.visible = false
                }
            }

            StyledButton {
                text: "Shutdown"
                icon: "󰐥"
                Layout.fillWidth: true
                Layout.preferredHeight: 36
                onClicked: {
                    shutdownProcess.startDetached()
                    quickMenuRoot.visible = false
                }
            }
        }
    }

    Process { id: lockProcess; command: ["sh", "-c", "qs ipc call lockscreen lock"] }
    Process { id: restartProcess; command: ["systemctl", "reboot"] }
    Process { id: shutdownProcess; command: ["systemctl", "poweroff"] }
    Process { id: settingsProcess; command: ["sh", "-c", "qs ipc call settingsMenu toggle"] }
}
