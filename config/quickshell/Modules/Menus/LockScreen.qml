import QtQuick
import QtQuick.Controls
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

                Rectangle {
                    anchors.centerIn: parent
                    width: 450
                    height: 450
                    color: Theme.colBg
                    border.color: Theme.colAccent
                    radius: 15

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 40
                        spacing: 15

                        StyledInput {
                            id: passwordIn
                            Layout.preferredWidth: 340
                            Layout.preferredHeight: 60
                            Layout.alignment: Qt.AlignHCenter
                            echoMode: TextInput.Password
                            placeholderText: "Enter Password"
                            placeholderTextColor: Theme.colMuted
                            focus: false
                            font.pointSize: 16
                            color: Theme.colAccent
                            
                            onAccepted: unlockButton.unlock()
                        }

                        StyledButton {
                            id: unlockButton
                            text: "Unlock"
                            icon: "󰌾"
                            Layout.preferredWidth: 180
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
                            Layout.preferredWidth: 320
                            Layout.alignment: Qt.AlignHCenter
                        }

                        RowLayout {
                            Layout.alignment: Qt.AlignHCenter
                            spacing: 15

                            StyledButton {
                                text: "Restart"
                                icon: "󰜉"
                                Layout.preferredWidth: 180
                                Layout.preferredHeight: 40
                                onClicked: restartProcess.startDetached()
                            }

                            StyledButton {
                                text: "Shutdown"
                                icon: "󰐥"
                                Layout.preferredWidth: 180
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
