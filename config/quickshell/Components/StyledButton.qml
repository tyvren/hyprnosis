import QtQuick
import QtQuick.Effects
import Quickshell
import qs.Themes

Item {
    id: root
    property string text: ""
    property int size: 45
    property bool active: false
    signal clicked()
    implicitWidth: size
    implicitHeight: size

    RectangularShadow {
        anchors.centerIn: parent
        width: root.size
        height: root.size
        blur: 2
        spread: 1
        radius: size
        color: Theme.colAccent
    }

    Rectangle {
        anchors.fill: parent
        radius: size
        color: root.active ? Theme.colMuted : (mouseArea.containsMouse ? Theme.colSelect : Theme.colBg)
        border.color: Theme.colAccent
        border.width: 2

        Text {
            anchors.centerIn: parent
            text: root.text
            font.family: Theme.fontFamily
            font.pointSize: 16
            color: Theme.colAccent
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: root.clicked()
        }
    }
}
