import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import qs.Components
import qs.Themes

PanelWindow {
    id: coreH
    anchors {
        top: true
    }
    color: "transparent"
    implicitWidth: 240
    implicitHeight: 110
    exclusionMode: ExclusionMode.Ignore 
    
    mask: Region { 
        item: interactiveContentH
    }

    property bool open: false
    property bool showButtons: false

    Item {
        id: interactiveContentH
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height
        width: coreH.open ? parent.width : 30

        RectangularShadow {
            id: coreAreaShadowH
            anchors.fill: coreAreaH
            color: Theme.colAccent
            height: coreAreaH.height
            width: coreAreaH.width
            radius: 150
            blur: 5
            spread: 1
        }

        Rectangle {
            id: coreAreaH
            color: Theme.colBg
            border.color: Theme.colAccent
            border.width: 1
            anchors.horizontalCenter: parent.horizontalCenter
            y: -52
            width: 80
            height: 80
            radius: 150
            scale: 1

            RotationAnimation on rotation {
                id: spinAnimH
                running: false
                loops: 1
                from: 0
                to: -360
                duration: 6000
            }

            RotationAnimation on rotation {
                id: infiniteSpinAnimH
                running: false
                loops: Animation.Infinite
                from: 0
                to: -360
                duration: 6000
            }

            Image {
                id: logoH
                anchors.fill: coreAreaH
                source: Theme.logoPath
                mipmap: true
                asynchronous: true
                fillMode: Image.PreserveAspectFit
            }

            MouseArea {
                id: coreAreaMouseH
                anchors.fill: coreAreaH
                hoverEnabled: true
                onEntered: {
                    if (!coreH.open) {
                        spinAnimH.start()
                    }
                }
                onClicked: {
                    coreH.open = !coreH.open
                }
            }

            states: [
                State {
                    name: "closed"
                    when: !coreH.open
                    PropertyChanges {
                        target: coreAreaH
                        scale: 1
                    }
                },
                State {
                    name: "open"
                    when: coreH.open
                    PropertyChanges {
                        target: coreAreaH
                        scale: 3
                    }
                }
            ]

            transitions: [
                Transition {
                    from: "closed"
                    to: "open"
                    SequentialAnimation {
                        ScriptAction {
                            script: { 
                                infiniteSpinAnimH.start()
                            }
                        }
                        NumberAnimation {
                            properties: "scale"
                            duration: 400
                            easing.type: Easing.OutCubic
                        }
                        ScriptAction {
                            script: {
                                coreH.showButtons = true
                            }
                        }
                    }
                },
                Transition {
                    from: "open"
                    to: "closed"
                    SequentialAnimation {
                        ScriptAction {
                            script: {
                                infiniteSpinAnimH.stop()
                                spinAnimH.start()
                                coreH.showButtons = false
                            }
                        }
                        NumberAnimation {
                            properties: "scale"
                            duration: 400
                            easing.type: Easing.OutCubic
                        }
                    }
                }
            ]
        }

        Loader {
            id: buttonLoaderH
            active: coreH.showButtons
            anchors.fill: parent
            sourceComponent: Component {
                Item {
                    id: buttonsH
                    property bool ready: false
                    Component.onCompleted: ready = true

                    StyledButton {
                        id: appsButtonH
                        anchors.top: parent.top
                        anchors.topMargin: 2
                        anchors.right: parent.right
                        anchors.rightMargin: 15
                        text: ""
                        onClicked: {
                            coreH.open = false
                            appsProcessH.startDetached()
                        }
                        opacity: (buttonsH.ready && coreH.open && coreAreaH.scale === 3) ? 1 : 0
                        Behavior on opacity {
                            NumberAnimation { duration: 250 }
                        }
                    }

                    StyledButton {
                        id: lockButtonH
                        anchors.top: parent.top
                        anchors.topMargin: 40
                        anchors.left: parent.left
                        anchors.leftMargin: 50
                        text: ""
                        onClicked: {
                            coreH.open = false
                            lockProcessH.startDetached()
                        }
                        opacity: (buttonsH.ready && coreH.open && coreAreaH.scale === 3) ? 1 : 0
                        Behavior on opacity {
                            NumberAnimation { duration: 250 }
                        }
                    }

                    StyledButton {
                        id: shutdownButtonH
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: ""
                        onClicked: {
                            coreH.open = false
                            shutdownProcessH.startDetached()
                        }
                        opacity: (buttonsH.ready && coreH.open && coreAreaH.scale === 3) ? 1 : 0
                        Behavior on opacity {
                            NumberAnimation { duration: 250 }
                        }
                    }

                    StyledButton {
                        id: restartButtonH
                        anchors.top: parent.top
                        anchors.topMargin: 40
                        anchors.right: parent.right
                        anchors.rightMargin: 50
                        text: ""
                        onClicked: { 
                            coreH.open = false
                            restartProcessH.startDetached()
                        }
                        opacity: (buttonsH.ready && coreH.open && coreAreaH.scale === 3) ? 1 : 0
                        Behavior on opacity {
                            NumberAnimation { duration: 250 }
                        }
                    }

                    StyledButton {
                        id: settingsButtonH
                        anchors.top: parent.top
                        anchors.topMargin: 2
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        text: "󰍜"
                        onClicked: {
                            coreH.open = false
                            settingsProcessH.startDetached()
                        }
                        opacity: (buttonsH.ready && coreH.open && coreAreaH.scale === 3) ? 1 : 0
                        Behavior on opacity {
                            NumberAnimation { duration: 250 }
                        }
                    }
                
                    Process { id: appsProcessH; command: ["sh", "-c", "qs ipc call launcher-menu toggle"]}
                    Process { id: lockProcessH; command: ["hyprlock"] }
                    Process { id: restartProcessH; command: ["systemctl", "reboot"] }
                    Process { id: shutdownProcessH; command: ["systemctl", "poweroff"] }
                    Process { id: settingsProcessH; command: ["sh", "-c", "qs ipc call settingsMenu toggle"]}
                }
            }
        }
    }
}
