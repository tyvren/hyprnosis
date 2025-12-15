import QtQuick
import qs.Services
import QtQuick.Effects

Item {
  id: batterybutton
  implicitWidth: icon.implicitWidth
  implicitHeight: icon.implicitHeight
  anchors.verticalCenter: parent.verticalCenter
  visible: Battery.available

  Text {
    id: icon
    text: Math.round(Battery.percentage * 100) + "%"
    font.family: theme.fontFamily
    font.pixelSize: theme.fontSize
    color: theme.colAccent
    layer.enabled: true
  }

  MultiEffect {
    anchors.fill: parent
    source: icon
    shadowEnabled: true
    shadowBlur: 0.75
    shadowOpacity: 0.75
    shadowVerticalOffset: 0
    shadowHorizontalOffset: 1
  }
}
