import Quickshell
import QtQuick
import "."

Scope {

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      property var theme: Theme {}
      screen: modelData
      color: "transparent"
      implicitHeight: 30

      anchors {
        top: true
        left: true
        right: true
      }
      Rectangle {
        color: theme.colBg
        anchors.fill: parent
        radius: 5

        Row {
          anchors.left: parent.left
          spacing: 10

          MainMenu {}
          Workspaces {}
        }

        Row {
          anchors.right: parent.right
          spacing: 10

          Audio {}
          Network {}
          Bluetooth {}
          Notifications {}
          Power {}
        }

        Clock { anchors.centerIn: parent } 
      }
    }
  }
}
