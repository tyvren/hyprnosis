// Sidebar.qml
import Quickshell
import QtQuick
import Quickshell.Widgets

PanelWindow {
  property var theme: Theme {}

  anchors {
    top: true
    bottom: true
    left: true
    right: false
  }

  implicitWidth: 30
  color: theme.colBg

}
