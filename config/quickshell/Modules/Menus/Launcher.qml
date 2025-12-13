import QtQuick.Controls.Basic
import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland
import "../.."

PanelWindow {
    id: launcherMenu
    visible: false
    focusable: true
    color: "transparent"
    WlrLayershell.layer: WlrLayer.Top
    property var theme: Theme {}
    property string query: ""
    property var filteredApps: DesktopEntries.applications.values

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    onQueryChanged: {
        if (query === "") {
            filteredApps = DesktopEntries.applications.values
        } else {
            filteredApps = DesktopEntries.applications.values.filter(app => app.name.toLowerCase().includes(query.toLowerCase()))
        }
    }

    IpcHandler {
        target: "launcher-menu"

        function toggle(): void {
            launcherMenu.visible = !launcherMenu.visible
            if (launcherMenu.visible) launcherMenu.forceActiveFocus()
        }

        function hide(): void {
            launcherMenu.visible = false
        }
    }

    Rectangle {
        focus: true
        anchors.centerIn: parent
        width: 400
        height: 500
        radius: 10
        color: theme.colBg
        border.width: 2
        border.color: theme.colAccent

        Keys.onEscapePressed: launcherMenu.visible = false

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 12

            Rectangle {
                width: parent.width
                height: 40
                radius: 8
                color: theme.colSelect

                TextField {
                    anchors.fill: parent
                    placeholderText: "Search apps..."
                    color: theme.colAccent
                    font.family: theme.fontFamily
                    font.pixelSize: 16

                    onTextChanged: launcherMenu.query = text
                }
            }

            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: launcherMenu.filteredApps
                orientation: ListView.Vertical
                spacing: 6
                clip: true

                delegate: Rectangle {
                    width: parent.width
                    height: 50
                    radius: 8
                    color: mouseArea.containsMouse ? theme.colSelect : theme.colBg
                    border.width: 2
                    border.color: theme.colAccent

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 12
                        text: modelData.name
                        color: theme.colAccent
                        font.family: theme.fontFamily
                        font.pixelSize: 16
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                           command: ["sh", "-c", modelData.execute()]
                            launcherMenu.visible = false
                        }
                    }
                }
            }
        }
    }
}

