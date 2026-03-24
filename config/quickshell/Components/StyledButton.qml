import QtQuick
import QtQuick.Effects
import Quickshell
import qs.Themes

Item {
    id: root
    property string icon: ""
    property string text: ""
    property bool active: false
    signal clicked()
    implicitWidth: 180
    implicitHeight: 40

    Rectangle {
        anchors.fill: parent
        radius: 15
        color: (root.active || mouseArea.containsMouse) ? Theme.colAccent : "transparent"

        Text {
            id: iconText
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            text: root.icon
            font.family: Theme.fontFamily
            font.pointSize: 12
            color: (root.active || mouseArea.containsMouse) ? Theme.colBg : Theme.colAccent
        }

        Text {
            id: text
            anchors.left: iconText.right 
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            text: root.text
            font.family: Theme.fontFamily
            font.pointSize: 12
            color: (root.active || mouseArea.containsMouse) ? Theme.colBg : Theme.colAccent
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: root.clicked()
        }
    }
}
