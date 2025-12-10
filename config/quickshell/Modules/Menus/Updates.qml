import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland
import "../.."

PanelWindow {
  id: updatemenu
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
    target: "updatemenu"

    function toggle(): void {
      updatemenu.visible = !updatemenu.visible
      if (updatemenu.visible) {
          updatemenu.forceActiveFocus()
          search.forceActiveFocus()
      }
    }

    function hide(): void {
      updatemenu.visible = false
    }
  }

  Rectangle {
    anchors.centerIn: parent
    width: 400
    height: 300
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
          font.pixelSize: 24
          text: " Update System"
        }

        MouseArea {
          id: button1area
          anchors.fill: parent
          hoverEnabled: true
          onClicked: {
            button1.startDetached()
            updatemenu.visible = false
          }
        }

        Process {
          id: button1
          command: [ "sh", "-c", "ghostty -e ~/.config/hyprnosis/modules/updates/update_system.sh" ]
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
          font.pixelSize: 24
          text: " Update AUR"
        }

        MouseArea {
          id: button2area
          anchors.fill: parent
          hoverEnabled: true
          onClicked: {
            button2.startDetached()
            updatemenu.visible = false
          }
        }

        Process {
          id: button2
          command: [ "sh", "-c", "ghostty -e ~/.config/hyprnosis/modules/updates/update_aur.sh" ]
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
          font.pixelSize: 24
          text: " Update hyprnosis"
        }

        MouseArea {
          id: button3area
          anchors.fill: parent
          hoverEnabled: true
          onClicked: {
            button3.startDetached()
            updatemenu.visible = false
          }
        }

        Process {
          id: button3
          command: [ "sh", "-c", "ghostty -e ~/.config/hyprnosis/modules/updates/update_hyprnosis.sh" ]
        }
      }
    }
  }
}
