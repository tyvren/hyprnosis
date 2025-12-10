// Clock.qml
import QtQuick
import qs.Services

Text {
  text: Time.time
  font.family: theme.fontFamily
  font.pixelSize: theme.fontSize
  color: theme.colAccent
}
