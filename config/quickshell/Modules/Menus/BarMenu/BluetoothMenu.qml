import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.Components
import qs.Services
import qs.Modules.Menus.Settings
import qs.Themes

StyledPanelWindow {
    id: btMenuRoot
    visible: false
    open: false

    onOpenChanged: {
        if (open) {
            States.bluetoothOpen = true
        } else {
            States.bluetoothOpen = false
        }
    }

    Rectangle {
        id: contentPane
        anchors.fill: parent
        color: "transparent"

        anchors.topMargin: Config.data.barLayout === "top" ? 0 : 30
        anchors.bottomMargin: Config.data.barLayout === "bottom" ? 0 : 30

        LazyLoader {
            id: contentLoader
            active: btMenuRoot.open

            ColumnLayout {
                parent: contentPane
                anchors.fill: parent
                anchors.margins: 10

                BluetoothSettings {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }
        }
    }
}
