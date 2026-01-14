import QtQuick
import QtQuick.Effects
import Quickshell.Io
import qs.Themes

Item {
  id: audiobutton
  implicitWidth: icon.implicitWidth
  implicitHeight: icon.implicitHeight

  Text {
    id: icon
    text: ""
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
    id: openAudio
    command: ["pavucontrol"]
  }

  MouseArea {
    anchors.fill: parent
    onClicked: openAudio.startDetached()
  }
}
