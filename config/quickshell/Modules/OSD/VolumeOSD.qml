import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import qs

Scope {
    id: root

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

    property bool shouldShowOsd: false

    Timer {
        id: hideTimer
        interval: 1000
        onTriggered: root.shouldShowOsd = false
    }

    LazyLoader {
        active: root.shouldShowOsd

        PanelWindow {
            anchors.top: true
            anchors.right: true
            implicitWidth: screen.width / 12
            implicitHeight: screen.height / 24
            property var theme: Theme {}
            color: "transparent"
            mask: Region {}

            Item {
                anchors.fill: parent

                Rectangle {
                    anchors.fill: parent
                    radius: 15
                    color: theme.colTransB

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 15

                        Text {
                            color: theme.colHilight
                            font.pixelSize: 25
                            text: ""
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            implicitHeight: 10
                            radius: 20
                            color: theme.colBg

                            Rectangle {
                                color: theme.colHilight
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
        }
    }
}
