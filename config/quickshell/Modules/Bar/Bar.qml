import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland
import qs.Components
import qs.Modules.Menus
import qs.Modules.OSD
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
                    width: topBar.width
                    height: topBar.height
                    anchors.fill: parent

                    ShapePath {
                        strokeWidth: 1
                        strokeColor: Theme.colAccent
                        fillColor: Theme.colBg
                        startX: -5
                        PathLine { x: 0; y: topBar.height }
                        PathLine { x: (topBar.width / 2) - 290; y: topBar.height }
                        PathLine { x: (topBar.width / 2) - 250; y: 0 }
                        PathLine { x: -5; y: 0 }
                    }

                    ShapePath {
                        strokeWidth: 1
                        strokeColor: Theme.colAccent
                        fillColor: Theme.colBg
                        startX: (topBar.width / 2) + 250
                        PathLine { x: (topBar.width / 2) + 290; y: topBar.height }
                        PathLine { x: topBar.width + 5; y: topBar.height }
                        PathLine { x: topBar.width + 5; y: 0 }
                        PathLine { x: (topBar.width / 2) + 250; y: 0 }
                    }
                }

                Rectangle {
                    id: topBarRect
                    color: "transparent"
                    anchors.fill: parent
                }

                Item {
                    id: topBarContent
                    anchors.fill: parent

                    BarMediaPlayer {
                        id: barMedia
                        anchors.top: parent.top
                        anchors.topMargin: 2
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    NotificationOSD {
                        id: notificationOSD
                        anchors.top: parent.top
                        anchors.topMargin: 2
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    VolumeOSD {
                        id: volumeOSD
                        anchors.top: parent.top
                        anchors.topMargin: 2
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Clock {
                        id: clockButtonTop
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        
                        MouseArea {
                            id: clockAreaTop
                            anchors.fill: clockButtonTop
                        }
                    }

                    MainMenuBtn {
                        id: mainMenuButtonTop
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter

                        BarButton {
                            icon: "    "
                            onClicked: quickMenuLoader.item.visible = !quickMenuLoader.item.visible 
                            onEntered: spinAnimTop.start()
                        }

                        RotationAnimation on rotation {
                            id: spinAnimTop
                            running: false
                            loops: 1
                            from: 0
                            to: -360
                            duration: 6000
                        }
                    }

                    LazyLoader {
                        id: quickMenuLoader
                        loading: true

                        QuickMenu {
                            id: quickMenu
                            anchors {
                              top: true
                              left: true
                            }

                            margins {
                              top: 5
                              left: 5
                            }
                        }
                    }

                    Workspaces {
                        id: workspacesButtonTop
                        anchors.left: parent.left
                        anchors.leftMargin: 80
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    SysMon {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 280
                    }

                    BatteryBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 220 
                    }

                    AudioBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 185
                    }

                    BluetoothBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 155
                    }

                    NetworkBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 120
                    }

                    SidePaneBtn {
                       anchors.right: parent.right
                       anchors.verticalCenter: parent.verticalCenter
                       anchors.rightMargin: 90
                    }
                }
            } 

            PanelWindow {
                id: bottomBar
                color: "transparent"
                visible: Config.data.barLayout === "bottom"
                implicitHeight: 30
                anchors {
                    bottom: true
                    left: true
                    right: true
                }

                Shape {
                    width: bottomBar.width
                    height: bottomBar.height
                    anchors.fill: parent

                    ShapePath {
                        strokeWidth: 1
                        strokeColor: Theme.colAccent
                        fillColor: Theme.colBg
                        startX: -5
                        PathLine { x: 0; y: bottomBar.height }
                        PathLine { x: (bottomBar.width / 2) - 250; y: bottomBar.height }
                        PathLine { x: (bottomBar.width / 2) - 290; y: 0 }
                        PathLine { x: -5; y: 0 }
                    }

                    ShapePath {
                        strokeWidth: 1
                        strokeColor: Theme.colAccent
                        fillColor: Theme.colBg
                        startX: (bottomBar.width / 2) + 290
                        PathLine { x: (bottomBar.width / 2) + 250; y: bottomBar.height }
                        PathLine { x: bottomBar.width + 5; y: bottomBar.height }
                        PathLine { x: bottomBar.width + 5; y: 0 }
                        PathLine { x: (bottomBar.width / 2) + 290; y: 0 }
                    }
                }

                Rectangle {
                    id: bottomBarRect
                    color: "transparent"
                    anchors.fill: parent
                }

                Item {
                    id: bottomBarContent
                    anchors.fill: parent

                    BarMediaPlayer {
                        id: barMediaBottom
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 2
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    NotificationOSD {
                        id: notificationOSDBottom
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 2
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    VolumeOSD {
                        id: volumeOSDBottom
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 2
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Clock {
                        id: clockButtonBottom
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 10

                        MouseArea {
                            id: clockAreaBottom
                            anchors.fill: clockButtonBottom
                        }
                    }

                    MainMenuBtn {
                        id: mainMenuButtonBottom
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter

                        BarButton {
                            icon: "    "
                            onClicked: quickMenuLoaderBottom.item.visible = !quickMenuLoaderBottom.item.visible 
                            onEntered: spinAnimBottom.start()
                        }

                        RotationAnimation on rotation {
                            id: spinAnimBottom
                            running: false
                            loops: 1
                            from: 0
                            to: -360
                            duration: 6000
                        }
                    }

                    LazyLoader {
                        id: quickMenuLoaderBottom
                        loading: true

                        QuickMenu {
                            id: quickMenuBottom
                            anchors {
                              bottom: true
                              left: true
                            }

                            margins {
                              top: 5
                              left: 5
                            }
                        }
                    }

                    Workspaces {
                        id: workspacesButtonBottom
                        anchors.left: parent.left
                        anchors.leftMargin: 80
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    SysMon {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 280
                    }

                    BatteryBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 220
                    }

                    AudioBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 185
                    }

                    BluetoothBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 155
                    }

                    NetworkBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 120
                    }

                    SidePaneBtn {
                       anchors.right: parent.right
                       anchors.verticalCenter: parent.verticalCenter
                       anchors.rightMargin: 90
                    }
                }
            }
        }
    }
}
