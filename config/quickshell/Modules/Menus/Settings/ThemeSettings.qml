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

    Text {
        text: "Themes"
        color: Theme.colAccent
        font.pointSize: 16
        font.family: Theme.fontFamily
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

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 45

            MultiEffect {
                anchors.fill: themeButtons
                source: themeButtons
                shadowEnabled: true
                shadowBlur: 0.2
                shadowColor: Theme.colAccent
                shadowVerticalOffset: 1
                shadowHorizontalOffset: 0
                opacity: 0.8
            }

            Rectangle {
                id: themeButtons
                anchors.fill: parent
                radius: 10
                color: (themeSettings.theme === modelData.themeId || themeArea.containsMouse) ? Theme.colAccent : Theme.colMuted

                Row {
                    id: colorRow
                    anchors.left: parent.left
                    anchors.leftMargin: 12
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
                            radius: 15
                            color: modelData
                            border.color: "white"
                            border.width: 1
                        }
                    }
                }

                Text {
                    anchors.centerIn: parent
                    text: modelData.name
                    color: (themeSettings.theme === modelData.themeId || themeArea.containsMouse) ? Theme.colBg : Theme.colText
                    font.pointSize: 12
                    font.family: Theme.fontFamily
                }

                MouseArea {
                    id: themeArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        Config.updateTheme(modelData.themeId, modelData.script)
                        Config.updateWallpaper("")
                    }
                }
            }
        }
    }

    Item { Layout.preferredHeight: 10 }

    Text {
        text: "Transparency"
        color: Theme.colAccent
        font.pointSize: 16
        font.family: Theme.fontFamily
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

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 35
                radius: 8
                color: (Config.data.qsTransparency == modelData.value) ? Theme.colAccent : Theme.colMuted
                border.width: 1
                border.color: (Config.data.qsTransparency == modelData.value) ? Theme.colAccent : "transparent"

                Text {
                    anchors.centerIn: parent
                    text: modelData.label
                    color: (Config.data.qsTransparency == modelData.value) ? Theme.colBg : Theme.colText
                    font.family: Theme.fontFamily
                    font.pixelSize: 12
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Config.data.qsTransparency = modelData.value
                }
            }
        }
    }

    Item { Layout.fillHeight: true }
}
