// Clock.qml
import QtQuick

Text {
  text: Time.time
  font.family: theme.fontFamily
  font.pixelSize: theme.fontSize
  color: theme.colAccent
}
