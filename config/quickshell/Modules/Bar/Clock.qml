import QtQuick
import QtQuick.Effects
import qs.Services

Item {
  id: clockWrapper
  implicitWidth: clock.implicitWidth
  implicitHeight: clock.implicitHeight

  Text {
    id: clock
    text: Time.time
    font.family: theme.fontFamily
    font.pixelSize: theme.fontSize
    color: theme.colAccent
    layer.enabled: true
    visible: false
  }

  MultiEffect {
    anchors.fill: parent
    source: clock
    shadowEnabled: true
    shadowBlur: 0.75
    shadowOpacity: 0.75
    shadowVerticalOffset: 0
    shadowHorizontalOffset: 1
  }
}
