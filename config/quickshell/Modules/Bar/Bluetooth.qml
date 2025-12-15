import QtQuick
import Quickshell.Io
import QtQuick.Effects

Item {
  id: bluetoothbutton
  implicitWidth: icon.implicitWidth
  implicitHeight: icon.implicitHeight
  anchors.verticalCenter: parent.verticalCenter

  Text {
    id: icon
    text: ""
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
    shadowBlur: 0.75
    shadowOpacity: 0.50
  }

  Process {
    id: openBluetooth
    command: [ "ghostty", "-e", "bluetui" ]
  }

  MouseArea {
    anchors.fill: parent
    onClicked: openBluetooth.startDetached()
  }
}
