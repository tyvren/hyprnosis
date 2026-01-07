import QtQuick
import Quickshell.Io
import QtQuick.Effects
import qs.Themes

Item {
  id: notificationsbutton
  implicitWidth: icon.implicitWidth
  implicitHeight: icon.implicitHeight

  Text {
    id: icon
    text: "󰂚"
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
    id: openNotifications
    command: ["swaync-client", "-t", "-swb"]
  }

  MouseArea {
    anchors.fill: parent
    onClicked: openNotifications.startDetached()
  }
}
