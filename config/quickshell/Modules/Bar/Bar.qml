import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland
import qs.Components
import qs.Themes

Variants {
  model: Quickshell.screens
  delegate: Component {
    Item {
      id: root
      required property var modelData

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
          source: Theme.wallpaperPath
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
          anchor.rect.x: leftBar.width - 2
          anchor.rect.y: leftBar.height / 10
          color: "transparent"
        }

        Shape {
          id: leftBarShape
          anchors.fill: parent
          layer.enabled: true
          layer.samples: 5

          ShapePath {
            strokeWidth: 2
            strokeColor: "transparent"
            fillColor: Theme.colBg

            startX: 0
            startY: 0

            PathCubic {
              x: 28
              y: 50
              control1X: 5
              control1Y: 30
              control2X: 28
              control2Y: 35
            }
            PathLine {
              x: 28
              y: leftBar.height - 50
            }
            PathCubic {
              x: 0
              y: leftBar.height
              control1X: 28
              control1Y: leftBar.height - 35
              control2X: 5
              control2Y: leftBar.height - 30
            }
            PathLine {
              x: 0
              y: 0
            }
          }
        }

        MultiEffect {
          id: leftBarShadow
          anchors.fill: leftBarShape
          source: leftBarShape
          shadowEnabled: true
          shadowColor: Theme.colAccent
          shadowBlur: 0.2
          shadowHorizontalOffset: 1
          shadowVerticalOffset: 0
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

        Shape {
          id: rightBarShape
          anchors.fill: parent
          layer.enabled: true
          layer.samples: 5

          ShapePath {
            strokeWidth: 2
            strokeColor: "transparent"
            fillColor: Theme.colBg

            startX: rightBar.width
            startY: 0

            PathCubic {
              x: rightBar.width - 28
              y: 50
              control1X: rightBar.width - 5
              control1Y: 30
              control2X: rightBar.width - 28
              control2Y: 35
            }
            PathLine {
              x: rightBar.width - 28
              y: rightBar.height - 50
            }
            PathCubic {
              x: rightBar.width
              y: rightBar.height
              control1X: rightBar.width - 28
              control1Y: rightBar.height - 35
              control2X: rightBar.width - 5
              control2Y: rightBar.height - 30
            }
            PathLine {
              x: rightBar.width
              y: 0
            }
          }
        }

        MultiEffect {
          id: rightBarShadow
          anchors.fill: rightBarShape
          source: rightBarShape
          shadowEnabled: true
          shadowColor: Theme.colAccent
          shadowBlur: 0.2
          shadowHorizontalOffset: -1
          shadowVerticalOffset: 0
        }

        Item {
          id: rightBarContent
          anchors.fill: parent

          Calendar {
            id: calendar
            visible: clockArea.containsMouse
          }

          Clock {
            id: clockButton
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 50 

            MouseArea {
              id: clockArea
              anchors.fill: clockButton
              hoverEnabled: true
            }
          }

          Workspaces {
            id: workspacesButton
            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.height / 2 - 65
          }

          Battery {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 170
          }
          Audio {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 140
          }
          Bluetooth {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 110
          }
          Network {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 80
          }
          Notifications {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 50
          } 
        }
      }
      Core {}
    }
  }
}
