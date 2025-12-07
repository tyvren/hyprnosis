import QtQuick
import Quickshell.Io


Item {
  width: 30
  height: 30

  Process {
    id: openMenu
    command: [ "walker", "--provider", "menus:hyprnosismenu" ]
    }

  Rectangle {
    anchors.fill: parent
    color: "transparent"

    Text {
      anchors.centerIn: parent
      text: "  "
      font.family: theme.fontFamily
      font.pixelSize: theme.fontSize
      color: theme.colAccent
    }
  }

  MouseArea {
    anchors.fill: parent
    onClicked: {
      openMenu.startDetached()
    }
  }
}
