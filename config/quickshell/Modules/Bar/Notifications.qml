import QtQuick
import Quickshell.Io
import QtQuick.Effects

Item {
  id: notificationsbutton
  implicitWidth: icon.implicitWidth
  implicitHeight: icon.implicitHeight
  anchors.verticalCenter: parent.verticalCenter

  Text {
    id: icon
    text: "󰂚"
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
    id: openNotifications
    command: [ "swaync-client", "-t", "-swb" ]
  }

  MouseArea {
    anchors.fill: parent
    onClicked: openNotifications.startDetached()
  }
}
