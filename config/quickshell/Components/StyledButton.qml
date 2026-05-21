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

    MultiEffect {
        anchors.fill: button
        source: button
        shadowEnabled: true
        shadowBlur: 0.2
        shadowColor: Theme.colAccent
        shadowVerticalOffset: 1
        shadowHorizontalOffset: 0
        opacity: 0.8
    }

    Rectangle {
        id: button
        anchors.fill: parent
        radius: 10
        color: (root.active || mouseArea.containsMouse) ? Theme.colAccent : Theme.colMuted

        Row {
            anchors.left: parent.left
            anchors.leftMargin: 16
            anchors.verticalCenter: parent.verticalCenter
            spacing: 12

            Text {
                text: root.icon
                font.family: Theme.fontFamily
                font.pointSize: 12
                color: (root.active || mouseArea.containsMouse) ? Theme.colBg : Theme.colText
            }
        }

        Text {
            anchors.centerIn: parent
            text: root.text
            font.family: Theme.fontFamily
            font.pointSize: 12
            color: (root.active || mouseArea.containsMouse) ? Theme.colBg : Theme.colText
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: root.clicked()
        }
    }
}
