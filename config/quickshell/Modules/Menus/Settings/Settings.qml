import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland
import qs.Components
import qs.Services
import qs.Themes

PanelWindow {
    id: settingsMenu
    visible: false
    implicitWidth: 825
    implicitHeight: 900
    color: "transparent"
    focusable: true
    property int activeIndex: 0

    IpcHandler {
        target: "settingsMenu"
    
        function toggle(): void { 
            if (!settingsMenu.visible) {
                settingsMenu.activeIndex = 0
            }
            settingsMenu.visible = !settingsMenu.visible 
        }

        function openTo(index: int): void {
            settingsMenu.activeIndex = index
            settingsMenu.visible = true
        }
    }

    Rectangle {
        id: menuWindow
        anchors.fill: parent
        width: 825
        height: 900
        radius: 15
        color: Theme.colBg
        border.color: Theme.colAccent
        border.width: 1

        RowLayout {
            anchors.centerIn: parent
            spacing: 10
            width: parent.width - 30
            height: parent.height - 30

            Rectangle {
                id: sidePane
                color: Theme.colBg
                border.color: Theme.colAccent
                Layout.preferredWidth: 65
                Layout.fillHeight: true
                radius: 10

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10

                    Repeater {
                        model: [ 
                            {icon: "󰋼"},
                            {icon: "󰏖"},
                            {icon: "󰓃"},
                            {icon: "󰂯"},
                            {icon: "󰖩"},
                            {icon: "󰍹"},
                            {icon: ""},
                            {icon: "󰸉"},
                            {icon: ""},
                            {icon: ""},
                            {icon: "󰚰"}
                        ]

                        StyledButton {
                            text: modelData.icon
                            size: 45
                            active: settingsMenu.activeIndex === index
                            onClicked: settingsMenu.activeIndex = index
                        }
                    }

                    Item { Layout.fillHeight: true }

                    StyledButton {
                        text: "󰅙"
                        size: 45
                        onClicked: settingsMenu.visible = false
                    }
                }
            }

            Rectangle {
                id: contentPane
                color: Theme.colBg
                border.color: Theme.colAccent
                Layout.fillWidth: true
                Layout.fillHeight: true
                radius: 10

                LazyLoader {
                    id: menuLoader
                    active: settingsMenu.visible
                    
                    StackLayout {
                        parent: contentPane
                        anchors.fill: parent
                        anchors.margins: 15
                        currentIndex: settingsMenu.activeIndex

                        SystemInfo {
                            active: settingsMenu.visible && settingsMenu.activeIndex === 0
                        }
                        AppSettings {}
                        AudioSettings {}
                        BluetoothSettings {}
                        NetworkSettings {}
                        DisplaySettings {
                            active: settingsMenu.visible && settingsMenu.activeIndex === 5
                        }
                        ThemeSettings {}
                        WallpaperSettings {
                            active: settingsMenu.visible && settingsMenu.activeIndex === 7
                        }
                        HyprSettings {}
                        Keybinds {}
                        UpdateSettings {}
                    }
                }
            }
        }
    }
}
