import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.Themes
import qs.Services
import qs.Components

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
