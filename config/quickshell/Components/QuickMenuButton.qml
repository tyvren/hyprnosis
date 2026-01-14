import QtQuick
import QtQuick.Effects
import Quickshell
import qs.Themes

Item {
  id: root
  property string icon: ""
  property string text: ""
  property bool isActive: false
  property alias containsMouse: mouseArea.containsMouse
  signal clicked()
  signal entered()
  implicitWidth: 225
  implicitHeight: 60

  RectangularShadow {
    anchors.centerIn: parent
    width: 225
    height: 60
    blur: 5
    spread: 1
    radius: 50
  }

  Rectangle {
    anchors.fill: parent
    radius: 50
    color: root.isActive || root.containsMouse ? Theme.colSelect : Theme.colBg
    border.width: 2
    border.color: Theme.colAccent

    Text {
      anchors.verticalCenter: parent.verticalCenter
      anchors.left: parent.left
      anchors.leftMargin: 15
      font.pointSize: 18
      font.family: Theme.fontFamily
      color: Theme.colAccent
      text: root.icon
    }

    Text {
      anchors.centerIn: parent
      font.pointSize: 14
      font.family: Theme.fontFamily
      color: Theme.colAccent
      text: root.text
    }

    MouseArea {
      id: mouseArea
      anchors.fill: parent
      hoverEnabled: true
      onEntered: root.entered()
      onClicked: root.clicked()
    }
  }
}