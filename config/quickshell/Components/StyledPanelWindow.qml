import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Widgets
import qs.Components
import qs.Services
import qs.Themes

PanelWindow {
    id: panelWindowRoot
    visible: false
    focusable: true
    implicitWidth: 400
    implicitHeight: 400
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore

    property bool open: false
    property bool showContent: false

    required property var modelData

    anchors {
        top: Config.data.barLayout === "top" ? true : false
        bottom: Config.data.barLayout === "bottom" ? true : false
    }

    onVisibleChanged: {
        if (visible) {
            open = true
            focusGrab.active = true
        } else {
            open = false
            focusGrab.active = false
        }
        query = ""
    }

    Item {
        id: windowContainer
        width: 400
        height: 400
        anchors.horizontalCenter: parent.horizontalCenter
        state: panelWindowRoot.open ? "open" : "closed"

        Keys.onEscapePressed: panelWindowRoot.open = false

        states: [
            State {
                name: "closed"
                PropertyChanges {
                    target: windowContainer
                    opacity: 0.5
                    y: Config.data.barLayout === "top" ? -369 : 369
                }
            },
            State {
                name: "open"
                PropertyChanges {
                    target: windowContainer
                    opacity: 1
                    y: Config.data.barLayout === "top" ? -30 : 30
                }
            }
        ]

        transitions: [
            Transition {
                from: "closed"
                to: "open"
                SequentialAnimation {
                    NumberAnimation {
                        properties: "opacity, y"
                        duration: 150
                        easing.type: Easing.OutQuart
                    }
                    ScriptAction { 
                        script: {
                            panelWindowRoot.showContent = true
                        } 
                    }
                }
            },
            Transition {
                from: "open"
                to: "closed"
                SequentialAnimation {
                    ScriptAction { script: panelWindowRoot.showContent = false }
                    NumberAnimation {
                        properties: "opacity, y"
                        duration: 250
                        easing.type: Easing.InQuart
                    }
                    ScriptAction { script: panelWindowRoot.visible = false }
                }
            }
        ]

        Item {
            id: topBackgroundContainer
            anchors.fill: parent
            visible: Config.data.barLayout === "top"
        

            Rectangle {
                id: topBackground
                anchors.fill: parent
                anchors.topMargin: 30
                radius: 5 
                color: Theme.colBg
                border.color: Theme.colAccent
                border.width: 1
                clip: true
                visible: Config.data.barLayout === "top"

                Image {
                    id: logoImage
                    anchors.centerIn: parent
                    width: 400
                    height: 375
                    source: Theme.logoPath
                    mipmap: true
                    asynchronous: true
                    fillMode: Image.PreserveAspectFit
                    opacity: 0.3
                }

                Loader {
                    id: topContentLoader
                    anchors.fill: parent
                    active: launcherMenu.showContent
                    focus: true
                    sourceComponent: launcherContent
                }
            }

            MultiEffect {
                id: topLauncherShadow
                anchors.fill: topBackground
                source: topBackground
                shadowEnabled: true
                shadowColor: Theme.colAccent
                shadowBlur: 0.2
                z: -1
            }
        }

        Item {
            id: bottomBackgroundContainer
            anchors.fill: parent
            visible: Config.data.barLayout === "bottom"
            
            Rectangle {
                id: bottomBackground
                anchors.fill: parent
                anchors.bottomMargin: 30
                radius: 5 
                color: Theme.colBg
                border.color: Theme.colAccent
                border.width: 1
                clip: true
                visible: Config.data.barLayout === "bottom"

                Image {
                    id: bottomLogoImage
                    anchors.centerIn: parent
                    width: 400
                    height: 375
                    source: Theme.logoPath
                    mipmap: true
                    asynchronous: true
                    fillMode: Image.PreserveAspectFit
                    opacity: 0.3
                }

                Loader {
                    id: bottomContentLoader
                    anchors.fill: parent
                    active: panelWindowRoot.showContent
                    focus: true
                    sourceComponent: launcherContent
                }
            }

            MultiEffect {
                id: bottomLauncherShadow
                anchors.fill: bottomBackground
                source: bottomBackground
                shadowEnabled: true
                shadowColor: Theme.colAccent
                shadowBlur: 0.2
                z: -1
            }
        }
    } 

    HyprlandFocusGrab {
        id: focusGrab
        windows: [ panelWindowRoot ]
        
        onCleared: {
            panelWindowRoot.open = false
        } 
    }
}
