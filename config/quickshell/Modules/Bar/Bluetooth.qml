import QtQuick
import Quickshell.Io
import QtQuick.Effects
import qs.Themes

Item {
  id: bluetoothbutton
  implicitWidth: icon.implicitWidth
  implicitHeight: icon.implicitHeight

  Text {
    id: icon
    text: ""
    font.family: Theme.fontFamily
    font.pixelSize: Theme.fontSize
    color: Theme.colAccent
    layer.enabled: true
    visible: false
  }

  MultiEffect {
    anchors.fill: parent
    source: icon
    shadowEnabled: true
    shadowBlur: 1
    shadowOpacity: 0.50
    shadowColor: Theme.colAccent
  }

  Process {
    id: openBluetooth
    command: ["ghostty", "-e", "bluetui"]
  }

  MouseArea {
    anchors.fill: parent
    onClicked: openBluetooth.startDetached()
  }
}
