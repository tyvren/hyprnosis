import QtQuick
import Quickshell.Io
import QtQuick.Effects
import qs.Themes

Item {
  id: networkbutton
  implicitWidth: icon.implicitWidth
  implicitHeight: icon.implicitHeight

  Text {
    id: icon
    text: ""
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
    id: openNetwork
    command: ["ghostty", "-e", "impala"]
  }

  MouseArea {
    anchors.fill: parent
    onClicked: openNetwork.startDetached()
  }
}
