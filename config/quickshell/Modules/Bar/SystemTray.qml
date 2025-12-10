import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets

RowLayout {

    Repeater {
        model: 

        Rectangle {
            width: 30
            height: 30
            color: "transparent"

            property var win: modelData

            Text {
              anchors.fill: parent
              text: win.title
              color: theme.colAccent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: win.focus()
            }
        }
    }
}
