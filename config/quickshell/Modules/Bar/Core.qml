import qs
import qs.Components
import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Effects

PanelWindow {
  id: core
  property bool open: false
  anchors {
    left: true
  }
  color: "transparent"
  implicitWidth: 110
  implicitHeight: 240
  exclusionMode: ExclusionMode.Ignore

  RectangularShadow {
    id: coreAreaShadow
    anchors.fill: coreArea
    color: theme.colAccent
    height: coreArea.height
    width: coreArea.width
    radius: 150
    blur: 5
    spread: 1
  }

  Rectangle {
    id: coreArea
    color: theme.colBg
    border.color: theme.colAccent
    border.width: 1
    anchors.verticalCenter: parent.verticalCenter
    x: -52
    width: 80
    height: 80
    radius: 150
    scale: 1

    RotationAnimation on rotation {
      id: spinAnim
      running: false
      loops: 1
      from: 0
      to: 360
      duration: 5000
    }

    RotationAnimation on rotation {
      id: infiniteSpinAnim
      running: false
      loops: Animation.Infinite
      from: 0
      to: 360
      duration: 5000
    }

    Image {
      id: logo
      anchors.fill: coreArea
      source: theme.logoPath
      mipmap: true
      asynchronous: true
      fillMode: Image.PreserveAspectFit
    }

    MouseArea {
      id: coreAreaMouse
      anchors.fill: coreArea
      hoverEnabled: true
      onEntered: {
        mediaPlayer.visible = true
        core.open = true
      }
      onClicked: {
        mediaPlayer.visible = false
        core.open = false
      }
    }

    states: [
      State {
        name: "closed"
        when: !core.open
        PropertyChanges {
          target: coreArea
          scale: 1
        }
      },
      State {
        name: "open"
        when: core.open
        PropertyChanges {
          target: coreArea
          scale: 3
        }
      }
    ]

    transitions: [
      Transition {
        from: "closed"
        to: "open"
        SequentialAnimation {
          NumberAnimation {
            properties: "scale"
            duration: 500
          }
          ScriptAction {
            script: infiniteSpinAnim.start()
          }
        }
      },
      Transition {
        from: "open"
        to: "closed"
        SequentialAnimation {
          ScriptAction {
            script: {
              infiniteSpinAnim.stop()
              spinAnim.start()
            }
          }
          NumberAnimation {
            properties: "scale"
            duration: 500
          }
        }
      }
    ]
  }

  StyledButton {
    id: lockButton
    anchors.top: coreArea.top
    anchors.topMargin: -40
    anchors.left: coreArea.right
    anchors.leftMargin: 0
    text: ""
    onClicked: lockProcess.startDetached()
    visible: core.open
    opacity: core.open ? 1 : 0
    Behavior on opacity {
      NumberAnimation { duration: 1000 }
    }
  }

  StyledButton {
    id: shutdownButton
    anchors.left: parent.left
    anchors.leftMargin: 50
    anchors.verticalCenter: parent.verticalCenter
    text: ""
    onClicked: shutdownProcess.startDetached()
    visible: core.open
    opacity: core.open ? 1 : 0
    Behavior on opacity {
      NumberAnimation { duration: 1000 }
    }
  }

  StyledButton {
    id: restartButton
    anchors.bottom: coreArea.bottom
    anchors.bottomMargin: -40
    anchors.left: coreArea.right
    anchors.leftMargin: 0
    text: ""
    onClicked: restartProcess.startDetached()
    visible: core.open
    opacity: core.open ? 1 : 0
    Behavior on opacity {
      NumberAnimation { duration: 1000 }
    }
  }

  Process { id: lockProcess; command: ["hyprlock"] }
  Process { id: restartProcess; command: ["systemctl", "reboot"] }
  Process { id: shutdownProcess; command: ["systemctl", "poweroff"] }
}
