import qs
import qs.Components
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts

PopupWindow {
  id: menuRoot
  width: 200
  height: 350
  color: "transparent"

  Rectangle {
    id: menuContainer
    anchors.fill: parent
    color: "transparent"
    topRightRadius: 300
    bottomRightRadius: 300

    state: menuRoot.visible ? "open" : "closed"

    states:
      State {
        name: "closed"
        PropertyChanges { 
          target: menuContainer
          opacity: 0
        }
      }
      State {
        name: "open"
        PropertyChanges {
          target: menuContainer
          opacity: 1
        }
      }

    transitions: Transition {
      from: "closed"
      to: "open"
      NumberAnimation {
        properties: "opacity"
        duration: 1000
        easing.type: Easing.InOutCubic
      }
    }

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


