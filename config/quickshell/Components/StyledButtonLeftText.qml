import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import qs.Themes

Item {
    id: root
    property string icon: ""
    property string text: ""
    property int textSize: 12
    property bool active: false
    signal clicked()

    implicitWidth: 180
    implicitHeight: 40

    MultiEffect {
        anchors.fill: buttonBackground
        source: buttonBackground
        shadowEnabled: true
        shadowBlur: (root.active || mouseArea.containsMouse) ? 0.8 : 0
        shadowColor: Theme.colAccent
        shadowVerticalOffset: 0
        shadowHorizontalOffset: 0
        opacity: (root.active || mouseArea.containsMouse) ? 1 : 1
        
        Behavior on shadowBlur { NumberAnimation { duration: 150 } }
        Behavior on opacity { NumberAnimation { duration: 150 } }
    }

    Rectangle {
        id: buttonBackground
        anchors.fill: parent
        radius: 3
        color: Theme.colBg
        border.color: Theme.colAccent
        border.width: 1

        Behavior on color { ColorAnimation { duration: 150 } }
        Behavior on border.color { ColorAnimation { duration: 150 } }

        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 8
            anchors.rightMargin: 14
            spacing: 16

            StyledText {
                text: root.icon
                size: 14
                color: (root.active || mouseArea.containsMouse) ? Theme.colAccent : Theme.colText
                visible: root.icon !== ""
                Layout.preferredWidth: 24 
                horizontalAlignment: Text.AlignHCenter
                
                Behavior on color { ColorAnimation { duration: 150 } }
            }

            StyledText {
                text: root.text
                size: root.textSize
                color: (root.active || mouseArea.containsMouse) ? Theme.colAccent : Theme.colText
                visible: root.text !== ""
                horizontalAlignment: Text.AlignLeft
                Layout.fillWidth: true
                elide: Text.ElideRight
                
                Behavior on color { ColorAnimation { duration: 150 } }
            }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: root.clicked()
        }
    }
}
