import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import qs
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

Item {

  Rectangle {
    anchors.fill: parent
    color: "transparent"

    RowLayout {
      anchors.top: parent.top
      anchors.left: parent.left
      anchors.topMargin: 40
      anchors.leftMargin: 75
      spacing: 8

      Rectangle {
        id: lockButton
        width: 50
        height: 50
        radius: 50
        color: lockButtonArea.containsMouse ? theme.colSelect : theme.colBg
        border.color: theme.colAccent
        border.width: 2
        opacity: menuContainer.visible ? 1.0 : 0.0
        Behavior on opacity { NumberAnimation { duration: 1000 } }

        Text {
          anchors.centerIn: parent
          text: ""
          font.family: theme.fontFamily
          font.pixelSize: 22
          color: theme.colAccent
        }

        MouseArea {
          id: lockButtonArea
          anchors.fill: parent
          hoverEnabled: true
          onClicked: lockProcess.startDetached()
        }

        Process { id: lockProcess; command: ["hyprlock"] }
      }

      Rectangle {
        id: restartButton
        width: 50
        height: 50
        radius: 50
        color: restartButtonArea.containsMouse ? theme.colSelect : theme.colBg
        border.color: theme.colAccent
        border.width: 2
        opacity: menuContainer.visible ? 1.0 : 0.0
        Behavior on opacity { NumberAnimation { duration: 1000 } }

        Text {
          anchors.centerIn: parent
          text: ""
          font.family: theme.fontFamily
          font.pixelSize: 22
          color: theme.colAccent
        }

        MouseArea {
          id: restartButtonArea
          anchors.fill: parent
          hoverEnabled: true
          onClicked: restartProcess.startDetached()
        }

        Process { id: restartProcess; command: ["systemctl", "reboot"] }
      }

      Rectangle {
        id: shutdownButton
        width: 50
        height: 50
        radius: 50
        color: shutdownButtonArea.containsMouse ? theme.colSelect : theme.colBg
        border.color: theme.colAccent
        border.width: 2
        opacity: menuContainer.visible ? 1.0 : 0.0
        Behavior on opacity { NumberAnimation { duration: 1000 } }

        Text {
          anchors.centerIn: parent
          text: ""
          font.family: theme.fontFamily
          font.pixelSize: 22
          color: theme.colAccent
        }

        MouseArea {
          id: shutdownButtonArea
          anchors.fill: parent
          hoverEnabled: true
          onClicked: shutdownProcess.startDetached()
        }

        Process { id: shutdownProcess; command: ["systemctl", "poweroff"] }
      }
    }
  }

  ColumnLayout {
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.leftMargin: 50
    spacing: 8

    Media {
      id: mediaWidget
      anchors.bottom: parent.bottom
      opacity: menuContainer.visible ? 1.0 : 0.0
      Behavior on opacity { NumberAnimation { duration: 1000 } }
    }

    Rectangle {
      id: newButton1
      width: 120
      height: 50
      radius: 15
      color: "transparent"
      //border.color: theme.colAccent
      //border.width: 2
      opacity: menuContainer.visible ? 1.0 : 0.0

      Behavior on opacity {
        NumberAnimation { duration: 1000 }
      }
    }

    Rectangle {
      id: newButton2
      width: 120
      height: 50
      radius: 15
      color: "transparent"
      //border.color: theme.colAccent
      //border.width: 2
      opacity: menuContainer.visible ? 1.0 : 0.0

      Behavior on opacity {
        NumberAnimation { duration: 1000 }
      }
    }
  }
}
