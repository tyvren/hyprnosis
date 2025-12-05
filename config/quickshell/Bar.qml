// Bar.qml
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
      color: theme.colBg
      implicitHeight: 30

      anchors {
        top: true
        left: true
        right: true
      }

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
      }

      Clock { anchors.centerIn: parent } 
    }
  }
}
