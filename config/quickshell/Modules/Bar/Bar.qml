import Quickshell
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Wayland
import qs
import qs.Components

Variants {
  model: Quickshell.screens
  delegate: Component {
    Item {
      id: root
      required property var modelData
      property var theme: Theme {}

      PanelWindow {
        id: backgroundLayer
        color: "transparent"
        anchors {
          top: true
          bottom: true
          left: true
          right: true
        }
        screen: modelData
        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Bottom

        Image {
          id: wallpaper
          anchors.fill: parent
          source: theme.wallpaperPath
          mipmap: true
          asynchronous: true
          fillMode: Image.PreserveAspectCrop
        }
      }

      PanelWindow {
        id: leftBar
        color: "transparent"
        implicitWidth: 30
        anchors {
          left: true
          top: true
          bottom: true
        }

        Media {
          id: mediaPlayer
          anchor.window: leftBar
          anchor.rect.x: parentWindow.width
          anchor.rect.y: parentWindow.height / 6
          color: "transparent"
        }

        RectangularShadow {
          id: leftBarShadow
          anchors.fill: leftBarContent
          anchors.leftMargin: 5
          blur: 2
          spread: 2
          radius: 20
          color: theme.colAccent
        }

        Rectangle {
          id: leftBarContent
          color: theme.colBg
          anchors.fill: parent
          anchors.rightMargin: 2
          topRightRadius: 15
          bottomRightRadius: 15
        }
      }

      PanelWindow {
        id: rightBar
        color: "transparent"
        implicitWidth: 30
        anchors {
          right: true
          top: true
          bottom: true
        }

        RectangularShadow {
          id: rightBarShadow
          anchors.fill: rightBarContent
          anchors.rightMargin: 5
          blur: 2
          spread: 2
          radius: 20
          color: theme.colAccent
        }

        Rectangle {
          id: rightBarContent
          color: theme.colBg
          anchors.fill: parent
          anchors.leftMargin: 2
          topLeftRadius: 20
          bottomLeftRadius: 20

          Clock {
            id: clockButton
            anchors.top: rightBarContent.top
            anchors.horizontalCenter: rightBarContent.horizontalCenter
            anchors.topMargin: 15
          }

          Workspaces {
            id: workspacesButton
            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.height / 2 - 65
          }

          Battery {
            anchors.bottom: rightBarContent.bottom
            anchors.horizontalCenter: rightBarContent.horizontalCenter
            anchors.bottomMargin: 135
          }
          Audio {
            anchors.bottom: rightBarContent.bottom
            anchors.horizontalCenter: rightBarContent.horizontalCenter
            anchors.bottomMargin: 105
          }
          Bluetooth {
            anchors.bottom: rightBarContent.bottom
            anchors.horizontalCenter: rightBarContent.horizontalCenter
            anchors.bottomMargin: 75
          }
          Network {
            anchors.bottom: rightBarContent.bottom
            anchors.horizontalCenter: rightBarContent.horizontalCenter
            anchors.bottomMargin: 45
          }
          Notifications {
            anchors.bottom: rightBarContent.bottom
            anchors.horizontalCenter: rightBarContent.horizontalCenter
            anchors.bottomMargin: 15
          } 
        }
      }

      Core {}
    }
  }
}
