import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import qs.Themes

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
      margins.top: 10
      margins.right: 10
      implicitWidth: 180
      implicitHeight: 60
      color: "transparent"
      mask: Region {}

      Item {
        anchors.fill: parent
      
        Rectangle {
          anchors.fill: parent
          radius: 15
          color: Theme.colBg
          border.color: Theme.colAccent
          border.width: 1

          RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10

            Text {
              color: Theme.colAccent
              font.pointSize: 16
              text: ""
            }

            Rectangle {
              Layout.fillWidth: true
              implicitHeight: 10
              radius: 20
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
    }
  }
}
