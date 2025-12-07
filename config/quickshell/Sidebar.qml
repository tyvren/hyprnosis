import Quickshell
import QtQuick
import Quickshell.Widgets

PanelWindow {
  color: "transparent"
  implicitWidth: 30
  property var theme: Theme {} 

  anchors {
    top: true
    bottom: true
    left: true
    right: false
  }

  Rectangle {
    anchors.fill: parent

    radius: 10
    color: theme.colBg
  }
}
