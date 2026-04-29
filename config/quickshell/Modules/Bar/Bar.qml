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

                Rectangle {
                    id: topBarRect
                    color: Theme.colBg
                    anchors.fill: parent
                    anchors.topMargin: 2
                    anchors.leftMargin: Config.data.barMargin
                    anchors.rightMargin: Config.data.barMargin
                    radius: Config.data.barRadius
                    border.color: Theme.colAccent
                }

                Item {
                    id: topBarContent
                    anchors.fill: parent
                    anchors.topMargin: 2.5

                    Clock {
                        id: clockButtonTop
                        anchors.centerIn: parent
                        MouseArea {
                            id: clockAreaTop
                            anchors.fill: clockButtonTop
                            onClicked: centerMenuLoader.item.visible = !centerMenuLoader.item.visible
                        }
                    }

                    LazyLoader {
                        id: centerMenuLoader
                        loading: true

                        CenterMenu {
                            id: topCenterMenu
                            anchor.window: topBar
                            anchor.rect.x: topBar.width / 2 - width / 2
                            anchor.rect.y: topBar.height + 10
                        }
                    }

                    MainMenuBtn {
                        id: mainMenuButtonTop
                        anchors.left: parent.left
                        anchors.leftMargin: 25
                        anchors.verticalCenter: parent.verticalCenter

                        BarButton {
                            icon: "   "
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
                            anchor.window: topBar
                            anchor.rect.x: 10
                            anchor.rect.y: 31
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
                        anchors.rightMargin: 235
                    }

                    SysMon {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 170
                    }

                    AudioBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 135
                    }

                    BluetoothBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 105
                    }

                    NetworkBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 65
                    }

                    SidePaneBtn {
                       anchors.right: parent.right
                       anchors.verticalCenter: parent.verticalCenter
                       anchors.rightMargin: 35
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

                Rectangle {
                    id: bottomBarRect
                    color: Theme.colBg
                    anchors.fill: parent
                    anchors.bottomMargin: 2
                    anchors.leftMargin: Config.data.barMargin
                    anchors.rightMargin: Config.data.barMargin
                    radius: Config.data.barRadius
                    border.color: Theme.colAccent
                }

                Item {
                    id: bottomBarContent
                    anchors.fill: parent
                    anchors.bottomMargin: 2.5

                    Clock {
                        id: clockButtonBottom
                        anchors.centerIn: parent
                        MouseArea {
                            id: clockAreaBottom
                            anchors.fill: clockButtonBottom
                            onClicked: centerMenuLoaderB.item.visible = !centerMenuLoaderB.item.visible
                        }
                    }

                    LazyLoader {
                        id: centerMenuLoaderB
                        loading: true

                        CenterMenu {
                            id: bottomCenterMenu
                            anchor.window: bottomBar
                            anchor.rect.x: bottomBar.width / 2 - width / 2
                            anchor.rect.y: -235
                        }
                    }

                    MainMenuBtn {
                        id: mainMenuButtonBottom
                        anchors.left: parent.left
                        anchors.leftMargin: 25
                        anchors.verticalCenter: parent.verticalCenter

                        BarButton {
                            icon: "   "
                            onClicked: quickMenuLoaderB.item.visible = !quickMenuLoaderB.item.visible 
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
                        id: quickMenuLoaderB
                        loading: true

                        QuickMenu {
                            anchor.window: bottomBar
                            anchor.rect.x: 10
                            anchor.rect.y: -201
                        }
                    }

                    Workspaces {
                        anchors.left: parent.left
                        anchors.leftMargin: 80
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    BatteryBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 225
                    }

                    SysMon {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 170
                    }

                    AudioBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 135
                    }

                    BluetoothBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 105
                    }

                    NetworkBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 65
                    }

                    SidePaneBtn {
                       anchors.right: parent.right
                       anchors.verticalCenter: parent.verticalCenter
                       anchors.rightMargin: 35
                    }
                }
            }

            PanelWindow {
                id: leftBar
                color: "transparent"
                visible: Config.data.barLayout === "left"
                implicitWidth: 30
                anchors {
                    left: true
                    top: true
                    bottom: true
                }

                Rectangle {
                    id: leftBarRect
                    color: Theme.colBg
                    anchors.fill: parent
                    anchors.leftMargin: 2
                    anchors.topMargin: Config.data.barMargin
                    anchors.bottomMargin: Config.data.barMargin
                    radius: Config.data.barRadius
                    border.color: Theme.colAccent
                }

                Item {
                    id: leftBarContent
                    anchors.fill: parent
                    anchors.bottomMargin: 2.5

                    ClockV {
                        id: clockButtonLeft
                        anchors.centerIn: parent
                        MouseArea {
                            id: clockAreaLeft
                            anchors.fill: clockButtonLeft
                            onClicked: centerMenuLoaderL.item.visible = !centerMenuLoaderL.item.visible
                        }
                    }

                    LazyLoader {
                        id: centerMenuLoaderL
                        loading: true

                        CenterMenu {
                            id: leftCenterMenu
                            anchor.window: leftBar
                            anchor.rect.x: 41
                            anchor.rect.y: leftBar.height / 2 - height / 2 
                        }
                    }

                    MainMenuBtn {
                        id: mainMenuButtonLeft
                        anchors.top: parent.top
                        anchors.topMargin: 25
                        x: 3.5

                        BarButton {
                            icon: "   "
                            onClicked: quickMenuLoaderL.item.visible = !quickMenuLoaderL.item.visible 
                            onEntered: spinAnimLeft.start()
                        }

                        RotationAnimation on rotation {
                            id: spinAnimLeft
                            running: false
                            loops: 1
                            from: 0
                            to: -360
                            duration: 6000
                        }
                    }
                    
                    LazyLoader {
                        id: quickMenuLoaderL
                        loading: true

                        QuickMenu {
                            anchor.window: leftBar
                            anchor.rect.x: 31
                            anchor.rect.y: 10
                        }
                    }  

                    WorkspacesV {
                        anchors.top: parent.top
                        anchors.topMargin: 80
                        x: 9
                    }

                    BatteryBtnV {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 240
                        x: 5
                    }

                    SysMonV {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 160
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    AudioBtn {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 125
                        x: 8  
                    }

                    BluetoothBtn {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 95
                        x: 11
                    }

                    NetworkBtn {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 65
                        x: 8
                    }

                    SidePaneBtn {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 35
                        x: 10 
                    }
                }
            }

            PanelWindow {
                id: rightBar
                color: "transparent"
                visible: Config.data.barLayout === "right"
                implicitWidth: 30
                anchors {
                    right: true
                    top: true
                    bottom: true
                }

                Rectangle {
                    id: rightBarRect
                    color: Theme.colBg
                    anchors.fill: parent
                    anchors.rightMargin: 2
                    anchors.topMargin: Config.data.barMargin
                    anchors.bottomMargin: Config.data.barMargin
                    radius: Config.data.barRadius
                    border.color: Theme.colAccent
                }

                Item {
                    id: rightBarContent
                    anchors.fill: parent

                    Clock {
                        id: clockButtonRight
                        anchors.centerIn: parent
                        MouseArea {
                            id: clockAreaRight
                            anchors.fill: clockButtonRight
                            onClicked: centerMenuLoaderR.item.visible = !centerMenuLoaderR.item.visible
                        }
                    }
                    
                    LazyLoader {
                        id: centerMenuLoaderR
                        loading: true

                        CenterMenu {
                            id: rightCenterMenu
                            anchor.window: rightBar
                            anchor.rect.x: -360
                            anchor.rect.y: rightBar.height / 2 - height / 2 
                        }
                    }

                    MainMenuBtn {
                        id: mainMenuButtonRight
                        anchors.top: parent.top
                        anchors.topMargin: 25
                        x: 1.5

                        BarButton {
                            icon: "   "
                            onClicked: quickMenuLoaderR.item.visible = !quickMenuLoaderR.item.visible 
                            onEntered: spinAnimRight.start()
                        }

                        RotationAnimation on rotation {
                            id: spinAnimRight
                            running: false
                            loops: 1
                            from: 0
                            to: -360
                            duration: 6000
                        }
                    }

                    LazyLoader {
                        id: quickMenuLoaderR
                        loading: true

                        QuickMenu {
                            anchor.window: rightBar
                            anchor.rect.x: -152
                            anchor.rect.y: 10
                        }
                    }

                    WorkspacesV {
                        anchors.top: parent.top
                        anchors.topMargin: 80
                        x: 7
                    }

                    BatteryBtnV {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 240
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    SysMonV {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 160
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    AudioBtn {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 125
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    BluetoothBtn {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 95
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    NetworkBtn {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 65
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    SidePaneBtn {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 35
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }
    }
}
