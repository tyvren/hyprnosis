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
            model: [
              {icon: "", text: "General"}, 
              {icon: "󰍹", text: "Display"},
              {icon: "", text: "Theme"},
              {icon: "󰸉", text: "Wallpaper"}
            ]

            WidgetShadow {
              id: sideButtonShadow
              anchors.fill: sideButton
            }

            Rectangle {
              id: sideButton
              Layout.fillWidth: true
              Layout.preferredHeight: 45
              radius: 10
              color: settingsmenu.activeIndex === index || sideMouse.containsMouse ? Theme.colMuted : "transparent"

              RowLayout {
                id: textRow
                anchors.fill: parent
                anchors.leftMargin: 10
                spacing: 11

                Text {
                  verticalAlignment: Text.AlignVCenter
                  text: modelData.icon + "    " + modelData.text
                  color: Theme.colAccent
                  font.pointSize: 14
                }
              }

              MouseArea {
                id: sideMouse
                anchors.fill: parent
                hoverEnabled: true
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
          anchors.margins: 25
          currentIndex: settingsmenu.activeIndex

          ColumnLayout {
            spacing: 10

            Text {
              text: "General Settings"
              color: Theme.colAccent
              font.pointSize: 16
            }

            Rectangle {
              Layout.fillWidth: true
              height: 1
              color: Theme.colMuted
              opacity: 0.3
            }

            Item { Layout.fillHeight: true } 
          }

          ColumnLayout {
            id: displayPane
            spacing: 20

            property var monitors: []
            property int selectedMonitorIdx: 0
            
            property string currentPos: "auto"
            property string currentScale: "1"
            property string currentGdk: "1"

            function updateCurrentSettings() {
              if (monitors.length > 0 && monitors[selectedMonitorIdx]) {
                let m = monitors[selectedMonitorIdx];
                currentPos = m.x + "x" + m.y;
                currentScale = m.scale.toString();
              }
            }

            onSelectedMonitorIdxChanged: updateCurrentSettings()

            Process {
              id: getMonitors
              command: ["hyprctl", "monitors", "-j"]
              running: settingsmenu.visible && settingsmenu.activeIndex === 1
              stdout: StdioCollector {
                onStreamFinished: {
                  try {
                    displayPane.monitors = JSON.parse(text);
                    displayPane.updateCurrentSettings();
                  } catch(e) {}
                }
              }
            }

            ColumnLayout {
              spacing: 10
              Layout.fillWidth: true

              Text { 
                text: "Display Configuration"
                color: Theme.colAccent
                font.pointSize: 16
              }

              Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Theme.colMuted
                opacity: 0.3
              }
            }

            RowLayout {
              spacing: 15
              Layout.fillWidth: true
              
              Repeater {
                model: displayPane.monitors

                Rectangle {
                  Layout.preferredWidth: 160
                  Layout.preferredHeight: 90
                  radius: 12
                  color: displayPane.selectedMonitorIdx === index || monMouse.containsMouse ? Theme.colMuted : "transparent"
                  border.color: Theme.colAccent
                  border.width: 1

                  ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 4

                    Text { 
                      text: modelData.name 
                      color: Theme.colAccent
                      font.bold: true
                      font.pointSize: 11
                      Layout.alignment: Qt.AlignHCenter
                    }
                    Text { 
                      text: modelData.width + "x" + modelData.height
                      color: Theme.colAccent
                      font.pointSize: 9
                      Layout.alignment: Qt.AlignHCenter
                    }
                  }

                  MouseArea {
                    id: monMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: displayPane.selectedMonitorIdx = index
                  }
                }
              }
            }

            Rectangle {
              Layout.fillWidth: true
              height: 1
              color: Theme.colMuted
              opacity: 0.3
            }

            GridLayout {
              columns: 2
              rowSpacing: 25
              columnSpacing: 30
              Layout.fillWidth: true

              ColumnLayout {
                spacing: 8

                Text { 
                  text: "Monitor Position"
                  color: Theme.colAccent
                  font.pointSize: 10 
                }

                RowLayout {
                  spacing: 10

                  Repeater {
                    model: ["auto", "left", "right"]

                    Rectangle {
                      Layout.preferredWidth: 70
                      Layout.preferredHeight: 32
                      radius: 6
                      color: displayPane.currentPos === modelData ? Theme.colAccent : (posMouse.containsMouse ? Theme.colMuted : "transparent")
                      border.color: Theme.colAccent
                      border.width: 1

                      Text {
                        anchors.centerIn: parent
                        text: modelData
                        color: displayPane.currentPos === modelData ? Theme.colBg : Theme.colAccent
                        font.pointSize: 9
                      }

                      MouseArea { 
                        id: posMouse
                        anchors.fill: parent 
                        hoverEnabled: true
                        onClicked: displayPane.currentPos = modelData
                      }
                    }
                  }
                }
              }

              ColumnLayout {
                spacing: 8

                Text { 
                  text: "Hyprland Scaling"
                  color: Theme.colAccent
                  font.pointSize: 10 
                }

                RowLayout {
                  spacing: 10

                  Repeater {
                    model: ["1", "1.5", "2"]

                    Rectangle {
                      Layout.preferredWidth: 50
                      Layout.preferredHeight: 32
                      radius: 6
                      color: displayPane.currentScale === modelData ? Theme.colAccent : (scaleMouse.containsMouse ? Theme.colMuted : "transparent")
                      border.color: Theme.colAccent
                      border.width: 1

                      Text {
                        anchors.centerIn: parent
                        text: modelData
                        color: displayPane.currentScale === modelData ? Theme.colBg : Theme.colAccent
                        font.pointSize: 9
                      }

                      MouseArea { 
                        id: scaleMouse
                        anchors.fill: parent 
                        hoverEnabled: true
                        onClicked: displayPane.currentScale = modelData
                      }
                    }
                  }
                }
              }

              ColumnLayout {
                spacing: 8

                Text { 
                  text: "GDK App Scaling"
                  color: Theme.colAccent
                  font.pointSize: 10 
                }

                RowLayout {
                  spacing: 10

                  Repeater {
                    model: ["1", "2"]

                    Rectangle {
                      Layout.preferredWidth: 60
                      Layout.preferredHeight: 32
                      radius: 6
                      color: displayPane.currentGdk === modelData ? Theme.colAccent : (gdkMouse.containsMouse ? Theme.colMuted : "transparent")
                      border.color: Theme.colAccent
                      border.width: 1

                      Text {
                        anchors.centerIn: parent
                        text: modelData + "x"
                        color: displayPane.currentGdk === modelData ? Theme.colBg : Theme.colAccent
                        font.pointSize: 9
                      }

                      MouseArea { 
                        id: gdkMouse
                        anchors.fill: parent 
                        hoverEnabled: true
                        onClicked: displayPane.currentGdk = modelData
                      }
                    }
                  }
                }
              }
            }

            Item { Layout.fillHeight: true }

            Rectangle {
              id: applyButton
              Layout.alignment: Qt.AlignRight
              Layout.preferredWidth: 140
              Layout.preferredHeight: 40
              radius: 10
              color: Theme.colAccent
              opacity: applyMouse.containsMouse ? 0.8 : 1.0

              Text {
                anchors.centerIn: parent
                text: "Apply Settings"
                color: Theme.colBg
                font.bold: true
              }

              MouseArea {
                id: applyMouse
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                  let monitor = displayPane.monitors[displayPane.selectedMonitorIdx];
                  Quickshell.execDetached([
                    Quickshell.env("HOME") + "/.config/hyprnosis/modules/style/qs_apply_monitors.sh",
                    monitor.name,
                    monitor.width + "x" + monitor.height + "@" + (monitor.refreshRate || "60"),
                    displayPane.currentPos,
                    displayPane.currentScale,
                    displayPane.currentGdk
                  ]);
                }
              }
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

            Rectangle {
              Layout.fillWidth: true
              height: 1
              color: Theme.colMuted
              opacity: 0.3
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

            ColumnLayout {
              spacing: 10
              Layout.fillWidth: true
              RowLayout {
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
                height: 1
                color: Theme.colMuted
                opacity: 0.3
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
