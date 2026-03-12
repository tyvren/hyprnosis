import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Components
import qs.Themes
import qs.Services

ColumnLayout {
    id: hyprPane
    spacing: 20

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

        Text {
            text: "Hyprland Configuration"
            color: Theme.colAccent
            font.pointSize: 16
            font.family: Theme.fontFamily
            antialiasing: true
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

            Text { 
                text: "General Layout" 
                color: Theme.colAccent
                font.pointSize: 10 
                font.family: Theme.fontFamily 
                font.bold: true
            }

            RowLayout {
                Layout.fillWidth: true
                Text { text: "Gaps In"; color: Theme.colText; font.family: Theme.fontFamily; Layout.fillWidth: true }
                StyledInput { 
                    text: Config.data.gapsIn.toString()
                    onUserEdited: (val) => { Config.data.gapsIn = parseInt(val); hyprPane.applyHypr(); }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Text { text: "Gaps Out"; color: Theme.colText; font.family: Theme.fontFamily; Layout.fillWidth: true }
                StyledInput { 
                    text: Config.data.gapsOut.toString()
                    onUserEdited: (val) => { Config.data.gapsOut = parseInt(val); hyprPane.applyHypr(); }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Text { text: "Border Size"; color: Theme.colText; font.family: Theme.fontFamily; Layout.fillWidth: true }
                StyledInput { 
                    text: Config.data.borderSize.toString()
                    onUserEdited: (val) => { Config.data.borderSize = parseInt(val); hyprPane.applyHypr(); }
                }
            }
        }

        ColumnLayout {
            spacing: 15
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop

            Text { 
                text: "Decoration" 
                color: Theme.colAccent
                font.pointSize: 10 
                font.family: Theme.fontFamily
                font.bold: true 
            }

            RowLayout {
                Layout.fillWidth: true
                Text { text: "Rounding"; color: Theme.colText; font.family: Theme.fontFamily; Layout.fillWidth: true }
                StyledInput { 
                    text: Config.data.rounding.toString()
                    onUserEdited: (val) => { Config.data.rounding = parseInt(val); hyprPane.applyHypr(); }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Text { text: "Active Opacity"; color: Theme.colText; font.family: Theme.fontFamily; Layout.fillWidth: true }
                StyledInput { 
                    text: Config.data.activeOpacity.toString()
                    onUserEdited: (val) => { Config.data.activeOpacity = parseFloat(val); hyprPane.applyHypr(); }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Text { text: "Inactive Opacity"; color: Theme.colText; font.family: Theme.fontFamily; Layout.fillWidth: true }
                StyledInput { 
                    text: Config.data.inactiveOpacity.toString()
                    onUserEdited: (val) => { Config.data.inactiveOpacity = parseFloat(val); hyprPane.applyHypr(); }
                }
            }
        }

        ColumnLayout {
            spacing: 15
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop

            Text { 
                text: "Blur Settings" 
                color: Theme.colAccent
                font.pointSize: 10 
                font.family: Theme.fontFamily 
                font.bold: true 
            }

            RowLayout {
                Layout.fillWidth: true
                Text { text: "Blur Enabled"; color: Theme.colText; font.family: Theme.fontFamily; Layout.fillWidth: true }
                StyledSwitch { 
                    checked: Config.data.blurEnabled
                    onToggled: { Config.data.blurEnabled = checked; hyprPane.applyHypr(); }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                opacity: Config.data.blurEnabled ? 1.0 : 0.4
                enabled: Config.data.blurEnabled
                Text { text: "Blur Size"; color: Theme.colText; font.family: Theme.fontFamily; Layout.fillWidth: true }
                StyledInput { 
                    text: Config.data.blurSize.toString()
                    onUserEdited: (val) => { Config.data.blurSize = parseInt(val); hyprPane.applyHypr(); }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                opacity: Config.data.blurEnabled ? 1.0 : 0.4
                enabled: Config.data.blurEnabled
                Text { text: "Blur Passes"; color: Theme.colText; font.family: Theme.fontFamily; Layout.fillWidth: true }
                StyledInput { 
                    text: Config.data.blurPasses.toString()
                    onUserEdited: (val) => { Config.data.blurPasses = parseInt(val); hyprPane.applyHypr(); }
                }
            }
        }

        ColumnLayout {
            spacing: 15
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop

            Text { 
                text: "Miscellaneous" 
                color: Theme.colAccent
                font.pointSize: 10 
                font.family: Theme.fontFamily 
                font.bold: true 
            }

            RowLayout {
                Layout.fillWidth: true
                Text { text: "Tearing"; color: Theme.colText; font.family: Theme.fontFamily; Layout.fillWidth: true }
                StyledSwitch { 
                    checked: Config.data.allowTearing
                    onToggled: { Config.data.allowTearing = checked; hyprPane.applyHypr(); }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Text { text: "Shadows"; color: Theme.colText; font.family: Theme.fontFamily; Layout.fillWidth: true }
                StyledSwitch {
                    checked: Config.data.shadowEnabled
                    onToggled: { Config.data.shadowEnabled = checked; hyprPane.applyHypr(); }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Text { text: "Hyprland Logo"; color: Theme.colText; font.family: Theme.fontFamily; Layout.fillWidth: true }
                StyledSwitch { 
                    checked: !Config.data.disableHyprlandLogo
                    onToggled: { Config.data.disableHyprlandLogo = !checked; hyprPane.applyHypr(); }
                } 
            }

            RowLayout {
                Layout.fillWidth: true
                Text { text: "Force Default Wallpaper"; color: Theme.colText; font.family: Theme.fontFamily; Layout.fillWidth: true }
                StyledSwitch { 
                    checked: Config.data.forceDefaultWallpaper === 1
                    onToggled: { Config.data.forceDefaultWallpaper = checked ? 1 : 0; hyprPane.applyHypr(); }
                }
            }
        }
    }

    Item { Layout.fillHeight: true }
}
