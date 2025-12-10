import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland
import "../.."

PanelWindow {
  id: mainmenu
  visible: false
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
    target: "mainmenu"

    function toggle(): void {
      mainmenu.visible = !mainmenu.visible
      if (mainmenu.visible) {
          mainmenu.forceActiveFocus()
          search.forceActiveFocus()
      }
    }

    function hide(): void {
      mainmenu.visible = false
    }
  }

  Rectangle {
    anchors.centerIn: parent
    width: 400
    height: 500
    radius: 10
    color: theme.colBg
    border.width: 2
    border.color: theme.colAccent

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
          anchors.centerIn: parent
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 28
          text: " Apps"
        }

        MouseArea {
          id: button1area
          anchors.fill: parent
          hoverEnabled: true
          onClicked: {
            button1.startDetached()
            mainmenu.visible = false
          }
        }

        Process {
          id: button1
          command: [ "walker" ]
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
          anchors.centerIn: parent
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 28
          text: " Packages"
        }

        MouseArea {
          id: button2area
          anchors.fill: parent
          hoverEnabled: true
          onClicked: {
            mainmenu.visible = false
            button2.startDetached() 
          }
        }

        Process {
          id: button2
          command: [ "sh", "-c", "qs ipc call packagesmenu toggle" ]
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
          anchors.centerIn: parent
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 28
          text: " Style"
        }

        MouseArea {
          id: button3area
          anchors.fill: parent
          hoverEnabled: true
          onClicked: {
            button3.startDetached()
            mainmenu.visible = false
          }
        }

        Process {
          id: button3
          command: [ "walker", "--provider", "menus:style" ]
        }
      }

      Rectangle {
        width: 350
        height: 60
        radius: 10
        color: button4area.containsMouse ? theme.colSelect : theme.colBg
        border.width: 2
        border.color: theme.colAccent

        Text {
          anchors.centerIn: parent
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 28
          text: "󰹑 Capture"
        }

        MouseArea {
          id: button4area
          anchors.fill: parent
          hoverEnabled: true
          onClicked: {
            button4.startDetached()
            mainmenu.visible = false
          }
        }

        Process {
          id: button4
          command: [ "sh", "-c", "qs ipc call capturemenu toggle" ]
        }
      }

      Rectangle {
        width: 350
        height: 60
        radius: 10
        color: button5area.containsMouse ? theme.colSelect : theme.colBg
        border.width: 2
        border.color: theme.colAccent

        Text {
          anchors.centerIn: parent
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 28
          text: " Update"
        }

        MouseArea {
          id: button5area
          anchors.fill: parent
          hoverEnabled: true
          onClicked: {
            button5.startDetached()
            mainmenu.visible = false
          }
        }

        Process {
          id: button5
          command: [ "sh", "-c", "qs ipc call updatemenu toggle" ]
        }
      }

      Rectangle {
        width: 350
        height: 60
        radius: 10
        color: button6area.containsMouse ? theme.colSelect : theme.colBg
        border.width: 2
        border.color: theme.colAccent

        Text {
          anchors.centerIn: parent
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 28
          text: "  Utilities"
        }

        MouseArea {
          id: button6area
          anchors.fill: parent
          hoverEnabled: true
          onClicked: {
            button6.startDetached()
            mainmenu.visible = false
          }
        }

        Process {
          id: button6
          command: [ "sh", "-c", "qs ipc call utilmenu toggle" ]
        }
      }
    }
  }
}
