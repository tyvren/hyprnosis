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

    StyledText {
        text: "Updates"
        color: Theme.colAccent
        size: 16
    }

    DividerLine {
        Layout.fillWidth: true
    }

    ColumnLayout {
        spacing: 10
        Layout.fillWidth: true

        Repeater {
            model: [
                { name: "System", icon: "󰣇", isImage: false, message: " - update Arch repo packages using pacman -Syu", script: "update_system.sh" },
                { name: "AUR", icon: "󰣇", isImage: false, message: " - update AUR packages using yay -Syu", script: "update_aur.sh" },
                { name: "Hyprnosis", icon: Theme.logoPath, isImage: true, message: " - update Hyprnosis shell to the latest release", script: "update_hyprnosis.sh" }
            ]

            StyledButtonLeftText {
                id: btn
                Layout.fillWidth: true
                Layout.preferredHeight: 45
                
                icon: ""
                text: ""

                onClicked: {
                    proc.startDetached()
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 8
                    anchors.rightMargin: 14
                    spacing: 16

                    Item {
                        Layout.preferredWidth: 24
                        Layout.preferredHeight: 24
                        Layout.alignment: Qt.AlignVCenter

                        StyledText {
                            anchors.fill: parent
                            text: modelData.icon
                            size: 14
                            color: btn.active ? Theme.colAccent : Theme.colText
                            visible: !modelData.isImage
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        Image {
                            anchors.centerIn: parent
                            width: 18
                            height: 18
                            source: modelData.isImage ? modelData.icon : ""
                            visible: modelData.isImage
                            fillMode: Image.PreserveAspectFit
                            mipmap: true
                            asynchronous: true
                        }
                    }

                    RowLayout {
                        spacing: 4
                        Layout.alignment: Qt.AlignVCenter
                        Layout.fillWidth: true

                        StyledText {
                            text: "Update " + modelData.name
                            size: 12
                            color: btn.active ? Theme.colAccent : Theme.colText
                        }

                        StyledText {
                            text: modelData.message
                            size: 11
                            color: btn.active ? Theme.colAccent : Theme.colText
                            opacity: 0.4
                            Layout.fillWidth: true
                            elide: Text.ElideRight
                        }
                    }
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
