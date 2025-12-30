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
  visible: false
  color: "transparent"

  Rectangle {
    anchors.fill: parent
    color: "transparent"
    topRightRadius: 300
    bottomRightRadius: 300

    Rectangle {
      id: iconArea
      color: theme.colBg
      anchors.left: parent.left
      anchors.verticalCenter: parent.verticalCenter
      width: 50
      height: 50
      radius: 50
      visible: false

      RotationAnimation on rotation {
        id: spinAnim
        running: false
        loops: 2
        from: 0
        to: 360
        duration: 500
      }

        ScaleAnimator {
          id: logoGrow
          target: logo
          from: 1
          to: 2
          duration: 500
        }

        ScaleAnimator {
          id: logoShrink
          target: logo
          from: 2
          to: 1
          duration: 500
        }

        Image {
          id: logo
          anchors.fill: iconArea
          source: theme.logoPath
          mipmap: true
          asynchronous: true
          fillMode: Image.PreserveAspectFit
        }

        MouseArea {
          id: iconAreaMouse
          anchors.fill: iconArea
          hoverEnabled: true
          onEntered: { 
            barMenu.visible = true
            spinAnim.start()
          }
          onClicked: {
            barMenu.visible = false
            spinAnim.start()
            logoShrink.start()
          }
        }
      }


    StyledButton {
      id: lockButton
      anchors.top: parent.top
      anchors.topMargin: 80
      anchors.left: parent.left
      anchors.leftMargin: 5
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
      anchors.left: parent.left
      anchors.leftMargin: 5
      anchors.bottom: parent.bottom
      anchors.bottomMargin: 80
      text: ""
      onClicked: restartProcess.startDetached()
    }

    Process { id: lockProcess; command: ["hyprlock"] }
    Process { id: restartProcess; command: ["systemctl", "reboot"] }
    Process { id: shutdownProcess; command: ["systemctl", "poweroff"] }
  }
}


