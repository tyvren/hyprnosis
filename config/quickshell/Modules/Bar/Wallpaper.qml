import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.Themes

Variants {
    model: Quickshell.screens
    
    delegate: Item {
        id: root
        required property var modelData

        PanelWindow {
            id: backgroundLayer
            color: "transparent"
            screen: root.modelData
            
            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }
            
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
    }
}
