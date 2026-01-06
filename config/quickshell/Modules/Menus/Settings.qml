import qs
import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

PanelWindow {
  id: settingsmenu
  visible: false
  focusable: true
  color: "transparent"
  implicitWidth: 600
  implicitHeight: 800

  property var theme: Theme {}
  property int activeIndex: 0

  anchors {
    bottom: true
    right: true
  }

  onVisibleChanged: {
    if (visible) {
      currentIndex = 0
      Qt.callLater(() => menuroot.forceActiveFocus())
    }
  }

  IpcHandler {
    target: "settingsmenu"
    function toggle(): void { settingsmenu.visible = !settingsmenu.visible }
    function hide(): void { settingsmenu.visible = false }
  }

  Keys.onEscapePressed: settingsmenu.toggle()

  Process {
    id: themeRunner
    property string selectedTheme: ""
    command: [ "sh", "-c", `~/.config/hyprnosis/modules/style/theme_changer.sh "${selectedTheme}"` ]
  }

  RectangularShadow {
    id: windowShadow
    anchors.fill: menuWindow
    blur: 5
    spread: 1
    radius: 20
    color: theme.colAccent
  }

  Rectangle {
    id: menuWindow
    anchors.fill: parent
    radius: 20
    color: theme.colBg
    border.color: theme.colAccent
    border.width: 1

    RowLayout {
      anchors.centerIn: parent
      spacing: 10
      width: parent.width - 30
      height: parent.height - 30

      Rectangle {
        id: sidePane
        color: theme.colTransB
        Layout.preferredWidth: 180
        Layout.fillHeight: true
        radius: 10

        ColumnLayout {
          anchors.fill: parent
          anchors.margins: 10
          spacing: 10

          Repeater {
            model: ["General", "Display", "Theme"]

            Rectangle {
              Layout.fillWidth: true
              Layout.preferredHeight: 45
              radius: 8
              color: settingsmenu.activeIndex === index ? theme.colMuted : "transparent"
              border.color: theme.colAccent
              border.width: 2

              Text {
                anchors.centerIn: parent
                text: modelData
                color: theme.colAccent
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

      Rectangle {
        id: contentPane
        color: theme.colTransB
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
              color: theme.colAccent
              font.pointSize: 16
            }
            Item { Layout.fillHeight: true } 
          }

          ColumnLayout {
            Text { 
              text: "Display Configuration"
              color: theme.colAccent
              font.pointSize: 16
            }
            Item { Layout.fillHeight: true }
          }

          ColumnLayout {
            spacing: 10

            Text {
              text: "Theme Options"
              color: theme.colAccent
              font.pointSize: 16
              Layout.bottomMargin: 5
            }

            Repeater {
              model: [ 
                { name: "Hyprnosis", themeId: "Hyprnosis", bg: "#0c0c27", acc: "#01A2FC", hlt: "#214154" },
                { name: "Mocha",     themeId: "Mocha",     bg: "#1e1e2e", acc: "#b4befe", hlt: "#cdd6f4" },
                { name: "Emberforge",themeId: "Emberforge",bg: "#3B3B3B", acc: "#FD5001", hlt: "#626262" },
                { name: "Dracula",   themeId: "Dracula",   bg: "#282a36", acc: "#bd93f9", hlt: "#50fa7b" },
                { name: "Arcadia",   themeId: "Arcadia",   bg: "#403E44", acc: "#B3A3AD", hlt: "#AC4262" },
                { name: "Eden",      themeId: "Eden",      bg: "#D1CDC2", acc: "#0D0D0D", hlt: "#feffff" } 
              ]
              
              Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 45
                radius: 10
                color: themeArea.containsMouse ? theme.colMuted : "transparent"
                border.color: theme.colAccent
                border.width: 1

                Row {
                  id: colorRow
                  anchors.left: parent.left
                  anchors.leftMargin: 12
                  anchors.verticalCenter: parent.verticalCenter
                  spacing: 4
                  
                  Repeater {
                    model: [ modelData.bg, modelData.acc, modelData.hlt ]
                    Rectangle {
                      width: 12; height: 12; radius: 6
                      color: modelData
                      border.color: "white"
                      border.width: 0.5
                    }
                  }
                }

                Text {
                  anchors.centerIn: parent
                  text: modelData.name
                  color: theme.colAccent
                  font.pointSize: 12
                }

                MouseArea {
                  id: themeArea
                  anchors.fill: parent
                  hoverEnabled: true
                  onClicked: {
                    themeRunner.selectedTheme = modelData.themeId
                    themeRunner.startDetached()
                    settingsmenu.visible = false
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
