import qs.Themes
import qs.Services
import qs.Components
import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects 

Window {
  id: settingsmenu
  visible: persist.settingsOpen
  color: "transparent"
  width: 900
  height: 600

  property int activeIndex: persist.activeIndex

  PersistentProperties {
    id: persist
    reloadableId: "persistedStates"
    property bool settingsOpen: false
    property int activeIndex: 0
  }

  IpcHandler {
    target: "settingsmenu"
    function toggle(): void { persist.settingsOpen = !persist.settingsOpen }
    function hide(): void { persist.settingsOpen = false }
  }

  Keys.onEscapePressed: persist.settingsOpen = false

  WindowShadow {
    id: windowShadow
    anchors.fill: menuWindow
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

      WidgetShadow {
        id: sidePaneShadow
        anchors.fill: sidePane
      }

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
            model: ["General", "Display", "Theme"]

            WidgetShadow {
              id: sideButtonShadow
              anchors.fill: sideButton
            }

            Rectangle {
              id: sideButton
              Layout.fillWidth: true
              Layout.preferredHeight: 45
              radius: 10
              color: settingsmenu.activeIndex === index ? Theme.colHilight : "transparent"
              border.color: Theme.colAccent

              Text {
                anchors.centerIn: parent
                text: modelData
                color: Theme.colAccent
                font.pointSize: 14
              }

              MouseArea {
                anchors.fill: parent
                onClicked: persist.activeIndex = index
              }
            }
          }
          Item { Layout.fillHeight: true }
        }
      }

      WidgetShadow {
        id: contentPaneShadow
        anchors.fill: contentPane
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
            Text { 
              text: "Display Configuration"
              color: Theme.colAccent
              font.pointSize: 16
            }
            Item { Layout.fillHeight: true }
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
                color: themeArea.containsMouse ? Theme.colHilight : "transparent"
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
                      width: 15; height: 15; radius: 6
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
        }
      }
    }
  }
}
