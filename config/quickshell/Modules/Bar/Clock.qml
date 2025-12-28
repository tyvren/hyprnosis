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
    font.bold: true
    color: theme.colAccent
  }
}
