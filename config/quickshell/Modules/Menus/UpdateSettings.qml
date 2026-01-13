import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.Themes
import qs.Services
import qs.Components

ColumnLayout {
  id: updatePane
  spacing: 15

  property string scriptDir: Quickshell.env("HOME") + "/.config/hyprnosis/modules/updates/"

  Text {
    text: "Updates"
    color: Theme.colAccent
    font.pointSize: 16
    font.family: Theme.fontFamily
    Layout.bottomMargin: 5
  }

  DividerLine {
    Layout.fillWidth: true
  }

  ColumnLayout {
    spacing: 10
    Layout.fillWidth: true

    Repeater {
      model: [
        { name: "System", script: "update_system.sh" },
        { name: "AUR", script: "update_aur.sh" },
        { name: "Hyprnosis", script: "update_hyprnosis.sh" }
      ]

      Item {
        Layout.fillWidth: true
        Layout.preferredHeight: 45

        MultiEffect {
          anchors.fill: btnRect
          source: btnRect
          shadowEnabled: true
          shadowBlur: 0.2
          shadowColor: Theme.colAccent
          shadowVerticalOffset: 1
          opacity: 0.8
        }

        Rectangle {
          id: btnRect
          anchors.fill: parent
          radius: 10
          color: btnMa.containsMouse ? Theme.colAccent : Theme.colMuted

          Text {
            anchors.centerIn: parent
            text: "Update " + modelData.name
            color: btnMa.containsMouse ? Theme.colBg : Theme.colAccent
            font.pointSize: 12
            font.family: Theme.fontFamily
          }

          MouseArea {
            id: btnMa
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
              proc.startDetached()
            }
          }

          Process {
            id: proc
            command: ["sh", "-c", "ghostty -e " + updatePane.scriptDir + modelData.script]
          }
        }
      }
    }
  }

  Item { Layout.fillHeight: true }
}
