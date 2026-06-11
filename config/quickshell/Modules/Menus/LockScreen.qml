import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Services.Pam
import Quickshell.Wayland
import Quickshell.Widgets
import qs.Components
import qs.Themes

Item {
    id: root

    property bool isLocked: false
    property string pendingPassword: ""

    IpcHandler {
        target: "lockscreen"

        function lock(): void {
            root.isLocked = true
        }
    }

    PamContext {
        id: pam

        onCompleted: (result) => {
            if (result === PamResult.Success) {
                root.isLocked = false
                root.pendingPassword = ""
            } else {
                root.pendingPassword = ""
                passwordIn.text = ""
                passwordIn.forceActiveFocus()
            }
        }

        onResponseRequiredChanged: {
            if (responseRequired && root.pendingPassword !== "") {
                pam.respond(root.pendingPassword)
            }
        }
    }

    Process { id: restartProcess; command: ["systemctl", "reboot"] }
    Process { id: shutdownProcess; command: ["systemctl", "poweroff"] }

    WlSessionLock {
        id: lock
        locked: root.isLocked

        WlSessionLockSurface {
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
                    border.color: Theme.colAccent
                    border.width: 1
                    radius: 5

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 30
                        spacing: 18

                        StyledInput {
                            id: passwordIn
                            Layout.fillWidth: true
                            Layout.preferredHeight: 45
                            Layout.alignment: Qt.AlignHCenter
                            echoMode: TextInput.Password
                            placeholderText: "Enter Password"
                            placeholderTextColor: Theme.colMuted
                            focus: false
                            font.pointSize: 13
                            color: Theme.colAccent
                            
                            onAccepted: unlockButton.unlock()
                        }

                        StyledButton {
                            id: unlockButton
                            text: "Unlock"
                            icon: "󰌾"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            Layout.alignment: Qt.AlignHCenter

                            function unlock() {
                                if (passwordIn.text === "") return

                                root.pendingPassword = passwordIn.text

                                if (!pam.active) {
                                    pam.start()
                                } else if (pam.responseRequired) {
                                    pam.respond(root.pendingPassword)
                                }
                            }

                            onClicked: unlockButton.unlock()
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
    }
}
