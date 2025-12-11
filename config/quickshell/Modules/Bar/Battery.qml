import QtQuick
import qs.Services

Item {
  width: 30
  height: 30

  Rectangle {
    anchors.fill: parent
    color: "transparent"
    visible: Battery.available

    Text {
      anchors.centerIn: parent
      text: Math.round(Battery.percentage * 100) + "% "
      font.family: theme.fontFamily
      font.pixelSize: theme.fontSize
      color: theme.colAccent
    }
  }
}
