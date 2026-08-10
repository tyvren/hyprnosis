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
import qs.Services
import qs.Themes

Item {
    id: root

    property bool isLocked: false
    property string pendingPassword: ""
    property bool authFailed: false

    Timer {
        id: resetTimer
        interval: 400
        repeat: false
        onTriggered: {
            root.authFailed = false
            root.pendingPassword = ""
            passwordIn.text = ""
            passwordIn.forceActiveFocus()
        }
    }

    IpcHandler {
        target: "lockscreen"

        function lock(): void {
            root.isLocked = true
            root.authFailed = false
            resetTimer.stop()
        }
    }

    PamContext {
        id: pam

        onCompleted: (result) => {
            if (result === PamResult.Success) {
                resetTimer.stop()
                root.isLocked = false
                root.pendingPassword = ""
                root.authFailed = false
            } else {
                root.pendingPassword = ""
                root.authFailed = true
                resetTimer.restart()
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
                            id: passwordIn
                            Layout.fillWidth: true
                            Layout.preferredHeight: 45
                            Layout.alignment: Qt.AlignHCenter
                            echoMode: TextInput.Password
                            placeholderText: "Enter Password"
                            placeholderTextColor: Theme.colMuted
                            focus: false
                            font.pointSize: 13
                            color: root.authFailed ? Theme.colText : Theme.colAccent

                            Behavior on color {
                                ColorAnimation {
                                    duration: 250
                                    easing.type: Easing.InOutQuad
                                }
                            }

                            onTextChanged: {
                                if (!root.authFailed && resetTimer.running) {
                                    resetTimer.stop()
                                }
                            }
                            onAccepted: unlockButton.unlock()
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

                            function unlock() {
                                if (passwordIn.text === "" || resetTimer.running) return

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
