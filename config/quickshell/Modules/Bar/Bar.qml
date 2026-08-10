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
                implicitHeight: 32
                anchors {
                    top: true
                    left: true
                    right: true
                  }

                Rectangle {
                    id: topLeftBar
                    width: topBar.width / 2 - 250
                    height: topBar.height - 2
                    radius: Config.data.rounding
                    color: Theme.colBg
                    border.color: Theme.colAccent
                }
                
                Rectangle {
                    id: topRightBar
                    x: topBar.width / 2 + 250
                    width: topBar.width / 2 - 250
                    height: topBar.height - 2
                    radius: Config.data.rounding
                    color: Theme.colBg
                    border.color: Theme.colAccent
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

                    TimeDateOSD {
                        id: timeDate
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

                    BatteryBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 130
                    }

                    AudioBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 100
                    }

                    BluetoothBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 70
                    }

                    NetworkBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 40
                    }

                    SidePaneBtn {
                       anchors.right: parent.right
                       anchors.verticalCenter: parent.verticalCenter
                       anchors.rightMargin: 10
                    }
                }
            } 

            PanelWindow {
                id: bottomBar
                color: "transparent"
                visible: Config.data.barLayout === "bottom"
                implicitHeight: 32
                anchors {
                    bottom: true
                    left: true
                    right: true
                }

                Rectangle {
                    id: bottomLeftBar
                    anchors.topMargin: 2
                    anchors.bottomMargin: 2
                    width: bottomBar.width / 2 - 250
                    height: bottomBar.height - 2
                    radius: Config.data.rounding
                    color: Theme.colBg
                    border.color: Theme.colAccent
                }

                Rectangle {
                    id: bottomRightBar
                    anchors.topMargin: 2
                    anchors.bottomMargin: 2
                    x: bottomBar.width / 2 + 250
                    width: bottomBar.width / 2 - 250
                    height: bottomBar.height - 2
                    radius: Config.data.rounding
                    color: Theme.colBg
                    border.color: Theme.colAccent
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
                    
                    TimeDateOSD {
                        id: timeDateBottom
                        anchors.top: parent.top
                        anchors.bottomMargin: 2
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    VolumeOSD {
                        id: volumeOSDBottom
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 2
                        anchors.horizontalCenter: parent.horizontalCenter
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

                    BatteryBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 130
                    }

                    AudioBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 100
                    }

                    BluetoothBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 70
                    }

                    NetworkBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 40
                    }

                    SidePaneBtn {
                       anchors.right: parent.right
                       anchors.verticalCenter: parent.verticalCenter
                       anchors.rightMargin: 10
                    }
                }
            }
        }
    }
}
