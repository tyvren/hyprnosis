import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland
import qs.Components
import qs.Themes
import qs.Services

Variants {
    model: Quickshell.screens
    delegate: Component {
        Item {
            id: root
            required property var modelData

            PanelWindow {
                id: topBar
                color: "transparent"
                visible: Config.data.barLayout === "top"
                implicitHeight: 30
                anchors {
                    top: true
                    left: true
                    right: true
                }

                Shape {
                    id: topBarShape
                    anchors.fill: parent
                    layer.enabled: true
                    layer.samples: 5

                    ShapePath {
                        strokeWidth: 2
                        strokeColor: "transparent"
                        fillColor: Theme.colBg

                        startX: 0
                        startY: 0

                        PathCubic {
                            x: 50
                            y: 28
                            control1X: 30
                            control1Y: 5
                            control2X: 35
                            control2Y: 28
                        }
                        PathLine {
                            x: topBar.width - 50
                            y: 28
                        }
                        PathCubic {
                            x: topBar.width
                            y: 0
                            control1X: topBar.width - 35
                            control1Y: 28
                            control2X: topBar.width - 30
                            control2Y: 5
                        }
                        PathLine {
                            x: topBar.width
                            y: 0
                        }
                    }
                }

                MultiEffect {
                    id: topBarShadow
                    anchors.fill: topBarShape
                    source: topBarShape
                    shadowEnabled: true
                    shadowColor: Theme.colAccent
                    shadowBlur: 0.2
                    shadowHorizontalOffset: 0
                    shadowVerticalOffset: 1
                }

                Item {
                    id: topBarContent
                    anchors.fill: parent

                    Calendar {
                        id: topCalendar
                        visible: clockAreaTop.containsMouse
                    }

                    ClockH {
                        id: clockButtonTop
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 450

                        MouseArea {
                            id: clockAreaTop
                            anchors.fill: clockButtonTop
                            hoverEnabled: true
                        }
                    }

                    WorkspacesH {
                        id: workspacesButtonTop
                        anchors.left: parent.left
                        anchors.leftMargin: 450
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    BatteryBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 175
                    }
                    AudioBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 145
                    }
                    BluetoothBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 115
                    }
                    NetworkBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 80
                    }
                    NotificationBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 50
                    }
                }
            }

            PanelWindow {
                id: leftBar
                color: "transparent"
                visible: Config.data.barLayout === "side"
                implicitWidth: 30
                anchors {
                    left: true
                    top: true
                    bottom: true
                } 

                Media {
                    id: mediaPlayer
                    anchor.window: leftBar
                    anchor.rect.x: 35
                    anchor.rect.y: 10
                    color: "transparent"
                }

                Shape {
                    id: leftBarShape
                    anchors.fill: parent
                    layer.enabled: true
                    layer.samples: 5

                    ShapePath {
                        strokeWidth: 2
                        strokeColor: "transparent"
                        fillColor: Theme.colBg

                        startX: 0
                        startY: 0

                        PathCubic {
                            x: 28
                            y: 50
                            control1X: 5
                            control1Y: 30
                            control2X: 28
                            control2Y: 35
                        }
                        PathLine {
                            x: 28
                            y: leftBar.height - 50
                        }
                        PathCubic {
                            x: 0
                            y: leftBar.height
                            control1X: 28
                            control1Y: leftBar.height - 35
                            control2X: 5
                            control2Y: leftBar.height - 30
                        }
                        PathLine {
                            x: 0
                            y: 0
                        }
                    }
                }

                MultiEffect {
                    id: leftBarShadow
                    anchors.fill: leftBarShape
                    source: leftBarShape
                    shadowEnabled: true
                    shadowColor: Theme.colAccent
                    shadowBlur: 0.2
                    shadowHorizontalOffset: 1
                    shadowVerticalOffset: 0
                }

                Item {
                    id: leftBarContent
                    anchors.fill: parent

                    Rectangle {
                        id: mediaBtn
                        anchors.top: leftBarContent.top
                        anchors.topMargin: 50
                        anchors.left: leftBarContent.left
                        anchors.leftMargin: 2
                        width: 25
                        height: 25
                        color: "transparent"
                        radius: 50
                        visible: Players.active

                        Image {
                            id: activeLogo
                            anchors.fill: mediaBtn
                            source: Theme.logoPath
                            mipmap: true
                            asynchronous: true
                            opacity: 0.5
                            fillMode: Image.PreserveAspectFit

                            RotationAnimation on rotation {
                                id: infiniteSpinAnim
                                running: true
                                loops: Animation.Infinite
                                from: 0
                                to: 360
                                duration: 6000
                            }
                        }

                        Item {
                            id: textContainer
                            anchors.fill: mediaBtn

                            Text {
                                id: musicIcon
                                anchors.left: textContainer.left
                                anchors.leftMargin: 3
                                color: Theme.colAccent
                                font.bold: true
                                font.family: Theme.fontFamily
                                font.pointSize: 16
                                text: ""
                                visible: false
                            }

                            BtnTextShadow {
                                anchors.fill: musicIcon 
                                source: musicIcon
                            }
                        }

                        MouseArea {
                            id: mediaBtnArea
                            anchors.fill: mediaBtn
                            hoverEnabled: true
                            onEntered: {
                                if (!mediaPlayer.open) {
                                    mediaPlayer.visible = true 
                                } else {
                                    mediaPlayer.open = false
                                }
                            }
                        }
                    }
                }
            }

            PanelWindow {
                id: rightBar
                color: "transparent"
                visible: Config.data.barLayout === "side"
                implicitWidth: 30
                anchors {
                    right: true
                    top: true
                    bottom: true
                }

                Shape {
                    id: rightBarShape
                    anchors.fill: parent
                    layer.enabled: true
                    layer.samples: 5

                    ShapePath {
                        strokeWidth: 2
                        strokeColor: "transparent"
                        fillColor: Theme.colBg

                        startX: rightBar.width
                        startY: 0

                        PathCubic {
                            x: rightBar.width - 28
                            y: 50
                            control1X: rightBar.width - 5
                            control1Y: 30
                            control2X: rightBar.width - 28
                            control2Y: 35
                        }
                        PathLine {
                            x: rightBar.width - 28
                            y: rightBar.height - 50
                        }
                        PathCubic {
                            x: rightBar.width
                            y: rightBar.height
                            control1X: rightBar.width - 28
                            control1Y: rightBar.height - 35
                            control2X: rightBar.width - 5
                            control2Y: rightBar.height - 30
                        }
                        PathLine {
                            x: rightBar.width
                            y: 0
                        }
                    }
                }

                MultiEffect {
                    id: rightBarShadow
                    anchors.fill: rightBarShape
                    source: rightBarShape
                    shadowEnabled: true
                    shadowColor: Theme.colAccent
                    shadowBlur: 0.2
                    shadowHorizontalOffset: -1
                    shadowVerticalOffset: 0
                }

                Item {
                    id: rightBarContent
                    anchors.fill: parent

                    Calendar {
                        id: calendar
                        visible: clockArea.containsMouse
                    }

                    Clock {
                        id: clockButton
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 50 

                        MouseArea {
                            id: clockArea
                            anchors.fill: clockButton
                            hoverEnabled: true
                        }
                    }

                    Workspaces {
                        id: workspacesButton
                        anchors.horizontalCenter: parent.horizontalCenter
                        y: parent.height / 2 - 65
                    }

                    BatteryBtn {
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottomMargin: 170
                    }
                    AudioBtn {
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottomMargin: 140
                    }
                    BluetoothBtn {
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottomMargin: 110
                    }
                    NetworkBtn {
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottomMargin: 80
                    }
                    NotificationBtn {
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottomMargin: 50
                    } 
                }
            }

            LazyLoader {
                active: Config.data.barLayout === "side"
                Core {}
            }

            LazyLoader {
                active: Config.data.barLayout === "top"
                CoreH {}
            }
        }
    }
}
