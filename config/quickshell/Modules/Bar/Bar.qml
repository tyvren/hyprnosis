import Quickshell
import QtQuick
import QtQuick.Effects
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Wayland
import "../.."

Variants {
  model: Quickshell.screens

  PanelWindow {
    id: shell
    required property var modelData
    property var theme: Theme {}
    screen: modelData
    color: "transparent"

    mask: Region { item: barcontent }

    anchors {
      top: true
      left: true
      right: true
      bottom: true
    }

    Item {
      id: mask
      anchors.fill: parent
      visible: false
      enabled: false
      layer.enabled: true

      Rectangle {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.bottomMargin: 10
        radius: 15
      }
    }

    Rectangle {
      id: barwrap
      anchors.fill: parent
      color: theme.colBg

      layer.enabled: true
      layer.effect: MultiEffect {
        maskSource: mask
        maskEnabled: true
        maskInverted: true
        maskThresholdMin: 0.5
      }

      RectangularShadow {
        cached: true
        anchors.centerIn: shell
        width: shell.width
        height: shell.height
        blur: 25
        spread: -20
        radius: 15
        y: 10
      }
    }

    PanelWindow {
      id: bararea
      color: "transparent"
      anchors {
        top: true
        left: true
        right: true
      }
      implicitHeight: 30

      Rectangle {
        id: barcontent
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 30
        color: theme.colBg

        Row {
          anchors.left: parent.left
          anchors.verticalCenter: parent.verticalCenter
          anchors.leftMargin: 10
          spacing: 30

          MainMenu {}
          Workspaces {}
        }

        Row {
          anchors.right: parent.right
          anchors.verticalCenter: parent.verticalCenter
          anchors.rightMargin: 10
          spacing: 30

          Battery {}
          Audio {}
          Network {}
          Bluetooth {}
          Notifications {}
          Power {}
        }

        Clock {
          anchors.centerIn: parent
        }
      }
    }
  }
}
