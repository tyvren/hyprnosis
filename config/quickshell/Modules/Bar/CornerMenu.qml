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
      anchors.leftMargin: 85
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
          text: ""
          font.family: theme.fontFamily
          font.pointSize: 16
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
          font.pointSize: 16
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
          font.pointSize: 16
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

  Media {
    id: mediaWidget
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.leftMargin: 60
    opacity: menuContainer.visible ? 1.0 : 0.0
    Behavior on opacity { NumberAnimation { duration: 1000 } }
  }

  ColumnLayout {
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.leftMargin: 0
    anchors.bottomMargin: 15
    spacing: 8
    opacity: menuContainer.visible ? 1.0 : 0.0
    Behavior on opacity {
      NumberAnimation { duration: 1000 }
    }
    visible: false

    Rectangle {
      id: settingsButton
      width: 50
      height: 50
      radius: 50
      color: settingsButtonArea.containsMouse ? theme.colSelect : theme.colBg
      border.color: theme.colAccent
      border.width: 2

      Text {
        anchors.centerIn: parent
        text: ""
        font.family: theme.fontFamily
        font.pointSize: 16
        color: theme.colAccent
      }

      MouseArea {
        id: settingsButtonArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: settingsProcess.startDetached()
      }
    }

    Rectangle {
      id: newButton2
      width: 50
      height: 50
      radius: 50
      color: "transparent"
      border.color: theme.colAccent
      border.width: 2
    }

    Rectangle {
      id: newButton3
      width: 50
      height: 50
      radius: 50
      color: "transparent"
      border.color: theme.colAccent
      border.width: 2
    }
  }
}
