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

    anchors {
      top: true
      left: true
      right: true
      bottom: true
    }

    mask: Region { item: container; intersection: Intersection.Xor }

    Item {
      id: container
      anchors.fill: parent

      Rectangle {
        anchors.fill: parent
        color: theme.colBg
        layer.enabled: true
        layer.effect: MultiEffect {
          maskSource: mask
          maskEnabled: true
          maskInverted: true
          maskThresholdMin: 0.5
        }
      }
    }

    Item {
      id: mask
      anchors.fill: parent
      visible: false
      layer.enabled: true

      Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.bottomMargin: 10
        height: parent.height - 10
        radius: 10
      }
    }
  }
}

