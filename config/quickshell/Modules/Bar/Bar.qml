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

                    ClockH {
                        id: clockButtonTop
                        anchors.centerIn: parent
                        MouseArea {
                            id: clockAreaTop
                            anchors.fill: clockButtonTop
                            onClicked: calendarLoader.item.visible = !calendarLoader.item.visible
                        }
                    }

                    LazyLoader {
                        id: calendarLoader
                        loading: true

                        Calendar {
                            id: topCalendar
                            anchor.window: topBar
                            anchor.rect.x: 1100
                            anchor.rect.y: 40
                        }
                    }

                    MainMenuBtn {
                        anchors.left: parent.left
                        anchors.leftMargin: 25
                        anchors.verticalCenter: parent.verticalCenter

                        BarButton {
                            icon: "   "
                            onClicked: {
                                quickMenuLoader.item.visible = !quickMenuLoader.item.visible 
                            }
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

                    WorkspacesH {
                        id: workspacesButtonTop
                        anchors.left: parent.left
                        anchors.leftMargin: 80
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    BatteryBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 180
                    }

                    AudioBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 150
                    }

                    BluetoothBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 120
                    }

                    NetworkBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 85
                    }

                    NotificationBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 55
                    }

                    SidePanelBtn {
                       anchors.right: parent.right
                       anchors.verticalCenter: parent.verticalCenter
                       anchors.rightMargin: 25
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

                    Calendar {
                        id: bottomCalendar
                        visible: clockAreaBottom.containsMouse
                        anchor.window: bottomBar
                        anchor.rect.x: 1100
                        anchor.rect.y: 40
                    }

                    ClockH {
                        id: clockButtonBottom
                        anchors.centerIn: parent
                        MouseArea {
                            id: clockAreaBottom
                            anchors.fill: clockButtonBottom
                            hoverEnabled: true
                        }
                    }

                    MainMenuBtn {
                        anchors.left: parent.left
                        anchors.leftMargin: 25
                        anchors.verticalCenter: parent.verticalCenter

                        BarButton {
                            icon: "   "
                            onClicked: {
                                quickMenuLoaderB.item.visible = !quickMenuLoaderB.item.visible 
                            }
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

                    WorkspacesH {
                        anchors.left: parent.left
                        anchors.leftMargin: 80
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    BatteryBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 180
                    }

                    AudioBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 150
                    }

                    BluetoothBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 120
                    }

                    NetworkBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 85
                    }

                    NotificationBtn {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 55
                    }

                    SidePanelBtn {
                       anchors.right: parent.right
                       anchors.verticalCenter: parent.verticalCenter
                       anchors.rightMargin: 25
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

                    Clock {
                        id: clockButtonLeft
                        anchors.centerIn: parent
                        MouseArea {
                            id: clockAreaLeft
                            anchors.fill: clockButtonLeft
                            hoverEnabled: true
                        }
                    }

                    MainMenuBtn {
                        anchors.top: parent.top
                        anchors.topMargin: 25
                        x: 3.5

                        BarButton {
                            icon: "   "
                            onClicked: {
                                quickMenuLoaderL.item.visible = !quickMenuLoaderL.item.visible 
                            }
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

                    Workspaces {
                        anchors.top: parent.top
                        anchors.topMargin: 80
                        x: 9
                    }

                    BatteryBtn {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 180
                        x: 8
                    }

                    AudioBtn {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 150
                        x: 8  
                    }

                    BluetoothBtn {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 120
                        x: 10 
                    }

                    NetworkBtn {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 85
                        x: 8
                    }

                    NotificationBtn {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 55
                        x: 10 
                    }

                    SidePanelBtn {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 25
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
                            hoverEnabled: true
                        }
                    }

                    MainMenuBtn {
                        anchors.top: parent.top
                        anchors.topMargin: 25
                        x: 1.5

                        BarButton {
                            icon: "   "
                            onClicked: {
                                quickMenuLoaderR.item.visible = !quickMenuLoaderR.item.visible 
                            }
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

                    Workspaces {
                        anchors.top: parent.top
                        anchors.topMargin: 80
                        x: 7
                    }

                    BatteryBtn {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 180
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    AudioBtn {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 150
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    BluetoothBtn {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 120
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    NetworkBtn {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 85
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    NotificationBtn {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 55
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    SidePanelBtn {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 25
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }
    }
}
