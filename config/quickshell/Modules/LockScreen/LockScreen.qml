import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets
import qs.Components
import qs.Services
import qs.Themes

Item {
    id: root
    required property LockContext context
    property bool isLocked: false

    Process { id: restartProcess; command: ["systemctl", "reboot"] }
    Process { id: shutdownProcess; command: ["systemctl", "poweroff"] }
    Process { id: killLock; command: ["qs", "kill"] }


    Rectangle {
        anchors.fill: parent
        color: Theme.colBg

        Image {
            id: wallpaper
            anchors.fill: parent
            source: Theme.wallpaperPath
            mipmap: true
            asynchronous: true
            fillMode: Image.PreserveAspectCrop
        }

        MultiEffect {
            anchors.fill: wallpaper
            source: wallpaper
            brightness: -0.1
            contrast: -0.1
        }

        MultiEffect {
            anchors.fill: dialogContainer
            source: dialogContainer
            shadowEnabled: true
            shadowBlur: 0.4
            shadowColor: Theme.colAccent
            shadowVerticalOffset: 1
            shadowHorizontalOffset: 1
        }

        Rectangle {
            id: dialogContainer
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 150
            anchors.horizontalCenter: parent.horizontalCenter
            width: 440
            height: 340
            color: Theme.colBg
            border.color: root.context.showFailure ? "#ff5555" : Theme.colAccent
            border.width: Config.data.borderSize
            radius: Config.data.rounding 

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 30
                spacing: 18

                Clock {
                    id: lockScreenClock
                    Layout.alignment: Qt.AlignHCenter
                    textSize: 40
                    orientation: "horizontal"
                }

                StyledInput {
                    id: passwordBox
                    Layout.fillWidth: true
                    Layout.preferredHeight: 45
                    Layout.alignment: Qt.AlignHCenter
                    echoMode: TextInput.Password
                    placeholderText: root.context.showFailure ? "Invalid Password" : "Enter Password"
                    placeholderTextColor: root.context.showFailure ? "#ff5555" : Theme.colMuted
                    focus: root.isLocked
                    font.pointSize: 13
                    enabled: !root.context.unlockInProgress
                    inputMethodHints: Qt.ImhSensitiveData

                    onTextChanged: root.context.currentText = this.text
                    onAccepted: root.context.tryUnlock()

                    Connections {
                        target: root.context

                        function onCurrentTextChanged() {
                            if (passwordBox.text !== root.context.currentText) {
                                passwordBox.text = root.context.currentText
                            }
                        }
                    }
                }

                StyledButton {
                    id: unlockButton
                    text: "Unlock"
                    icon: "󰌾"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.leftMargin: 40
                    Layout.rightMargin: 40
                    Layout.alignment: Qt.AlignHCenter

                    enabled: !root.context.unlockInProgress && root.context.currentText !== ""
                    onClicked: root.context.tryUnlock()
                }

                DividerLine {
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 12

                    StyledButton {
                        text: "Restart"
                        icon: "󰜉"
                        Layout.fillWidth: true
                        Layout.preferredHeight: 40
                        onClicked: restartProcess.startDetached()
                    }

                    StyledButton {
                        text: "Shutdown"
                        icon: "󰐥"
                        Layout.fillWidth: true
                        Layout.preferredHeight: 40
                        onClicked: shutdownProcess.startDetached()
                    }
                }
            }
        }
    }
}
