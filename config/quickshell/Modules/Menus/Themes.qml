import Quickshell
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Hyprland
import "../.."

PanelWindow {
  id: thememenu
  visible: false
  focusable: true
  color: "transparent"
  property var theme: Theme {}
  property int currentIndex: 0

  anchors {
    top: true
    bottom: true
    left: true
    right: true
  }

  onVisibleChanged: {
    if (visible) {
      currentIndex = 0
      Qt.callLater(() => menuroot.forceActiveFocus())
    }
  }

  IpcHandler {
    target: "thememenu"

    function toggle(): void {
      thememenu.visible = !thememenu.visible
    }

    function hide(): void {
      thememenu.visible = false
    }
  }

  RectangularShadow {
    id: menushadow
    anchors.centerIn: parent
    width: 400
    height: 500
    blur: 50
    spread: 5
    radius: 10
  }

  Rectangle {
    id: menuroot
    anchors.centerIn: parent
    width: 400
    height: 500
    radius: 10
    color: theme.colBg
    border.width: 2
    border.color: theme.colAccent

    Keys.onEscapePressed: thememenu.visible = false
    Keys.onUpPressed: currentIndex = (currentIndex - 1 + themelist.count) % themelist.count
    Keys.onDownPressed: currentIndex = (currentIndex + 1) % themelist.count
    Keys.onReturnPressed: themelist.activate(currentIndex)
    Keys.onEnterPressed: themelist.activate(currentIndex)

    ColumnLayout {
      id: themelist
      anchors.centerIn: parent
      spacing: 8
      property int count: 6

      function activate(index) {
        switch (index) {
          case 0: button1.startDetached(); break
          case 1: button2.startDetached(); break
          case 2: button3.startDetached(); break
          case 3: button4.startDetached(); break
          case 4: button5.startDetached(); break
          case 5: button6.startDetached(); break
        }
        thememenu.visible = false
      }

      Item {
        implicitWidth: 350
        implicitHeight: 60

        RectangularShadow {
          anchors.centerIn: parent
          width: 350
          height: 60
          blur: 5
          spread: 1
          radius: 10
        }

        Rectangle {
          anchors.fill: parent
          radius: 10
          color: currentIndex === 0 || button1area.containsMouse ? theme.colSelect : theme.colBg
          border.width: 2
          border.color: theme.colAccent

          Text {
            anchors.centerIn: parent
            color: theme.colAccent
            font.family: theme.fontFamily
            font.pixelSize: 22
            text: "Hyprnosis"
          }

          MouseArea {
            id: button1area
            anchors.fill: parent
            hoverEnabled: true
            onEntered: currentIndex = 0
            onClicked: {
              currentIndex = 0
              button1.startDetached()
              thememenu.visible = false
            }
          }

          Process {
            id: button1
            command: [ "sh", "-c", '~/.config/hyprnosis/modules/style/theme_changer.sh "Hyprnosis"' ]
          }
        }
      }

      Item {
        implicitWidth: 350
        implicitHeight: 60

        RectangularShadow {
          anchors.centerIn: parent
          width: 350
          height: 60
          blur: 5
          spread: 1
          radius: 10
        }

        Rectangle {
          anchors.fill: parent
          radius: 10
          color: currentIndex === 1 || button2area.containsMouse ? theme.colSelect : theme.colBg
          border.width: 2
          border.color: theme.colAccent

          Text {
            anchors.centerIn: parent
            color: theme.colAccent
            font.family: theme.fontFamily
            font.pixelSize: 22
            text: "Catppuccin Mocha"
          }

          MouseArea {
            id: button2area
            anchors.fill: parent
            hoverEnabled: true
            onEntered: currentIndex = 1
            onClicked: {
              currentIndex = 1
              button2.startDetached()
              thememenu.visible = false
            }
          }

          Process {
            id: button2
            command: [ "sh", "-c", '~/.config/hyprnosis/modules/style/theme_changer.sh "Mocha"' ]
          }
        }
      }

      Item {
        implicitWidth: 350
        implicitHeight: 60

        RectangularShadow {
          anchors.centerIn: parent
          width: 350
          height: 60
          blur: 5
          spread: 1
          radius: 10
        }

        Rectangle {
          anchors.fill: parent
          radius: 10
          color: currentIndex === 2 || button3area.containsMouse ? theme.colSelect : theme.colBg
          border.width: 2
          border.color: theme.colAccent

          Text {
            anchors.centerIn: parent
            color: theme.colAccent
            font.family: theme.fontFamily
            font.pixelSize: 22
            text: "Emberforge"
          }

          MouseArea {
            id: button3area
            anchors.fill: parent
            hoverEnabled: true
            onEntered: currentIndex = 2
            onClicked: {
              currentIndex = 2
              button3.startDetached()
              thememenu.visible = false
            }
          }

          Process {
            id: button3
            command: [ "sh", "-c", '~/.config/hyprnosis/modules/style/theme_changer.sh "Emberforge"' ]
          }
        }
      }

      Item {
        implicitWidth: 350
        implicitHeight: 60

        RectangularShadow {
          anchors.centerIn: parent
          width: 350
          height: 60
          blur: 5
          spread: 1
          radius: 10
        }

        Rectangle {
          anchors.fill: parent
          radius: 10
          color: currentIndex === 3 || button4area.containsMouse ? theme.colSelect : theme.colBg
          border.width: 2
          border.color: theme.colAccent

          Text {
            anchors.centerIn: parent
            color: theme.colAccent
            font.family: theme.fontFamily
            font.pixelSize: 22
            text: "Dracula"
          }

          MouseArea {
            id: button4area
            anchors.fill: parent
            hoverEnabled: true
            onEntered: currentIndex = 3
            onClicked: {
              currentIndex = 3
              button4.startDetached()
              thememenu.visible = false
            }
          }

          Process {
            id: button4
            command: [ "sh", "-c", '~/.config/hyprnosis/modules/style/theme_changer.sh "Dracula"' ]
          }
        }
      }

      Item {
        implicitWidth: 350
        implicitHeight: 60

        RectangularShadow {
          anchors.centerIn: parent
          width: 350
          height: 60
          blur: 5
          spread: 1
          radius: 10
        }

        Rectangle {
          anchors.fill: parent
          radius: 10
          color: currentIndex === 4 || button5area.containsMouse ? theme.colSelect : theme.colBg
          border.width: 2
          border.color: theme.colAccent

          Text {
            anchors.centerIn: parent
            color: theme.colAccent
            font.family: theme.fontFamily
            font.pixelSize: 22
            text: "Arcadia"
          }

          MouseArea {
            id: button5area
            anchors.fill: parent
            hoverEnabled: true
            onEntered: currentIndex = 4
            onClicked: {
              currentIndex = 4
              button5.startDetached()
              thememenu.visible = false
            }
          }

          Process {
            id: button5
            command: [ "sh", "-c", '~/.config/hyprnosis/modules/style/theme_changer.sh "Arcadia"' ]
          }
        }
      }

      Item {
        implicitWidth: 350
        implicitHeight: 60

        RectangularShadow {
          anchors.centerIn: parent
          width: 350
          height: 60
          blur: 5
          spread: 1
          radius: 10
        }

        Rectangle {
          anchors.fill: parent
          radius: 10
          color: currentIndex === 5 || button6area.containsMouse ? theme.colSelect : theme.colBg
          border.width: 2
          border.color: theme.colAccent

          Text {
            anchors.centerIn: parent
            color: theme.colAccent
            font.family: theme.fontFamily
            font.pixelSize: 22
            text: "Eden"
          }

          MouseArea {
            id: button6area
            anchors.fill: parent
            hoverEnabled: true
            onEntered: currentIndex = 5
            onClicked: {
              currentIndex = 5
              button6.startDetached()
              thememenu.visible = false
            }
          }

          Process {
            id: button6
            command: [ "sh", "-c", '~/.config/hyprnosis/modules/style/theme_changer.sh "Eden"' ]
          }
        }
      }
    }
  }
}
