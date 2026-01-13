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
  property int activeIndex: 0

  IpcHandler {
    target: "settingsmenu"
  
    function toggle(): void { 
      if (!settingsmenu.visible) {
        settingsmenu.activeIndex = 0
      }
      settingsmenu.visible = !settingsmenu.visible 
    }

    function openTo(index: int): void {
      settingsmenu.activeIndex = index
      settingsmenu.visible = true
    }
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
              {icon: "󰋼", text: "About"},
              {icon: "󰏖", text: "Apps"},
              {icon: "󰓃", text: "Audio"},
              {icon: "󰂯", text: "Bluetooth"},
              {icon: "󰍹", text: "Display"},
              {icon: "󰖩", text: "Network"}, 
              {icon: "", text: "Theme"},
              {icon: "󰸉", text: "Wallpaper"},
              {icon: "󰚰", text: "Updates"}
            ]

            Item {
              Layout.fillWidth: true
              Layout.preferredHeight: 45

              MultiEffect {
                anchors.fill: sideButton
                source: sideButton
                shadowEnabled: true
                shadowBlur: 0.2
                shadowColor: Theme.colAccent
                shadowVerticalOffset: 1
                shadowHorizontalOffset: 0
                opacity: 0.8
              }

              Rectangle {
                id: sideButton
                anchors.fill: parent
                radius: 10
                color: (settingsmenu.activeIndex === index || navMa.containsMouse) ? Theme.colAccent : Theme.colMuted

                RowLayout {
                  anchors.fill: parent
                  anchors.leftMargin: 10

                  Text {
                    Layout.preferredWidth: 25
                    verticalAlignment: Text.AlignVCenter
                    text: modelData.icon
                    color: (settingsmenu.activeIndex === index || navMa.containsMouse) ? Theme.colBg : Theme.colAccent
                    font.pointSize: 14
                    font.family: Theme.fontFamily
                    antialiasing: true
                  }

                  Text {
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    text: modelData.text
                    color: (settingsmenu.activeIndex === index || navMa.containsMouse) ? Theme.colBg : Theme.colAccent
                    font.pointSize: 12
                    font.family: Theme.fontFamily
                    antialiasing: true
                  }
                }

                MouseArea {
                  id: navMa
                  anchors.fill: parent
                  hoverEnabled: true
                  onClicked: settingsmenu.activeIndex = index
                }
              }
            }
          }

          Item {
            Layout.fillHeight: true
          }

          Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 45

            MultiEffect {
              anchors.fill: closeButton
              source: closeButton
              shadowEnabled: true
              shadowBlur: 0.2
              shadowColor: Theme.colAccent
              shadowVerticalOffset: 1
              shadowHorizontalOffset: 0
              opacity: 0.8
            }

            Rectangle {
              id: closeButton
              anchors.fill: parent
              radius: 10
              color: closeMa.containsMouse ? Theme.colAccent : Theme.colMuted

              RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 10
                spacing: 0

                Text {
                  Layout.preferredWidth: 25
                  verticalAlignment: Text.AlignVCenter
                  text: "󰅙"
                  color: closeMa.containsMouse ? Theme.colBg : Theme.colAccent
                  font.pointSize: 14
                  font.family: Theme.fontFamily
                  antialiasing: true
                }

                Text {
                  Layout.fillWidth: true
                  verticalAlignment: Text.AlignVCenter
                  text: "Close"
                  color: closeMa.containsMouse ? Theme.colBg : Theme.colAccent
                  font.pointSize: 12
                  font.family: Theme.fontFamily
                  antialiasing: true
                }
              }

              MouseArea {
                id: closeMa
                anchors.fill: parent
                hoverEnabled: true
                onClicked: settingsmenu.visible = false
              }
            }
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

        StackLayout {
          anchors.fill: parent
          anchors.margins: 15
          currentIndex: settingsmenu.activeIndex

          SystemInfo {
            active: settingsmenu.visible && settingsmenu.activeIndex === 0
          }
          AppSettings {}
          AudioSettings {}
          BluetoothSettings {}
          DisplaySettings { 
            active: settingsmenu.visible && settingsmenu.activeIndex === 4 
          } 
          NetworkSettings {}
          ThemeSettings {}
          WallpaperSettings {
            active: settingsmenu.visible && settingsmenu.activeIndex === 7
          }
          UpdateSettings {}
        }
      }
    }
  }
}
