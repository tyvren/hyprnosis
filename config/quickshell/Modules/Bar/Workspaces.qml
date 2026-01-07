import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick.Effects
import qs.Themes

ColumnLayout {
  spacing: 15

  Repeater {
    model: 6

    Item {
      id: wsbutton
      implicitWidth: icon.implicitWidth
      implicitHeight: icon.implicitHeight

      property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
      property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

      Text {
        id: icon
        text: ""
        color: isActive ? "transparent" : (ws ? Theme.colMuted : "transparent")
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        layer.enabled: true
        visible: false
      }

      Image {
          id: workspaceLogo
          width: 25
          height: 25
          x: -5
          source: Theme.logoPath
          mipmap: true
          asynchronous: true
          fillMode: Image.PreserveAspectFit
          layer.enabled: true
          visible: isActive
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
