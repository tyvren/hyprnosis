import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick.Effects

ColumnLayout {
  Repeater {
    model: 9

    Item {
      id: wsbutton
      implicitWidth: icon.implicitWidth
      implicitHeight: icon.implicitHeight

      property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
      property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

      Text {
        id: icon
        text: ""
        color: isActive ? theme.colAccent : (ws ? theme.colMuted : "transparent")
        font.family: theme.fontFamily
        font.pixelSize: theme.fontSize
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

      MouseArea {
        anchors.fill: parent
        onClicked: Hyprland.dispatch("workspace " + (index + 1))
      }
    }
  }
}
