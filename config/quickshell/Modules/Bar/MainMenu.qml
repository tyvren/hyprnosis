// MainMenu.qml
import QtQuick
import Quickshell.Io


Item {
  width: 30
  height: 30

  Process {
    id: openMenu
    command: [ "sh", "-c", "qs ipc call menu toggle" ]
    }

  Rectangle {
    anchors.fill: parent
    anchors.margins: 2
    color: "transparent" 
    radius: 10

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
