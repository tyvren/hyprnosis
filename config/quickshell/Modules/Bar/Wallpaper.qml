import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.Themes

PanelWindow {
  id: backgroundLayer
  color: "transparent"

  property var modelData
  
  anchors {
    top: true
    bottom: true
    left: true
    right: true
  }
  screen: modelData
  exclusionMode: ExclusionMode.Ignore
  WlrLayershell.layer: WlrLayer.Bottom

  Image {
    id: wallpaper
    anchors.fill: parent
    source: Theme.wallpaperPath
    mipmap: true
    asynchronous: true
    fillMode: Image.PreserveAspectCrop
  }
}
