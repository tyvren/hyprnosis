import Quickshell
import QtQuick
import QtQuick.Effects
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Wayland
import "../.."

Variants {
  model: Quickshell.screens

  PanelWindow {
    id: topbar
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

    Item{
      anchors.fill: parent

      Rectangle {
        id: barcontent
        color: theme.colBg
        anchors.fill: parent

        Row {
          anchors.left: parent.left
          anchors.verticalCenter: parent.verticalCenter
          anchors.margins: 10
          spacing: 30

          MainMenu {}
          Workspaces {}
        }

        Row {
          anchors.right: parent.right
          anchors.verticalCenter: parent.verticalCenter
          anchors.margins: 10
          spacing: 30

          Battery {}
          Audio {}
          Network {}
          Bluetooth {}
          Notifications {}
          Power {}
        }

        Clock { 
          id: clock
          anchors.centerIn: parent
        }
      }
    }
  }
}
