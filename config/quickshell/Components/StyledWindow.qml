import Quickshell
import QtQuick
import QtQuick.Effects

PanelWindow {
  id: windowPanel
  visible: false
  color: "transparent"
  property var theme: Theme {}

  anchors {
    top: true
    bottom: true
    left: true
    right: true
  }

  RectangularShadow {
    id: windowShadow
    anchors.centerIn: parent
    width: 800
    height: 900
    blur: 10
    spread: 0
    radius: 10
    color: "transparent"
  }
  Rectangle {
    id: window
    anchors.centerIn: parent
    width: 800
    height: 900
    radius: 20
    color: theme.colBg
    border.color: theme.colAccent
    border.width: 2

    Image {
      id: logoImage
      anchors.centerIn: window
      width: 800 
      height: 800
      source: theme.logoPath
      mipmap: true
      asynchronous: true
      fillMode: Image.PreserveAspectFit
      opacity: 0.7
    }
  }
}
