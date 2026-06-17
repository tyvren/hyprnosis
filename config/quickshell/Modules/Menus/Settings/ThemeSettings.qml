import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.Components
import qs.Services
import qs.Themes

ColumnLayout {
    id: themeSettings
    spacing: 10

    property string theme: Config.data.theme

    StyledText {
        text: "Themes"
        color: Theme.colAccent
        size: 16
    }

    DividerLine {
        Layout.fillWidth: true
    }

    Repeater {
        model: [ 
            { name: "Hyprnosis",  themeId: "hyprnosis",  script: "Hyprnosis" },
            { name: "Mocha",      themeId: "mocha",      script: "Mocha" },
            { name: "Emberforge", themeId: "emberforge", script: "Emberforge" },
            { name: "Dracula",    themeId: "dracula",    script: "Dracula" },
            { name: "Arcadia",    themeId: "arcadia",    script: "Arcadia" },
            { name: "Eden",       themeId: "eden",       script: "Eden" },
            { name: "Ghost",      themeId: "ghost",      script: "Ghost" }
        ]

        StyledButton {
            id: btnShell
            Layout.fillWidth: true
            Layout.preferredHeight: 45
            text: modelData.name
            active: themeSettings.theme === modelData.themeId

            onClicked: {
                Config.updateTheme(modelData.themeId, modelData.script)
                Config.updateWallpaper("")
            }

            Row {
                anchors.left: parent.left
                anchors.leftMargin: 22
                anchors.verticalCenter: parent.verticalCenter
                spacing: 4

                Repeater {
                    model: [ 
                        Theme.themes[modelData.themeId].colBg, 
                        Theme.themes[modelData.themeId].colAccent, 
                        Theme.themes[modelData.themeId].colHilight 
                    ]

                    Rectangle {
                        width: 15
                        height: 15
                        radius: 3
                        color: modelData
                        border.color: "white"
                        border.width: 1
                    }
                }
            }
        }
    }

    Item { Layout.preferredHeight: 10 }

    StyledText {
        text: "Transparency"
        color: Theme.colAccent
        size: 16
    }

    DividerLine {
        Layout.fillWidth: true
    }

    RowLayout {
        Layout.fillWidth: true
        spacing: 8

        Repeater {
            model: [
                { label: "0%",   value: 0.00 },
                { label: "25%",  value: 0.25 },
                { label: "50%",  value: 0.50 },
                { label: "75%",  value: 0.75 }
            ]

            StyledButton {
                Layout.fillWidth: true
                Layout.preferredHeight: 35
                text: modelData.label
                active: Config.data.qsTransparency == modelData.value

                onClicked: {
                    Config.data.qsTransparency = modelData.value
                }
            }
        }
    }

    Item { Layout.fillHeight: true }
}
