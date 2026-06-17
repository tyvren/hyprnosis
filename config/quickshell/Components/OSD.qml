import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.Themes

Item {
    id: osdRoot

    property bool active: false
    default property alias data: osdContainer.data

    onActiveChanged: {
        if (active) {
            osdRoot.visible = true
        }
    }

    MultiEffect {
        anchors.fill: osdContainer
        source: osdContainer
        shadowEnabled: true
        shadowBlur: 0.4
        shadowColor: Theme.colAccent
        shadowVerticalOffset: 1
        shadowHorizontalOffset: 0
        opacity: osdContainer.opacity
    }

    Rectangle {
        id: osdContainer
        anchors.fill: parent
        radius: 2
        color: Theme.colBg
        border.color: Theme.colAccent
        border.width: 0.8
        state: osdRoot.active ? "visible" : "hidden"

        states: [
            State {
                name: "hidden"
                PropertyChanges {
                    target: osdContainer
                    opacity: 0
                    y: 0
                }
            },
            State {
                name: "visible"
                PropertyChanges {
                    target: osdContainer
                    opacity: 1
                    y: 28
                }
            }
        ]

        transitions: [
            Transition {
                from: "hidden"
                to: "visible"
                SequentialAnimation {
                    NumberAnimation {
                        properties: "opacity, y"
                        duration: 200
                        easing.type: Easing.InOutCubic
                    }
                }
            },
            Transition {
                from: "visible"
                to: "hidden"
                SequentialAnimation {
                    NumberAnimation {
                        properties: "opacity, y"
                        duration: 250
                        easing.type: Easing.InOutCubic
                    }
                    ScriptAction { 
                        script: { osdRoot.visible = false } 
                    }
                }
            }
        ]
    }
}
