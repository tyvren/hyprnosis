import Quickshell
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Wayland
import qs

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

        BarMenu {
          id: barMenu
          anchor.window: leftBar
          anchor.rect.x: parentWindow.width
          anchor.rect.y: parentWindow.height / 2 - height / 2
        }

        RectangularShadow {
          anchors.fill: leftBarContent
          blur: 5
          spread: 2
          radius: 50
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

        RectangularShadow {
          id: iconAreaShadow
          anchors.fill: iconArea
          color: theme.colAccent
          height: parent.height
          width: parent.width
          radius: 50
          blur: 5
          spread: 1
        }

        Rectangle {
          id: iconArea
          color: theme.colBg
          border.color: theme.colAccent
          border.width: 2
          anchors.verticalCenter: parent.verticalCenter
          x: -32
          width: 60
          height: 60
          radius: 50

          RotationAnimation on rotation {
            id: spinAnim
            running: false
            loops: 2
            from: 0
            to: 360
            duration: 2000
          }

          ScaleAnimator {
            id: logoGrow
            target: logo
            from: 1
            to: 2
            duration: 500
          }

          ScaleAnimator {
            id: logoShrink
            target: logo
            from: 2
            to: 1
            duration: 500
          }

          Image {
            id: logo
            anchors.fill: iconArea
            source: theme.logoPath
            mipmap: true
            asynchronous: true
            fillMode: Image.PreserveAspectFit
          }

          MouseArea {
            id: iconAreaMouse
            anchors.fill: iconArea
            hoverEnabled: true
            onEntered: { 
              barMenu.visible = true
              spinAnim.start()
            }
            onClicked: {
              barMenu.visible = false
              spinAnim.start()
            }
          }
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
          anchors.fill: rightBarContent
          blur: 5
          spread: 2
          radius: 50
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
    }
  }
}
