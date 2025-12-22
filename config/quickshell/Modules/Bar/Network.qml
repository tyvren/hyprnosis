import QtQuick
import Quickshell.Io
import QtQuick.Effects

Item {
  id: networkbutton
  implicitWidth: icon.implicitWidth
  implicitHeight: icon.implicitHeight

  Text {
    id: icon
    text: ""
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
    shadowBlur: 1
    shadowOpacity: 0.50
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
