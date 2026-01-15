import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.Components
import qs.Services
import qs.Themes

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
        Layout.preferredWidth: 65
        Layout.fillHeight: true
        radius: 10

        ColumnLayout {
          anchors.fill: parent
          anchors.margins: 10
          spacing: 10

          Repeater {
            model: [ 
              {icon: "󰋼"}, {icon: "󰏖"}, {icon: "󰓃"}, 
              {icon: "󰂯"}, {icon: "󰍹"}, {icon: "󰖩"}, 
              {icon: ""}, {icon: "󰸉"}, {icon: "󰚰"}
            ]

            StyledButton {
              text: modelData.icon
              size: 45
              active: settingsmenu.activeIndex === index
              onClicked: settingsmenu.activeIndex = index
            }
          }

          Item { Layout.fillHeight: true }

          StyledButton {
            text: "󰅙"
            size: 45
            onClicked: settingsmenu.visible = false
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
          active: settingsmenu.visible
          loading: true
          
          StackLayout {
            parent: contentPane
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
}
