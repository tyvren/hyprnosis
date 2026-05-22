import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.Themes

PanelWindow {
    anchors.top: true
    anchors.right: true
    margins.top: 10
    margins.right: 10 
    implicitWidth: 300
    implicitHeight: 80
    color: "transparent"
    mask: Region {}

    Item {
        anchors.fill: parent

        Rectangle {
            anchors.fill: parent
            radius: 15
            color: Theme.colBg
            border.color: Theme.colAccent
            border.width: 1
        }
    }
}
