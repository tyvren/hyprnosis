import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import qs.Components
import qs.Themes

Item {
    id: root
    implicitWidth: 350
    implicitHeight: 28

    property bool shouldShowOsd: false

    Scope {
        id: audioScope

        PwObjectTracker {
            objects: [ Pipewire.defaultAudioSink ]
        }

        Connections {
            target: Pipewire.defaultAudioSink?.audio

            function onVolumeChanged() {
                root.shouldShowOsd = true
                hideTimer.restart()
            }
        }
    }

    Timer {
        id: hideTimer
        interval: 1500
        onTriggered: root.shouldShowOsd = false
    }

    OSD {
        anchors.fill: parent
        active: root.shouldShowOsd

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 15
            anchors.rightMargin: 15

            Text {
                color: Theme.colAccent
                font.pointSize: 14
                text: ""
            }

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 8
                radius: 10
                color: Theme.colMuted

                Rectangle {
                    color: Theme.colAccent
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
                    radius: parent.radius
                }
            }
        }
    }
}
