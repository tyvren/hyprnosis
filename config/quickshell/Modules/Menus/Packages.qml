import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland
import "../.."

PanelWindow {
  id: packagesmenu
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
    target: "packagesmenu"

    function toggle(): void {
      packagesmenu.visible = !packagesmenu.visible
    }

    function hide(): void {
      packagesmenu.visible = false
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

    Keys.onEscapePressed: packagesmenu.visible = false

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
          font.pixelSize: 24
          text: "󰣇"
        }

        Text {
          anchors.centerIn: parent
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 24
          text: "Install Arch Pkg"
        }

        MouseArea {
          id: button1area
          anchors.fill: parent
          hoverEnabled: true
          onClicked: {
            button1.startDetached()
            packagesmenu.visible = false
          }
        }

        Process {
          id: button1
          command: [ "sh", "-c", "ghostty -e ~/.config/hyprnosis/modules/packages/pkg_install.sh" ]
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
          font.pixelSize: 24
          text: ""
        }

        Text {
          anchors.centerIn: parent
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 24
          text: "Install AUR Pkg"
        }

        MouseArea {
          id: button2area
          anchors.fill: parent
          hoverEnabled: true
          onClicked: {
            button2.startDetached()
            packagesmenu.visible = false
          }
        }

        Process {
          id: button2
          command: [ "sh", "-c", "ghostty -e ~/.config/hyprnosis/modules/packages/pkg_aur_install.sh" ]
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
          font.pixelSize: 24
          text: "󱧙"
        }

        Text {
          anchors.centerIn: parent
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 24
          text: "Uninstall Pkg"
        }

        MouseArea {
          id: button3area
          anchors.fill: parent
          hoverEnabled: true
          onClicked: {
            button3.startDetached()
            packagesmenu.visible = false
          }
        }

        Process {
          id: button3
          command: [ "sh", "-c", "ghostty -e ~/.config/hyprnosis/modules/packages/pkg_uninstall.sh" ]
        }
      }
    }
  }
}

