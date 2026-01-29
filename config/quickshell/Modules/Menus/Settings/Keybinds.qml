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
    id: keybinds 
    spacing: 20
    Layout.fillWidth: true

    property string mainMod: Config.data.mainMod
    property string terminal: Config.data.terminal
    property string fileManager: Config.data.fileManager
    property string appLauncher: Config.data.appLauncher
    property string killActive: Config.data.killActive
    property string toggleFloating: Config.data.toggleFloating
    property string toggleSplit: Config.data.toggleSplit
    property string pseudo: Config.data.pseudo 
    property string lockScreen: Config.data.lockScreen
    property string screenshot: Config.data.screenshot
    property string enableIdle: Config.data.enableIdle
    property string disableIdle: Config.data.disableIdle

    property string focusLeft: Config.data.focusLeft
    property string focusRight: Config.data.focusRight
    property string focusUp: Config.data.focusUp
    property string focusDown: Config.data.focusDown

    ColumnLayout {
        spacing: 10
        Layout.fillWidth: true

        Text {
            text: "Keybinds"
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
                text: "General Bindings" 
                color: Theme.colAccent
                font.pointSize: 10 
                font.family: Theme.fontFamily 
                font.bold: true
            }

            RowLayout {
                Layout.fillWidth: true
                Text { 
                    text: "Main Modifier"
                    color: Theme.colText
                    font.family: Theme.fontFamily
                    Layout.fillWidth: true 
                }
                StyledInput { 
                    text: keybinds.mainMod
                    onUserEdited: (val) => keybinds.mainMod = val 
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Text { 
                    text: "Terminal"
                    color: Theme.colText
                    font.family: Theme.fontFamily
                    Layout.fillWidth: true 
                }
                Text {
                    text: "mainMod +"
                    color: Theme.colAccent
                    font.family: Theme.fontFamily
                    font.pixelSize: 11
                    verticalAlignment: Text.AlignVCenter
                }
                StyledInput { 
                    text: keybinds.terminal
                    onUserEdited: (val) => keybinds.terminal = val 
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Text { 
                    text: "File Manager"
                    color: Theme.colText
                    font.family: Theme.fontFamily
                    Layout.fillWidth: true 
                }
                Text {
                    text: "mainMod +"
                    color: Theme.colAccent
                    font.family: Theme.fontFamily
                    font.pixelSize: 11
                    verticalAlignment: Text.AlignVCenter
                }
                StyledInput { 
                    text: keybinds.fileManager
                    onUserEdited: (val) => keybinds.fileManager = val 
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Text { 
                    text: "App Launcher"
                    color: Theme.colText
                    font.family: Theme.fontFamily
                    Layout.fillWidth: true 
                }
                Text {
                    text: "mainMod +"
                    color: Theme.colAccent
                    font.family: Theme.fontFamily
                    font.pixelSize: 11
                    verticalAlignment: Text.AlignVCenter
                }
                StyledInput { 
                    text: keybinds.appLauncher
                    onUserEdited: (val) => keybinds.appLauncher = val 
                }
            }
        }

        ColumnLayout {
            spacing: 15
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop

            Text { 
                text: "Window Management" 
                color: Theme.colAccent
                font.pointSize: 10 
                font.family: Theme.fontFamily 
                font.bold: true
            }

            RowLayout {
                Layout.fillWidth: true
                Text { 
                    text: "Kill Active"
                    color: Theme.colText
                    font.family: Theme.fontFamily
                    Layout.fillWidth: true 
                }
                Text {
                    text: "mainMod +"
                    color: Theme.colAccent
                    font.family: Theme.fontFamily
                    font.pixelSize: 11
                    verticalAlignment: Text.AlignVCenter
                }
                StyledInput { 
                    text: keybinds.killActive
                    onUserEdited: (val) => keybinds.killActive = val 
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Text { 
                    text: "Toggle Floating"
                    color: Theme.colText
                    font.family: Theme.fontFamily
                    Layout.fillWidth: true 
                }
                Text {
                    text: "mainMod +"
                    color: Theme.colAccent
                    font.family: Theme.fontFamily
                    font.pixelSize: 11
                    verticalAlignment: Text.AlignVCenter
                }
                StyledInput { 
                    text: keybinds.toggleFloating
                    onUserEdited: (val) => keybinds.toggleFloating = val 
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Text { 
                    text: "Toggle Split"
                    color: Theme.colText
                    font.family: Theme.fontFamily
                    Layout.fillWidth: true 
                }
                Text {
                    text: "mainMod +"
                    color: Theme.colAccent
                    font.family: Theme.fontFamily
                    font.pixelSize: 11
                    verticalAlignment: Text.AlignVCenter
                }
                StyledInput { 
                    text: keybinds.toggleSplit
                    onUserEdited: (val) => keybinds.toggleSplit = val 
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Text { 
                    text: "Pseudo"
                    color: Theme.colText
                    font.family: Theme.fontFamily
                    Layout.fillWidth: true 
                }
                Text {
                    text: "mainMod +"
                    color: Theme.colAccent
                    font.family: Theme.fontFamily
                    font.pixelSize: 11
                    verticalAlignment: Text.AlignVCenter
                }
                StyledInput { 
                    text: keybinds.pseudo
                    onUserEdited: (val) => keybinds.pseudo = val 
                }
            }
        }

        ColumnLayout {
            spacing: 15
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop

            Text { 
                text: "System Controls" 
                color: Theme.colAccent 
                font.pointSize: 10 
                font.family: Theme.fontFamily 
                font.bold: true
            }

            RowLayout {
                Layout.fillWidth: true
                Text { 
                    text: "Lock Screen"
                    color: Theme.colText
                    font.family: Theme.fontFamily
                    Layout.fillWidth: true 
                }
                Text {
                    text: "mainMod +"
                    color: Theme.colAccent
                    font.family: Theme.fontFamily
                    font.pixelSize: 11
                    verticalAlignment: Text.AlignVCenter
                }
                StyledInput { 
                    text: keybinds.lockScreen
                    onUserEdited: (val) => keybinds.lockScreen = val 
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Text { 
                    text: "Screenshot"
                    color: Theme.colText
                    font.family: Theme.fontFamily
                    Layout.fillWidth: true 
                }
                Text {
                    text: "mainMod +"
                    color: Theme.colAccent
                    font.family: Theme.fontFamily
                    font.pixelSize: 11
                    verticalAlignment: Text.AlignVCenter
                }
                StyledInput { 
                    text: keybinds.screenshot
                    onUserEdited: (val) => keybinds.screenshot = val 
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Text { 
                    text: "Enable Idle"
                    color: Theme.colText
                    font.family: Theme.fontFamily
                    Layout.fillWidth: true 
                }
                Text {
                    text: "mainMod + SHIFT +"
                    color: Theme.colAccent
                    font.family: Theme.fontFamily
                    font.pixelSize: 11
                    verticalAlignment: Text.AlignVCenter
                }
                StyledInput { 
                    text: keybinds.enableIdle
                    onUserEdited: (val) => keybinds.enableIdle = val 
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Text { 
                    text: "Disable Idle"
                    color: Theme.colText
                    font.family: Theme.fontFamily
                    Layout.fillWidth: true 
                }
                Text {
                    text: "mainMod +"
                    color: Theme.colAccent
                    font.family: Theme.fontFamily
                    font.pixelSize: 11
                    verticalAlignment: Text.AlignVCenter
                }
                StyledInput { 
                    text: keybinds.disableIdle
                    onUserEdited: (val) => keybinds.disableIdle = val 
                }
            }
        }

        ColumnLayout {
            spacing: 15
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop

            Text { 
                text: "Navigation" 
                color: Theme.colAccent
                font.pointSize: 10 
                font.family: Theme.fontFamily 
                font.bold: true
            }

            RowLayout {
                Layout.fillWidth: true
                Text { 
                    text: "Focus Left"
                    color: Theme.colText
                    font.family: Theme.fontFamily
                    Layout.fillWidth: true 
                }
                Text {
                    text: "mainMod +"
                    color: Theme.colAccent
                    font.family: Theme.fontFamily
                    font.pixelSize: 11
                    verticalAlignment: Text.AlignVCenter
                }
                StyledInput { 
                    text: keybinds.focusLeft
                    onUserEdited: (val) => keybinds.focusLeft = val 
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Text { 
                    text: "Focus Right"
                    color: Theme.colText
                    font.family: Theme.fontFamily
                    Layout.fillWidth: true 
                }
                Text {
                    text: "mainMod +"
                    color: Theme.colAccent
                    font.family: Theme.fontFamily
                    font.pixelSize: 11
                    verticalAlignment: Text.AlignVCenter
                }
                StyledInput { 
                    text: keybinds.focusRight
                    onUserEdited: (val) => keybinds.focusRight = val 
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Text { 
                    text: "Focus Up"
                    color: Theme.colText
                    font.family: Theme.fontFamily
                    Layout.fillWidth: true 
                }
                Text {
                    text: "mainMod +"
                    color: Theme.colAccent
                    font.family: Theme.fontFamily
                    font.pixelSize: 11
                    verticalAlignment: Text.AlignVCenter
                }
                StyledInput { 
                    text: keybinds.focusUp
                    onUserEdited: (val) => keybinds.focusUp = val 
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Text { 
                    text: "Focus Down"
                    color: Theme.colText
                    font.family: Theme.fontFamily
                    Layout.fillWidth: true 
                }
                Text {
                    text: "mainMod +"
                    color: Theme.colAccent
                    font.family: Theme.fontFamily
                    font.pixelSize: 11
                    verticalAlignment: Text.AlignVCenter
                }
                StyledInput { 
                    text: keybinds.focusDown
                    onUserEdited: (val) => keybinds.focusDown = val 
                }
            }
        }
    }

    Item { 
        Layout.fillHeight: true 
    }

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
                    Config.data.mainMod = keybinds.mainMod
                    Config.data.terminal = keybinds.terminal
                    Config.data.fileManager = keybinds.fileManager
                    Config.data.appLauncher = keybinds.appLauncher
                    Config.data.killActive = keybinds.killActive
                    Config.data.toggleFloating = keybinds.toggleFloating
                    Config.data.toggleSplit = keybinds.toggleSplit
                    Config.data.pseudo = keybinds.pseudo
                    Config.data.lockScreen = keybinds.lockScreen
                    Config.data.screenshot = keybinds.screenshot
                    Config.data.enableIdle = keybinds.enableIdle
                    Config.data.disableIdle = keybinds.disableIdle
                    Config.data.focusLeft = keybinds.focusLeft
                    Config.data.focusRight = keybinds.focusRight
                    Config.data.focusUp = keybinds.focusUp
                    Config.data.focusDown = keybinds.focusDown

                    Quickshell.execDetached([
                        Quickshell.env("HOME") + "/.config/hyprnosis/modules/quickshell/qs_apply_keybinds.sh",
                        keybinds.mainMod,
                        keybinds.terminal,
                        keybinds.fileManager,
                        keybinds.appLauncher,
                        keybinds.killActive,
                        keybinds.toggleFloating,
                        keybinds.toggleSplit,
                        keybinds.pseudo,
                        keybinds.lockScreen,
                        keybinds.screenshot,
                        keybinds.enableIdle,
                        keybinds.disableIdle,
                        keybinds.focusLeft,
                        keybinds.focusRight,
                        keybinds.focusUp,
                        keybinds.focusDown
                    ]);
                }
            }
        }
    }
}
