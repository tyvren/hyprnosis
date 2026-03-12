import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.Components
import qs.Themes

PopupWindow {
    id: quickMenuRoot
    implicitWidth: 200
    implicitHeight: 200
    color: "transparent"

    Rectangle {
        id: container
        anchors.fill: parent
        radius: 15
        color: Theme.colBg
        border.color: Theme.colAccent
        opacity: quickMenuRoot.visible ? 1.0 : 0.0

        Behavior on opacity {
            NumberAnimation {
                duration: 300
            }
        }

        ColumnLayout {
            id: menuLayout
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            spacing: 0

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 25
                color: "transparent"
                border.color: settingsArea.containsMouse ? Theme.colAccent : "transparent"
                radius: 10
                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: "  Settings"
                    font.family: Theme.fontFamily
                    font.pointSize: 11
                    color: Theme.colAccent
                }
                MouseArea {
                    id: settingsArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        settingsProcess.startDetached()
                        quickMenuRoot.visible = false
                    }
                }
            }

            DividerLine {
                Layout.fillWidth: true
            }

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 25
                color: "transparent"
                border.color: lockArea.containsMouse ? Theme.colAccent : "transparent"
                radius: 10
                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: "󰌾  Lock"
                    font.family: Theme.fontFamily
                    font.pointSize: 11
                    color: Theme.colAccent
                }
                MouseArea {
                    id: lockArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        lockProcess.startDetached()
                        quickMenuRoot.visible = false
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 25
                color: "transparent"
                border.color: restartArea.containsMouse ? Theme.colAccent : "transparent"
                radius: 10
                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: "󰜉  Restart"
                    font.family: Theme.fontFamily
                    font.pointSize: 11
                    color: Theme.colAccent
                }
                MouseArea {
                    id: restartArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        restartProcess.startDetached()
                        quickMenuRoot.visible = false
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 25
                color: "transparent"
                border.color: shutdownArea.containsMouse ? Theme.colAccent : "transparent"
                radius: 10
                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: "󰐥  Shutdown"
                    font.family: Theme.fontFamily
                    font.pointSize: 11
                    color: Theme.colAccent
                }
                MouseArea {
                    id: shutdownArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        shutdownProcess.startDetached()
                        accessMenuRoot.visible = false
                    }
                }
            }
        }
    }

    Process { id: lockProcess; command: ["hyprlock"] }
    Process { id: restartProcess; command: ["systemctl", "reboot"] }
    Process { id: shutdownProcess; command: ["systemctl", "poweroff"] }
    Process { id: settingsProcess; command: ["sh", "-c", "qs ipc call settingsMenu toggle"] }
}
