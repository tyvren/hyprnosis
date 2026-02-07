import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import qs.Components
import qs.Themes
import qs.Services

ColumnLayout {
    id: barSettings
    spacing: 10

    property string barLayout: Config.data.barLayout

    Text {
        text: "Shell Configuration"
        color: Theme.colAccent
        font.pointSize: 16
        font.family: Theme.fontFamily
    }

    DividerLine {
        Layout.fillWidth: true
    }

    Repeater {
        model: [
            { name: "Side Bars", value: "side", icon: "" },
            { name: "Top Bar", value: "top", icon: "󰛼" }
        ]

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 45

            MultiEffect {
                anchors.fill: layoutButton
                source: layoutButton
                shadowEnabled: true
                shadowBlur: 0.2
                shadowColor: Theme.colAccent
                shadowVerticalOffset: 1
                shadowHorizontalOffset: 0
                opacity: 0.8
            }

            Rectangle {
                id: layoutButton
                anchors.fill: parent
                radius: 10
                color: (barSettings.barLayout === modelData.value || layoutArea.containsMouse) ? Theme.colAccent : Theme.colMuted

                Row {
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 12
                    
                    Text {
                        text: modelData.icon
                        color: (barSettings.barLayout === modelData.value || layoutArea.containsMouse) ? Theme.colBg : Theme.colText
                        font.pointSize: 16
                    }
                }

                Text {
                    anchors.centerIn: parent
                    text: modelData.name
                    color: (barSettings.barLayout === modelData.value || layoutArea.containsMouse) ? Theme.colBg : Theme.colText
                    font.pointSize: 12
                    font.family: Theme.fontFamily
                }

                MouseArea {
                    id: layoutArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        barSettings.barLayout = modelData.value
                    }
                }
            }
        }
    }

    Item { Layout.fillHeight: true }

    Item {
        id: applyBtn
        Layout.alignment: Qt.AlignRight
        Layout.preferredWidth: 90
        Layout.preferredHeight: 35

        MultiEffect {
            anchors.fill: applyBtnRect 
            source: applyBtnRect
            shadowEnabled: true 
            shadowBlur: 0.2 
            shadowColor: Theme.colAccent
            shadowVerticalOffset: 1 
            shadowHorizontalOffset: 0 
            opacity: 0.8
        }

        Rectangle {
            id: applyBtnRect
            anchors.fill: parent
            radius: 10
            color: applyMa.containsMouse ? Theme.colAccent : Theme.colMuted

            Text {
                anchors.centerIn: parent
                text: "Apply"
                color: applyMa.containsMouse ? Theme.colBg : Theme.colText
                font.bold: true
                font.family: Theme.fontFamily
            }

            MouseArea {
                id: applyMa 
                anchors.fill: parent 
                hoverEnabled: true

                onClicked: {
                    Config.data.barLayout = barSettings.barLayout
                }
            }
        }
    }
}
