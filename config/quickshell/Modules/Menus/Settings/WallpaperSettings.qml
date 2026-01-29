import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.Components
import qs.Services
import qs.Themes

ColumnLayout {
    id: wallpaperPane
    spacing: 15

    property bool active: false
    
    property string wallpaperDir: Quickshell.env("HOME") + "/Pictures/wallpapers"
    property var wallpaperList: []

    readonly property string folderName: Theme.activeId.charAt(0).toUpperCase() + Theme.activeId.slice(1)
    property string themeWallpaperDir: Quickshell.env("HOME") + "/.config/hyprnosis/wallpapers/" + folderName
    property var themeWallpaperList: []

    Process {
        id: scanWallpapers
        command: ["find", "-L", wallpaperPane.wallpaperDir, "-type", "f", "!", "-name", ".*"]
        running: wallpaperPane.active
        stdout: StdioCollector {
            onStreamFinished: {
                const wallList = text.trim().split('\n').filter(p => p.length > 0);
                wallpaperPane.wallpaperList = wallList;
            }
        }
    }

    Process {
        id: scanThemeWallpapers
        command: ["find", "-L", wallpaperPane.themeWallpaperDir, "-type", "f", "!", "-name", ".*"]
        running: wallpaperPane.active
        stdout: StdioCollector {
            onStreamFinished: {
                const wallList = text.trim().split('\n').filter(p => p.length > 0);
                wallpaperPane.themeWallpaperList = wallList;
            }
        }
    }

    ScrollView {
        id: scrollRoot
        Layout.fillWidth: true
        Layout.fillHeight: true
        clip: true
        ScrollBar.vertical.policy: ScrollBar.AsNeeded

        ColumnLayout {
            width: scrollRoot.width
            spacing: 15

            ColumnLayout {
                spacing: 10
                Layout.fillWidth: true

                RowLayout {
                    spacing: 10
                    Text { 
                        text: "Custom Wallpapers"
                        color: Theme.colAccent
                        font.pointSize: 14
                        font.family: Theme.fontFamily
                    }
                    Text {
                        text: "~/Pictures/wallpapers"
                        color: Theme.colMuted
                        font.pointSize: 14
                        font.family: Theme.fontFamily
                    }
                }
                DividerLine { Layout.fillWidth: true }
            }

            GridView {
                id: customGrid
                Layout.fillWidth: true
                Layout.preferredHeight: 320
                interactive: true
                clip: true
                cellWidth:  225
                cellHeight: 160
                model: wallpaperPane.wallpaperList
                delegate: wallpaperDelegate
            }

            ColumnLayout {
                spacing: 10
                Layout.fillWidth: true

                RowLayout {
                    spacing: 10
                    Text { 
                        text: "Theme Wallpapers"
                        color: Theme.colAccent
                        font.pointSize: 14
                        font.family: Theme.fontFamily
                    }
                    Text {
                        text: "hyprnosis/wallpapers/" + wallpaperPane.folderName
                        color: Theme.colMuted
                        font.pointSize: 14
                        font.family: Theme.fontFamily
                    }
                }
                DividerLine { Layout.fillWidth: true }
            }

            GridView {
                id: themeGrid
                Layout.fillWidth: true
                Layout.preferredHeight: 320
                interactive: true
                clip: true
                cellWidth: 225
                cellHeight: 160
                model: wallpaperPane.themeWallpaperList
                delegate: wallpaperDelegate
            }
        }
    }

    Component {
        id: wallpaperDelegate
        Item {
            width: GridView.view.cellWidth
            height: GridView.view.cellHeight

            Rectangle {
                id: imageBox
                anchors.centerIn: parent
                width: 215
                height: 150
                color: "transparent"
                border.color: wallMouse.containsMouse ? Theme.colAccent : "transparent"
                border.width: 1
                radius: 15

                ClippingRectangle {
                    id: clipImage
                    anchors.fill: imageBox
                    anchors.margins: 2
                    color: "transparent"
                    radius: 15
                    
                    Image {
                        anchors.fill: parent
                        source: "file://" + modelData
                        fillMode: Image.PreserveAspectCrop
                        asynchronous: true
                        smooth: true
                    }
                }

                MouseArea {
                    id: wallMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        Config.updateWallpaper(modelData);
                        Quickshell.execDetached([
                            Quickshell.env("HOME") + "/.config/hyprnosis/modules/style/wallpaper_changer.sh",
                            modelData
                        ]);
                    }
                }
            }
        }
    }
}
