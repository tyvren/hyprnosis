import qs
import Quickshell
import QtQuick
import QtQuick.Effects

Item {
  id: root
  property string text: ""
  property int size: 50
  signal clicked()
  implicitWidth: size
  implicitHeight: size

  RectangularShadow {
    anchors.centerIn: parent
    width: root.size
    height: root.size
    blur: 5
    spread: 1
    radius: size
    color: theme.colAccent
  }

  Rectangle {
    anchors.fill: parent
    radius: size
    color: mouseArea.containsMouse ? theme.colSelect : theme.colBg
    border.color: theme.colAccent
    border.width: 2

    Text {
      anchors.centerIn: parent
      text: root.text
      font.family: theme.fontFamily
      font.pointSize: 16
      color: theme.colAccent
    }

    MouseArea {
      id: mouseArea
      anchors.fill: parent
      hoverEnabled: true
      onClicked: root.clicked()
    }
  }
}
