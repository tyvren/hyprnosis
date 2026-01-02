import qs
import qs.Components
import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Effects

PanelWindow {
  id: core 
  anchors {
    left: true
  }
  color: "transparent"
  implicitWidth: 110
  implicitHeight: 240
  exclusionMode: ExclusionMode.Ignore
  property bool open: false
  property bool showButtons: false

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
      duration: 6000
    }

    RotationAnimation on rotation {
      id: infiniteSpinAnim
      running: false
      loops: Animation.Infinite
      from: 0
      to: 360
      duration: 6000
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
        core.open = true
        mediaPlayer.visible = true
      }
      onClicked: {
        core.open = false
        mediaPlayer.visible = false
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
          ScriptAction {
            script: { 
              infiniteSpinAnim.start()
            }
          }
          NumberAnimation {
            properties: "scale"
            duration: 300
            easing.type: Easing.OutCubic
          }
          ScriptAction {
            script: {
              core.showButtons = true
            }
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
              core.showButtons = false
            }
          }
          NumberAnimation {
            properties: "scale"
            duration: 400
            easing.type: Easing.OutCubic
          }
        }
      }
    ]
  }

  Loader {
    id: buttonLoader
    active: core.showButtons
    anchors.centerIn: coreArea 
    sourceComponent: Component {
      Item {
        id: buttons
        property bool ready: false
        Component.onCompleted: ready = true

        StyledButton {
          id: lockButton
          x: 50
          y: -75
          text: ""
          onClicked: lockProcess.startDetached()
          opacity: (buttons.ready && core.open && coreArea.scale === 3) ? 1 : 0
          Behavior on opacity {
            NumberAnimation { duration: 250 }
          }
        }

        StyledButton {
          id: shutdownButton
          x: 65
          y: -25
          text: ""
          onClicked: shutdownProcess.startDetached()
          opacity: (buttons.ready && core.open && coreArea.scale === 3) ? 1 : 0
          Behavior on opacity {
            NumberAnimation { duration: 250 }
          }
        }

        StyledButton {
          id: restartButton
          x: 50
          y: 25
          text: ""
          onClicked: restartProcess.startDetached()
          opacity: (buttons.ready && core.open && coreArea.scale === 3) ? 1 : 0
          Behavior on opacity {
            NumberAnimation { duration: 250 }
          }
        }

        Process { id: lockProcess; command: ["hyprlock"] }
        Process { id: restartProcess; command: ["systemctl", "reboot"] }
        Process { id: shutdownProcess; command: ["systemctl", "poweroff"] }
      }
    }
  }
}
