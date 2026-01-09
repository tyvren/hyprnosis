import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import qs.Themes
import qs.Services
import qs.Components

Window {
  id: settingsmenu
  visible: false
  color: "transparent"
  width: 900
  height: 600

  property int activeIndex: 0

  onVisibleChanged: {
    if (!visible) {
      activeIndex = 0
    }
  }

  IpcHandler {
    target: "settingsmenu"
    function toggle(): void { settingsmenu.visible = !settingsmenu.visible }
    function hide(): void { settingsmenu.visible = false }
  }

  Rectangle {
    id: menuWindow
    anchors.fill: parent
    radius: 20
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
        Layout.preferredWidth: 180
        Layout.fillHeight: true
        radius: 10

        ColumnLayout {
          anchors.fill: parent
          anchors.margins: 10
          spacing: 10

          Repeater {
            model: ["General", "Display", "Theme", "Wallpaper"]

            WidgetShadow {
              id: sideButtonShadow
              anchors.fill: sideButton
            }

            Rectangle {
              id: sideButton
              Layout.fillWidth: true
              Layout.preferredHeight: 45
              radius: 10
              color: settingsmenu.activeIndex === index ? Theme.colMuted : "transparent"
              border.color: Theme.colAccent

              Text {
                anchors.centerIn: parent
                text: modelData
                color: Theme.colAccent
                font.pointSize: 14
              }

              MouseArea {
                anchors.fill: parent
                onClicked: settingsmenu.activeIndex = index
              }
            }
          }

          Item { Layout.fillHeight: true }
        }
      }

      WindowShadow {
        id: contentShadow
        Layout.alignment: Qt.AlignCenter
      }

      Rectangle {
        id: contentPane
        color: Theme.colBg
        border.color: Theme.colAccent
        Layout.fillWidth: true
        Layout.fillHeight: true
        radius: 10

        StackLayout {
          anchors.fill: parent
          anchors.margins: 15
          currentIndex: settingsmenu.activeIndex

          ColumnLayout {
            Text {
              text: "General Settings"
              color: Theme.colAccent
              font.pointSize: 16
            }
            Item { Layout.fillHeight: true } 
          }

          ColumnLayout {
            spacing: 10

            Text { 
              text: "Display Configuration"
              color: Theme.colAccent
              font.pointSize: 16
            }

            Repeater {
              model: [
                { name: ""}
              ]
            }
          }

          ColumnLayout {
            spacing: 10

            Text {
              text: "Themes"
              color: Theme.colAccent
              font.pointSize: 16
              Layout.bottomMargin: 5
            }

            Repeater {
              model: [ 
                { name: "Hyprnosis",  themeId: "hyprnosis",  script: "Hyprnosis" },
                { name: "Mocha",      themeId: "mocha",      script: "Mocha" },
                { name: "Emberforge", themeId: "emberforge", script: "Emberforge" },
                { name: "Dracula",    themeId: "dracula",    script: "Dracula" },
                { name: "Arcadia",    themeId: "arcadia",    script: "Arcadia" },
                { name: "Eden",       themeId: "eden",       script: "Eden" } 
              ]

              WidgetShadow {
                id: themeButtonShadow
                anchors.fill: themeButtons
              }

              Rectangle {
                id: themeButtons
                Layout.fillWidth: true
                Layout.preferredHeight: 45
                radius: 10
                color: themeArea.containsMouse ? Theme.colMuted : "transparent"
                border.color: Theme.colAccent
                border.width: 1

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
                  color: Theme.colAccent
                  font.pointSize: 12
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

            Item { Layout.fillHeight: true }
          }

          ColumnLayout {
            id: wallpaperPane
            spacing: 15

            property string wallpaperDir: Quickshell.env("HOME") + "/Pictures/wallpapers"
            property var wallpaperList: []

            Process {
              id: scanWallpapers
              command: ["find", "-L", wallpaperPane.wallpaperDir, "-type", "f", "!", "-name", ".*"]
              running: settingsmenu.visible && settingsmenu.activeIndex === 3
              stdout: StdioCollector {
                onStreamFinished: {
                  const wallList = text.trim().split('\n').filter(p => p.length > 0);
                  wallpaperPane.wallpaperList = wallList;
                }
              }
            }

            RowLayout {
              id: header
              spacing: 10

              Text { 
                text: "Select a wallpaper to apply:"
                color: Theme.colAccent
                font.pointSize: 16
              }

              Text {
                text: "~/Pictures/wallpapers"
                color: Theme.colMuted
                font.pointSize: 16
              }
            }

            Rectangle {
              Layout.fillWidth: true
              Layout.fillHeight: true
              radius: 10
              color: "transparent" 

              ScrollView {
                anchors.fill: parent
                clip: true
                ScrollBar.vertical.policy: ScrollBar.AsNeeded

                GridView {
                  id: wallGrid
                  anchors.fill: parent
                  cellWidth: 225
                  cellHeight: 160
                  model: wallpaperPane.wallpaperList

                  delegate: Rectangle {
                    id: imageBox
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
                        mipmap: true
                        cache: true
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
          }
        }
      }
    }
  }
}
