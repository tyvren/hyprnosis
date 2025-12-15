import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import QtQuick.Effects
import "../.."

Item {
  id: powerbutton
  implicitWidth: icon.implicitWidth
  implicitHeight: icon.implicitHeight
  anchors.verticalCenter: parent.verticalCenter
  property var theme: Theme {}

  Text {
    id: icon
    text: ""
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

  Process {
    id: power
    command: [ "sh", "-c", "qs ipc call powermenu toggle" ]
  }

  MouseArea {
    anchors.fill: parent
    onClicked: power.startDetached()
  }
}
