import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import qs
import qs.Widgets
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

      StyledButton {
        id: lockButton
        text: ""
        opacity: menuContainer.visible ? 1.0 : 0.0
        Behavior on opacity { NumberAnimation { duration: 1000 } }
        onClicked: lockProcess.startDetached()
      }

      StyledButton {
        id: restartButton
        text: ""
        opacity: menuContainer.visible ? 1.0 : 0.0
        Behavior on opacity { NumberAnimation { duration: 1000 } }
        onClicked: restartProcess.startDetached()
      }

      StyledButton {
        id: shutdownButton
        text: ""
        opacity: menuContainer.visible ? 1.0 : 0.0
        Behavior on opacity { NumberAnimation { duration: 1000 } }
        onClicked: shutdownProcess.startDetached()
      }

      Process { id: lockProcess; command: ["hyprlock"] }
      Process { id: restartProcess; command: ["systemctl", "reboot"] }
      Process { id: shutdownProcess; command: ["systemctl", "poweroff"] }
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
    Behavior on opacity { NumberAnimation { duration: 1000 } }
    visible: false

    StyledButton {
      id: settingsButton
      text: ""
      onClicked: settingsProcess.startDetached()
    }

    StyledButton {
      id: newButton2
      text: ""
    }

    StyledButton {
      id: newButton3
      text: ""
    }

    Process { id: settingsProcess; command: [] }
  }
}
