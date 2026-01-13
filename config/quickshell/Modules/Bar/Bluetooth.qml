import QtQuick
import Quickshell
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
    anchors.fill: icon
    source: icon
    shadowEnabled: true
    shadowBlur: 1
    shadowOpacity: 0.50
    shadowColor: Theme.colAccent
  }

  MouseArea {
    anchors.fill: parent
    onClicked: {
      Quickshell.execDetached(["qs", "ipc", "call", "settingsmenu", "openTo", "3"])
    }
  }
}
