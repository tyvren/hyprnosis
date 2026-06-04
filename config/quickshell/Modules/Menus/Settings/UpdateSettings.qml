import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Components
import qs.Themes

ColumnLayout {
    id: updatePane
    spacing: 10

    property string scriptDir: Quickshell.env("HOME") + "/.config/hyprnosis/modules/updates/"

    Text {
        text: "Updates"
        color: Theme.colAccent
        font.pointSize: 16
        font.family: Theme.fontFamily
    }

    DividerLine {
        Layout.fillWidth: true
    }

    ColumnLayout {
        spacing: 10
        Layout.fillWidth: true

        Repeater {
            model: [
                { name: "System", script: "update_system.sh" },
                { name: "AUR", script: "update_aur.sh" },
                { name: "Hyprnosis", script: "update_hyprnosis.sh" }
            ]

            StyledButton {
                Layout.fillWidth: true
                Layout.preferredHeight: 45
                text: "Update " + modelData.name

                onClicked: {
                    proc.startDetached()
                }

                Process {
                    id: proc
                    command: ["sh", "-c", "ghostty -e " + updatePane.scriptDir + modelData.script]
                }
            }
        }
    }

    Item { Layout.fillHeight: true }
}
