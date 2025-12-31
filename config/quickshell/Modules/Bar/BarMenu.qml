import qs
import qs.Components
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

PopupWindow {
  width: 200
  height: 350
  color: "transparent"

  Rectangle {
    anchors.fill: parent
    color: "transparent"
    topRightRadius: 300
    bottomRightRadius: 300

    StyledButton {
      id: lockButton
      anchors.top: parent.top
      anchors.topMargin: 80
      anchors.left: parent.left
      anchors.leftMargin: 10
      text: ""
      onClicked: lockProcess.startDetached()
    }

    StyledButton {
      id: shutdownButton
      anchors.left: parent.left
      anchors.leftMargin: 40
      anchors.verticalCenter: parent.verticalCenter
      text: ""
      onClicked: shutdownProcess.startDetached()
    }

    StyledButton {
      id: restartButton
      anchors.bottom: parent.bottom
      anchors.bottomMargin: 80
      anchors.left: parent.left
      anchors.leftMargin: 10
      text: ""
      onClicked: restartProcess.startDetached()
    }

    Process { id: lockProcess; command: ["hyprlock"] }
    Process { id: restartProcess; command: ["systemctl", "reboot"] }
    Process { id: shutdownProcess; command: ["systemctl", "poweroff"] }
  }
}


