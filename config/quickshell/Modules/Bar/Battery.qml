import QtQuick
import qs.Services
import QtQuick.Effects

Item {
  id: batterybutton
  implicitWidth: icon.implicitWidth
  implicitHeight: icon.implicitHeight
  visible: Battery.available

  Text {
    id: icon
    text: Math.round(Battery.percentage * 100) + "%"
    font.family: theme.fontFamily
    font.pixelSize: theme.fontSize
    color: theme.colAccent
    layer.enabled: true
    visible: false
  }

  MultiEffect {
    anchors.fill: parent
    source: icon
    shadowEnabled: true
    shadowBlur: 1
    shadowOpacity: 0.5
  }
}
