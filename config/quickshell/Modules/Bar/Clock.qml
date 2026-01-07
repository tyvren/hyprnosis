import QtQuick
import QtQuick.Effects
import qs.Themes
import qs.Services

Item {
  id: clockWrapper
  implicitWidth: clock.implicitWidth
  implicitHeight: clock.implicitHeight

  Text {
    id: clock
    text: Time.time
    font.family: Theme.fontFamily
    font.pixelSize: Theme.fontSize
    font.bold: true
    color: Theme.colAccent
  }
}
