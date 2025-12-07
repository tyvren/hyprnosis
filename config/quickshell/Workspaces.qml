import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Wayland

RowLayout {

  Repeater {
    model: 9

    Rectangle {
      width: 30
      height: 30
      color: "transparent"

      Text {
        anchors.centerIn: parent

        property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
        property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

        text: index + 1
        color: isActive ? theme.colHilight : (ws ? theme.colAccent : "transparent")
        font.family: theme.fontFamily
        font.pixelSize: theme.fontSize

        Layout.preferredWidth: 10

        MouseArea {
          anchors.fill: parent
          onClicked: Hyprland.dispatch("workspace " + (index + 1))
        }
      }
    }
  }
}
