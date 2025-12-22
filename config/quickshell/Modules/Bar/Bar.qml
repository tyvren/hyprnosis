import Quickshell
import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Io
import qs

Scope {
  id: root
  property var theme: Theme {}

  Variants {
    model: Quickshell.screens
    delegate: Component {
      PanelWindow {
        required property var modelData
        screen: modelData
        aboveWindows: false
        exclusionMode: ExclusionMode.Ignore
        anchors.right: true
        anchors.left: true
        anchors.top: true
        anchors.bottom: true
        color: "transparent"
      }
    }
  }

  PanelWindow {
    id: wallpaperLayer
    aboveWindows: false
    exclusionMode: ExclusionMode.Ignore
    anchors.right: true
    anchors.left: true
    anchors.top: true
    anchors.bottom: true
    color: "transparent"
  }

  PanelWindow {
    id: verticalBarSpacer
    anchors.left: true
    anchors.top: true
    anchors.bottom: true
    implicitWidth: 25
    color: "transparent"
  }

  PanelWindow {
    id: horizontalBarSpacer
    anchors.left: true
    anchors.top: true
    anchors.right: true
    implicitHeight: 30
    color: "transparent"
  }

  PanelWindow {
    id: backgroundInteractionRegion
    exclusionMode: ExclusionMode.Ignore
    anchors.right: true
    anchors.left: true
    anchors.top: true
    anchors.bottom: true
    margins.top: horizontalBarSpacer.height
    margins.left: verticalBarSpacer.width
    color: "transparent"

    MouseArea {
      hoverEnabled: true
      anchors.fill: parent
      onEntered: {
        barShapePath.menuOpen = false
      }
    }

    mask: Region {
      intersection: barShapePath.menuOpen
        ? Intersection.Subtract
        : Intersection.Combine

      Region {
        height: -menuVerticalDrop.relativeY
                + (-menuTopArc.radiusY)
                + (-menuBottomArc.radiusY)
        width: menuHorizontalExpand.relativeX
               + menuTopArc.radiusX
               + menuBottomArc.radiusX
      }
    }
  }

  PanelWindow {
    id: barLayer
    focusable: barShapePath.menuOpen
    exclusionMode: ExclusionMode.Ignore
    anchors.left: true
    anchors.top: true
    anchors.right: true
    anchors.bottom: true
    color: "transparent"

    mask: Region {
      Region {
        height: horizontalBarSpacer.height
        width: barLayer.width
      }
      Region {
        height: barLayer.height
        width: verticalBarSpacer.width
      }
      Region {
        item: menuContainer
      }
    }

    Shape {
      id: barShape
      asynchronous: true
      antialiasing: true
      smooth: true
      preferredRendererType: Shape.CurveRenderer
      anchors.left: parent.left
      anchors.bottom: parent.bottom
      anchors.bottomMargin: -3

      ShapePath {
        id: barShapePath
        property bool menuOpen: false

        strokeColor: theme.colAccent
        fillColor: theme.colBg
        strokeWidth: 2

        startX: verticalBarSpacer.width
        startY: 0

        PathLine {
          relativeX: 0
          relativeY: -(verticalBarSpacer.height - horizontalBarSpacer.height)
                     - 3
                     + 30
                     + (-menuTopArc.relativeY)
                     + (-menuVerticalDrop.relativeY)
                     + (-menuBottomArc.relativeY)
        }

        PathArc {
          relativeX: 30
          relativeY: -relativeX
          radiusX: 30
          radiusY: radiusX
        }

        PathLine {
          id: menuHorizontalExpand
          relativeX: barShapePath.menuOpen ? 300 : 0
          relativeY: 0

          Behavior on relativeX {
            NumberAnimation {
              alwaysRunToEnd: false
              duration: menuHorizontalExpand.relativeX > 0 ? 400 : 500
              easing.type: menuHorizontalExpand.relativeX > 0
                ? Easing.InOutCubic
                : Easing.OutQuad
            }
          }
        }

        PathArc {
          id: menuTopArc
          direction: PathArc.Counterclockwise
          relativeX: Math.min(menuHorizontalExpand.relativeX, 30)
          relativeY: -relativeX
          radiusX: -relativeY
          radiusY: -radiusX
        }

        PathLine {
          id: menuVerticalDrop
          relativeX: 0
          relativeY: Math.min(menuHorizontalExpand.relativeX, 220) * -1
        }

        PathArc {
          id: menuBottomArc
          relativeX: menuTopArc.relativeX
          relativeY: -relativeX
          radiusX: -relativeY
          radiusY: -radiusX
        }

        PathLine {
          relativeX: barLayer.width
                     - 30
                     - menuTopArc.relativeX
                     - menuBottomArc.relativeX
                     - menuHorizontalExpand.relativeX
                     + 20
          relativeY: 0
        }

        PathLine { relativeX: 0; relativeY: -horizontalBarSpacer.height - 3 }
        PathLine { relativeX: -barLayer.width * 2; relativeY: 0 }
        PathLine { relativeX: 0; relativeY: barLayer.height + 3 }
      }
    }

    Image {
      id: barLogo
      y: 0
      x: 0
      width: 40
      height: 40
      source: theme.logoPath
      smooth: true
      asynchronous: true
      fillMode: Image.PreserveAspectCrop
      property bool beingHovered: false

      MouseArea {
        hoverEnabled: true
        anchors.fill: parent
        onExited: parent.beingHovered = false
        onEntered: {
          parent.beingHovered = true
          openMenuTimer.start()
        }

        Timer {
          id: openMenuTimer
          interval: 300
          running: false
          onTriggered: barShapePath.menuOpen = true
        }
      }
    }

    Item {
      id: menuContainer
      anchors.left: verticalBarSpacer.right
      anchors.top: horizontalBarSpacer.bottom
      width: menuHorizontalExpand.relativeX
      height: Math.min(menuHorizontalExpand.relativeX, 420)
      visible: barShapePath.menuOpen
      clip: true

      ColumnLayout {
        anchors.centerIn: parent
        spacing: 8

        Rectangle {
          id: mainMenuButton
          width: 120
          height: 50
          radius: 15
          color: "transparent"
          border.color: theme.colAccent
          border.width: 2
          opacity: menuContainer.visible ? 1.0 : 0.0

          Behavior on opacity {
            NumberAnimation {
              duration: 1000
            }
          }

          MainMenu {
            anchors.centerIn: parent
          }
        }

        Rectangle {
          id: powerMenuButton
          width: 120
          height: 50
          radius: 15
          color: "transparent"
          border.color: theme.colAccent
          border.width: 2
          opacity: menuContainer.visible ? 1.0 : 0.0

          Behavior on opacity {
            NumberAnimation {
              duration: 1000
            }
          }

          Power {
            anchors.centerIn: parent
          }
        }
      }
    }

    Workspaces {
      id: workspacesButton
      anchors.left: parent.left
      anchors.verticalCenter: parent.verticalCenter
      anchors.leftMargin: 5
    }

    Clock {
      id: clockButton
      anchors.top: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.topMargin: 5
    }

    Audio {
      id: audioButton
      anchors.top: parent.top
      anchors.right: parent.right
      anchors.rightMargin: 125
      anchors.topMargin: 5
    }

    Bluetooth {
      id: bluetoothButton
      anchors.top: parent.top
      anchors.right: parent.right
      anchors.rightMargin: 90
      anchors.topMargin: 5
    }

    Network {
      id: networkButton
      anchors.top: parent.top
      anchors.right: parent.right
      anchors.rightMargin: 45
      anchors.topMargin: 5
    }

    Notifications {
      id: notificationsButton
      anchors.top: parent.top
      anchors.right: parent.right
      anchors.rightMargin: 10
      anchors.topMargin: 5
    }
  }
}
