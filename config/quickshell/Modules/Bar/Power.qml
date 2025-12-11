import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import "../.."

Item {
  id: root
  width: 30
  height: 30

  property var theme: Theme {}

  Rectangle {
    anchors.fill: parent
    color: "transparent"

    Text {
      anchors.centerIn: parent
      text: " "
      font.family: theme.fontFamily
      font.pixelSize: theme.fontSize
      color: theme.colAccent
    }
  }

  MouseArea {
    anchors.fill: parent
    onClicked: power.startDetached()
  }

  Process {
    id: power
    command: [ "sh", "-c", "qs ipc call powermenu toggle" ]
  }
}

