import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import qs.Components
import qs.Themes
import qs.Services

ColumnLayout {
    id: barSettings
    spacing: 15

    property string barLayout: Config.data.barLayout
    property int barRadius: Config.data.barRadius
    property int barMargin: Config.data.barMargin

    Text {
        text: "Bar Layout"
        color: Theme.colAccent
        font.pointSize: 16
        font.family: Theme.fontFamily
    }

    DividerLine {
        Layout.fillWidth: true
    }

    GridLayout {
        columns: 2
        Layout.fillWidth: true
        rowSpacing: 10
        columnSpacing: 10

        Repeater {
            model: [
                { name: "Top Bar", value: "top", icon: "󱔓" },
                { name: "Bottom Bar", value: "bottom", icon: "󱂩" },
                { name: "Left Bar", value: "left", icon: "󱂪" },
                { name: "Right Bar", value: "right", icon: "󱂫" }
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
                            Config.data.barLayout = barSettings.barLayout
                        }
                    }
                }
            }
        }
    }

    ColumnLayout {
        spacing: 15
        Layout.fillWidth: true
        Layout.topMargin: 10

        Text { 
            text: "Geometry" 
            color: Theme.colAccent
            font.pointSize: 10 
            font.family: Theme.fontFamily 
            font.bold: true
        }

        RowLayout {
            Layout.fillWidth: true
            Text { 
                text: "Bar Radius"
                color: Theme.colText
                font.family: Theme.fontFamily
                Layout.fillWidth: true 
            }
            StyledInput { 
                text: barSettings.barRadius.toString()
                onUserEdited: (val) => Config.data.barRadius = parseInt(val) 
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Text { 
                text: "Bar Margins"
                color: Theme.colText
                font.family: Theme.fontFamily
                Layout.fillWidth: true 
            }
            StyledInput { 
                text: barSettings.barMargin.toString()
                onUserEdited: (val) => Config.data.barMargin = parseInt(val) 
            }
        }
    }

    Item { Layout.fillHeight: true }
}
