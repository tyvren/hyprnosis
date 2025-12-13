import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland
import "../.."

PanelWindow {
  id: thememenu
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
    target: "thememenu"

    function toggle(): void {
      thememenu.visible = !thememenu.visible
    }

    function hide(): void {
      thememenu.visible = false
    }
  }

  Rectangle {
    id: menuroot
    focus: true
    anchors.centerIn: parent
    width: 400
    height: 500
    radius: 10
    color: theme.colBg
    border.width: 2
    border.color: theme.colAccent

    Keys.onEscapePressed: thememenu.visible = false

    ColumnLayout {
      id: themelist
      focus: true
      anchors.centerIn: parent
      spacing: 8

      Keys.onUpPressed: list.themelist?.incrementCurrentIndex()
      Keys.onDownPressed: list.themelist?.decrementCurrentIndex()
      
      Rectangle {
        id: option1
        focus: true
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
          text: ""
        }

        Text {
          anchors.centerIn: parent
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 22
          text: "Hyprnosis"
        }

        MouseArea {
          id: button1area
          anchors.fill: parent
          hoverEnabled: true
          onClicked: {
            button1.startDetached()
            thememenu.visible = false
          }
        }

        Process {
          id: button1
          command: [ "sh", "-c", '~/.config/hyprnosis/modules/style/theme_changer.sh "Hyprnosis"' ]
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
          text: ""
        }

        Text {
          anchors.centerIn: parent
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 22
          text: "Catppuccin Mocha"
        }

        MouseArea {
          id: button2area
          anchors.fill: parent
          hoverEnabled: true
          onClicked: {
            thememenu.visible = false
            button2.startDetached() 
          }
        }

        Process {
          id: button2
          command: [ "sh", "-c", '~/.config/hyprnosis/modules/style/theme_changer.sh "Mocha"' ]
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
          text: ""
        }

        Text {
          anchors.centerIn: parent
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 22
          text: "Emberforge"
        }

        MouseArea {
          id: button3area
          anchors.fill: parent
          hoverEnabled: true
          onClicked: {
            button3.startDetached()
            thememenu.visible = false
          }
        }

        Process {
          id: button3
          command: [ "sh", "-c", '~/.config/hyprnosis/modules/style/theme_changer.sh "Emberforge"' ]
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
          anchors.verticalCenter: parent.verticalCenter
          anchors.left: parent.left
          anchors.leftMargin: 15
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 28
          text: ""
        }

        Text {
          anchors.centerIn: parent
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 22
          text: "Dracula"
        }

        MouseArea {
          id: button4area
          anchors.fill: parent
          hoverEnabled: true
          onClicked: {
            button4.startDetached()
            thememenu.visible = false
          }
        }

        Process {
          id: button4
          command: [ "sh", "-c", '~/.config/hyprnosis/modules/style/theme_changer.sh "Dracula"' ]
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
          anchors.verticalCenter: parent.verticalCenter
          anchors.left: parent.left
          anchors.leftMargin: 15
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 28
          text: ""
        }

        Text {
          anchors.centerIn: parent
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 22
          text: "Arcadia"
        }

        MouseArea {
          id: button5area
          anchors.fill: parent
          hoverEnabled: true
          onClicked: {
            button5.startDetached()
            thememenu.visible = false
          }
        }

        Process {
          id: button5
          command: [ "sh", "-c", '~/.config/hyprnosis/modules/style/theme_changer.sh "Arcadia"' ]
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
          anchors.verticalCenter: parent.verticalCenter
          anchors.left: parent.left
          anchors.leftMargin: 15
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 28
          text: ""
        }

        Text {
          anchors.centerIn: parent
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 22
          text: "Eden"
        }

        MouseArea {
          id: button6area
          anchors.fill: parent
          hoverEnabled: true
          onClicked: {
            button6.startDetached()
            thememenu.visible = false
          }
        }

        Process {
          id: button6
          command: [ "sh", "-c", '~/.config/hyprnosis/modules/style/theme_changer.sh "Eden"' ]
        }
      }
    }
  }
}

