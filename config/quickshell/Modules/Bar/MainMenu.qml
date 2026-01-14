import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Io

Item {
  id: menubutton
  implicitWidth: icon.implicitWidth
  implicitHeight: icon.implicitHeight
  anchors.verticalCenter: parent.verticalCenter

  Text {
    id: icon
    text: ""
    font.family: Theme.fontFamily
    font.pixelSize: Theme.fontSize
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
    id: openMenu
    command: ["sh", "-c", "qs ipc call mainmenu toggle"]
  }

  MouseArea {
    anchors.fill: parent
    onClicked: openMenu.startDetached()
  }
}
