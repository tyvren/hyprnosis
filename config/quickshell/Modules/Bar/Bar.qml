import Quickshell
import QtQuick
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
    WlrLayershell.layer: WlrLayer.Top

    anchors {
      top: true
      left: true
      right: true
    } 

    Rectangle {
      id: barcontent
      color: theme.colBg
      anchors.fill: parent

      Row {
        anchors.left: parent.left
        anchors.margins: 10
        spacing: 10

        MainMenu {}
        Workspaces {}
      }

      Row {
        anchors.right: parent.right
        anchors.margins: 10
        spacing: 10

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

      MouseArea {
        id: popuparea
        hoverEnabled: true
        anchors.fill: clock
        onClicked: popuploader.item.visible = !popuploader.item.visible
      }
    }
  }
}
