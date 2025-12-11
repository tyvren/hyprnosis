import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland
import "../.."

PanelWindow {
  id: powermenu
  visible: false
  focusable: true
  color: "transparent"
  WlrLayershell.layer: WlrLayer.Top
  property var theme: Theme {}

  anchors {
    top: true
    bottom: true
    left: true
    right: true
  }

  IpcHandler {
    target: "powermenu"

    function toggle(): void {
      powermenu.visible = !powermenu.visible
    }

    function hide(): void {
      powermenu.visible = false
    }
  }

  Rectangle {
    focus: true
    anchors.centerIn: parent
    width: 400
    height: 300
    radius: 10
    color: theme.colBg
    border.width: 2
    border.color: theme.colAccent

    Keys.onEscapePressed: powermenu.visible = false

    ColumnLayout {
      anchors.centerIn: parent
      spacing: 8

      Rectangle {
        width: 350
        height: 60
        radius: 10
        color: button1area.containsMouse ? theme.colSelect : theme.colBg
        border.width: 2
        border.color: theme.colAccent

        Text {
          anchors.verticalCenter: parent.verticalCenter
          anchors.left: parent.left
          anchors.leftMargin: 15
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 28
          text: ""
        }

        Text {
          anchors.centerIn: parent
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 22
          text: "Lock"
        }

        MouseArea {
          id: button1area
          anchors.fill: parent
          hoverEnabled: true
          onClicked: {
            button1.startDetached()
            powermenu.visible = false
          }
        }

        Process {
          id: button1
          command: [ "hyprlock" ]
        }
      }

      Rectangle {
        width: 350
        height: 60
        radius: 10
        color: button2area.containsMouse ? theme.colSelect : theme.colBg
        border.width: 2
        border.color: theme.colAccent

        Text {
          anchors.verticalCenter: parent.verticalCenter
          anchors.left: parent.left
          anchors.leftMargin: 15
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 28
          text: ""
        }

        Text {
          anchors.centerIn: parent
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 22
          text: "Restart"
        }

        MouseArea {
          id: button2area
          anchors.fill: parent
          hoverEnabled: true
          onClicked: {
            button2.startDetached()
            powermenu.visible = false
          }
        }

        Process {
          id: button2
          command: [ "systemctl", "reboot" ]
        }
      }

      Rectangle {
        width: 350
        height: 60
        radius: 10
        color: button3area.containsMouse ? theme.colSelect : theme.colBg
        border.width: 2
        border.color: theme.colAccent

        Text {
          anchors.verticalCenter: parent.verticalCenter
          anchors.left: parent.left
          anchors.leftMargin: 15
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 28
          text: ""
        }

        Text {
          anchors.centerIn: parent
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 22
          text: "Shutdown"
        }

        MouseArea {
          id: button3area
          anchors.fill: parent
          hoverEnabled: true
          onClicked: {
            button3.startDetached()
            powermenu.visible = false
          }
        }

        Process {
          id: button3
          command: [ "systemctl", "poweroff" ]
        }
      }
    }
  }
}

