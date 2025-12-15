import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick.Effects

RowLayout {

  Repeater {
    model: 9

    Item {
      id: wsbutton
      implicitWidth: icon.implicitWidth
      implicitHeight: icon.implicitHeight
      anchors.verticalCenter: parent.verticalCenter

      property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
      property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

      Text {
        id: icon
        text: "  "
        color: isActive ? theme.colHilight : (ws ? theme.colAccent : "transparent")
        font.family: theme.fontFamily
        font.pixelSize: theme.fontSize
        layer.enabled: true
      }

      MultiEffect {
        anchors.fill: parent
        source: icon
        shadowEnabled: true
        shadowBlur: 0.75
        shadowOpacity: 0.75
        shadowVerticalOffset: 0
        shadowHorizontalOffset: 1
      }

      MouseArea {
        anchors.fill: parent
        onClicked: Hyprland.dispatch("workspace " + (index + 1))
      }
    }
  }
}
