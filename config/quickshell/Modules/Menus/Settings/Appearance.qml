import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.Components
import qs.Themes
import qs.Services

ScrollView {
    id: scrollRoot
    Layout.fillWidth: true
    Layout.fillHeight: true
    clip: true
    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
    ScrollBar.vertical.policy: ScrollBar.AsNeeded

    ColumnLayout {
        id: appearancePane
        width: scrollRoot.width
        spacing: 15

        property string barLayout: Config.data.barLayout
        property bool sysMonitor: Config.data.sysMonitor === "true"
        property string theme: Config.data.theme

        function applyHypr() {
            Quickshell.execDetached([
                Quickshell.env("HOME") + "/.config/hyprnosis/modules/quickshell/qs_apply_hyprland.sh",
                Config.data.gapsIn.toString(),
                Config.data.gapsOut.toString(),
                Config.data.borderSize.toString(),
                Config.data.rounding.toString(),
                Config.data.activeOpacity.toString(),
                Config.data.inactiveOpacity.toString(),
                Config.data.allowTearing.toString(),
                Config.data.shadowEnabled.toString(),
                Config.data.blurEnabled.toString(),
                Config.data.blurSize.toString(),
                Config.data.blurPasses.toString(),
                Config.data.disableHyprlandLogo.toString(),
                Config.data.forceDefaultWallpaper.toString()
            ]);
        }

        ColumnLayout {
            spacing: 10
            Layout.fillWidth: true

            StyledText {
                text: "Appearance"
                color: Theme.colAccent
                size: 16
            }

            DividerLine {
                Layout.fillWidth: true
            }
        }

        GridLayout {
            columns: 2
            rowSpacing: 30
            columnSpacing: 60
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter

            ColumnLayout {
                spacing: 15
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop

                StyledText {
                    text: "General Layout"
                    color: Theme.colAccent
                    size: 12
                    bold: true
                }

                RowLayout {
                    Layout.fillWidth: true

                    StyledText {
                        text: "Gaps In"
                        color: Theme.colText
                        Layout.fillWidth: true
                    }

                    StyledInput {
                        text: Config.data.gapsIn.toString()
                        onUserEdited: (val) => { Config.data.gapsIn = parseInt(val); appearancePane.applyHypr(); }
                    }
                }

                RowLayout {
                    Layout.fillWidth: true

                    StyledText {
                        text: "Gaps Out"
                        color: Theme.colText
                        Layout.fillWidth: true
                    }

                    StyledInput {
                        text: Config.data.gapsOut.toString()
                        onUserEdited: (val) => { Config.data.gapsOut = parseInt(val); appearancePane.applyHypr(); }
                    }
                }

                RowLayout {
                    Layout.fillWidth: true

                    StyledText {
                        text: "Border Size"
                        color: Theme.colText
                        Layout.fillWidth: true
                    }

                    StyledInput {
                        text: Config.data.borderSize.toString()
                        onUserEdited: (val) => { Config.data.borderSize = parseInt(val); appearancePane.applyHypr(); }
                    }
                }
            }

            ColumnLayout {
                spacing: 15
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop

                StyledText {
                    text: "Decoration"
                    color: Theme.colAccent
                    size: 12
                    bold: true
                }

                RowLayout {
                    Layout.fillWidth: true

                    StyledText {
                        text: "Rounding"
                        color: Theme.colText
                        Layout.fillWidth: true
                    }

                    StyledInput {
                        text: Config.data.rounding.toString()
                        onUserEdited: (val) => { Config.data.rounding = parseInt(val); appearancePane.applyHypr(); }
                    }
                }

                RowLayout {
                    Layout.fillWidth: true

                    StyledText {
                        text: "Active Opacity"
                        color: Theme.colText
                        Layout.fillWidth: true
                    }

                    StyledInput {
                        text: Config.data.activeOpacity.toString()
                        onUserEdited: (val) => { Config.data.activeOpacity = parseFloat(val); appearancePane.applyHypr(); }
                    }
                }

                RowLayout {
                    Layout.fillWidth: true

                    StyledText {
                        text: "Inactive Opacity"
                        color: Theme.colText
                        Layout.fillWidth: true
                    }

                    StyledInput {
                        text: Config.data.inactiveOpacity.toString()
                        onUserEdited: (val) => { Config.data.inactiveOpacity = parseFloat(val); appearancePane.applyHypr(); }
                    }
                }
            }

            ColumnLayout {
                spacing: 15
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop

                StyledText {
                    text: "Blur Settings"
                    color: Theme.colAccent
                    size: 12
                    bold: true
                }

                RowLayout {
                    Layout.fillWidth: true

                    StyledText {
                        text: "Blur Enabled"
                        color: Theme.colText
                        Layout.fillWidth: true
                    }

                    StyledSwitch {
                        checked: Config.data.blurEnabled
                        onToggled: { Config.data.blurEnabled = checked; appearancePane.applyHypr(); }
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    opacity: Config.data.blurEnabled ? 1.0 : 0.4
                    enabled: Config.data.blurEnabled

                    StyledText {
                        text: "Blur Size"
                        color: Theme.colText
                        Layout.fillWidth: true
                    }

                    StyledInput {
                        text: Config.data.blurSize.toString()
                        onUserEdited: (val) => { Config.data.blurSize = parseInt(val); appearancePane.applyHypr(); }
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    opacity: Config.data.blurEnabled ? 1.0 : 0.4
                    enabled: Config.data.blurEnabled

                    StyledText {
                        text: "Blur Passes"
                        color: Theme.colText
                        Layout.fillWidth: true
                    }

                    StyledInput {
                        text: Config.data.blurPasses.toString()
                        onUserEdited: (val) => { Config.data.blurPasses = parseInt(val); appearancePane.applyHypr(); }
                    }
                }
            }

            ColumnLayout {
                spacing: 15
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop

                StyledText {
                    text: "Miscellaneous"
                    color: Theme.colAccent
                    size: 12
                    bold: true
                }

                RowLayout {
                    Layout.fillWidth: true

                    StyledText {
                        text: "Tearing"
                        color: Theme.colText
                        Layout.fillWidth: true
                    }

                    StyledSwitch {
                        checked: Config.data.allowTearing
                        onToggled: { Config.data.allowTearing = checked; appearancePane.applyHypr(); }
                    }
                }

                RowLayout {
                    Layout.fillWidth: true

                    StyledText {
                        text: "Shadows"
                        color: Theme.colText
                        Layout.fillWidth: true
                    }

                    StyledSwitch {
                        checked: Config.data.shadowEnabled
                        onToggled: { Config.data.shadowEnabled = checked; appearancePane.applyHypr(); }
                    }
                }

                RowLayout {
                    Layout.fillWidth: true

                    StyledText {
                        text: "Hyprland Logo"
                        color: Theme.colText
                        Layout.fillWidth: true
                    }

                    StyledSwitch {
                        checked: !Config.data.disableHyprlandLogo
                        onToggled: { Config.data.disableHyprlandLogo = !checked; appearancePane.applyHypr(); }
                    }
                }

                RowLayout {
                    Layout.fillWidth: true

                    StyledText {
                        text: "Force Default Wallpaper"
                        color: Theme.colText
                        Layout.fillWidth: true
                    }

                    StyledSwitch {
                        checked: Config.data.forceDefaultWallpaper === 1
                        onToggled: { Config.data.forceDefaultWallpaper = checked ? 1 : 0; appearancePane.applyHypr(); }
                    }
                }
            }
        }

        DividerLine {
            Layout.fillWidth: true
        }

        StyledText {
            text: "Bar Layout"
            color: Theme.colAccent
            size: 12
            bold: true
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
                    active: appearancePane.barLayout === modelData.value

                    onClicked: {
                        appearancePane.barLayout = modelData.value
                        Config.data.barLayout = appearancePane.barLayout
                    }
                }
            }
        }

        DividerLine {
            Layout.fillWidth: true
        }

        StyledText {
            text: "Themes"
            color: Theme.colAccent
            size: 12
            bold: true
        }

        GridLayout {
            columns: 2
            Layout.fillWidth: true
            rowSpacing: 10
            columnSpacing: 10

            Repeater {
                model: [
                    { name: "Hyprnosis",  themeId: "hyprnosis",  script: "Hyprnosis" },
                    { name: "Mocha",      themeId: "mocha",      script: "Mocha" },
                    { name: "Emberforge", themeId: "emberforge", script: "Emberforge" },
                    { name: "Dracula",    themeId: "dracula",    script: "Dracula" },
                    { name: "Arcadia",    themeId: "arcadia",    script: "Arcadia" },
                    { name: "Eden",       themeId: "eden",       script: "Eden" },
                    { name: "Ghost",      themeId: "ghost",      script: "Ghost" },
                    { name: "Verdant",      themeId: "verdant",      script: "Verdant" }
                ]

                StyledButton {
                    id: btnShell
                    Layout.fillWidth: true
                    Layout.preferredHeight: 45
                    text: modelData.name
                    active: appearancePane.theme === modelData.themeId

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
                                radius: Config.data.rounding
                                color: modelData
                                border.color: "white"
                                border.width: Config.data.borderSize
                            }
                        }
                    }
                }
            }
        }

        DividerLine {
            Layout.fillWidth: true
        }

        StyledText {
            text: "Transparency"
            color: Theme.colAccent
            size: 12
            bold: true
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
    }
}
