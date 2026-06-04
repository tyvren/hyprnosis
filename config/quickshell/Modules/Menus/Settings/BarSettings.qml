import QtQuick
import QtQuick.Controls
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
    property bool sysMonitor: Config.data.sysMonitor === "true"

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
                { name: "Bottom Bar", value: "bottom", icon: "󱂩" }
                //{ name: "Left Bar", value: "left", icon: "󱂪" },
                //{ name: "Right Bar", value: "right", icon: "󱂫" }
            ]

            StyledButton {
                Layout.fillWidth: true
                Layout.preferredHeight: 45
                text: modelData.name
                icon: modelData.icon
                active: barSettings.barLayout === modelData.value

                onClicked: {
                    barSettings.barLayout = modelData.value
                    Config.data.barLayout = barSettings.barLayout
                }
            }
        }
    }
    
    ColumnLayout {
        spacing: 15
        Layout.fillWidth: true
        Layout.topMargin: 10

        Text { 
            text: "System Monitor" 
            color: Theme.colAccent
            font.pointSize: 10
            font.family: Theme.fontFamily 
            font.bold: true
        }

        RowLayout {
            Layout.fillWidth: true
            
            Text {
                text: "Enable Monitoring"
                color: Theme.colText
                font.family: Theme.fontFamily
                Layout.fillWidth: true
            }

            StyledSwitch {
                id: sysMonitorToggle
                checked: barSettings.sysMonitor
                onToggled: {
                    barSettings.sysMonitor = checked
                    Config.data.sysMonitor = checked ? "true" : "false"
                }
            }
        }
    }

    Item { Layout.fillHeight: true }
}
