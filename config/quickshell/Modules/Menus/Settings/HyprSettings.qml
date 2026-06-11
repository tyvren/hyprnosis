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

        StyledText {
            text: "Hyprland Configuration"
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
                size: 10 
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
                    onUserEdited: (val) => { Config.data.gapsIn = parseInt(val); hyprPane.applyHypr(); }
                }
            }

            RowLayout {
                Layout.fillWidth: true

                StyledText { 
                    text: "Gaps Out" 
                    Layout.fillWidth: true 
                }

                StyledInput { 
                    text: Config.data.gapsOut.toString()
                    onUserEdited: (val) => { Config.data.gapsOut = parseInt(val); hyprPane.applyHypr(); }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                
                StyledText { text: "Border Size" 
                    Layout.fillWidth: true 
                }

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

            StyledText { 
                text: "Decoration" 
                color: Theme.colAccent
                size: 10 
                bold: true 
            }

            RowLayout {
                Layout.fillWidth: true
                
                StyledText { 
                    text: "Rounding"
                    Layout.fillWidth: true 
                }

                StyledInput { 
                    text: Config.data.rounding.toString()
                    onUserEdited: (val) => { Config.data.rounding = parseInt(val); hyprPane.applyHypr(); }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                
                StyledText { 
                    text: "Active Opacity"
                    Layout.fillWidth: true 
                }

                StyledInput { 
                    text: Config.data.activeOpacity.toString()
                    onUserEdited: (val) => { Config.data.activeOpacity = parseFloat(val); hyprPane.applyHypr(); }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                
                StyledText { 
                    text: "Inactive Opacity"
                    Layout.fillWidth: true 
                }

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

            StyledText { 
                text: "Blur Settings" 
                color: Theme.colAccent
                size: 10 
                bold: true 
            }

            RowLayout {
                Layout.fillWidth: true
                
                StyledText { 
                  text: "Blur Enabled"
                  Layout.fillWidth: true 
                }

                StyledSwitch { 
                    checked: Config.data.blurEnabled
                    onToggled: { Config.data.blurEnabled = checked; hyprPane.applyHypr(); }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                opacity: Config.data.blurEnabled ? 1.0 : 0.4
                enabled: Config.data.blurEnabled
                
                StyledText { 
                  text: "Blur Size"
                  Layout.fillWidth: true 
                }

                StyledInput { 
                    text: Config.data.blurSize.toString()
                    onUserEdited: (val) => { Config.data.blurSize = parseInt(val); hyprPane.applyHypr(); }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                opacity: Config.data.blurEnabled ? 1.0 : 0.4
                enabled: Config.data.blurEnabled
                
                StyledText { 
                  text: "Blur Passes"
                  Layout.fillWidth: true 
                }

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

            StyledText { 
                text: "Miscellaneous" 
                color: Theme.colAccent
                size: 10
                bold: true 
            }

            RowLayout {
                Layout.fillWidth: true
                
                StyledText { 
                    text: "Tearing"
                    Layout.fillWidth: true 
                }

                StyledSwitch { 
                    checked: Config.data.allowTearing
                    onToggled: { Config.data.allowTearing = checked; hyprPane.applyHypr(); }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                
                StyledText { 
                    text: "Shadows"
                    Layout.fillWidth: true 
                }

                StyledSwitch {
                    checked: Config.data.shadowEnabled
                    onToggled: { Config.data.shadowEnabled = checked; hyprPane.applyHypr(); }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                
                StyledText { 
                    text: "Hyprland Logo"
                    Layout.fillWidth: true 
                }

                StyledSwitch { 
                    checked: !Config.data.disableHyprlandLogo
                    onToggled: { Config.data.disableHyprlandLogo = !checked; hyprPane.applyHypr(); }
                } 
            }

            RowLayout {
                Layout.fillWidth: true

                StyledText { 
                    text: "Force Default Wallpaper"
                    Layout.fillWidth: true 
                }

                StyledSwitch { 
                    checked: Config.data.forceDefaultWallpaper === 1
                    onToggled: { Config.data.forceDefaultWallpaper = checked ? 1 : 0; hyprPane.applyHypr(); }
                }
            }
        }
    }

    Item { Layout.fillHeight: true }
}
