import Quickshell
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Hyprland

Item {
  id: powerbutton
  implicitWidth: icon.implicitWidth
  implicitHeight: icon.implicitHeight
  property var theme: Theme {}

  Text {
    id: icon
    text: ""
    font.family: theme.fontFamily
    font.pixelSize: theme.fontSize
    color: theme.colAccent
    layer.enabled: true
    visible: false
  }

  MultiEffect {
    anchors.fill: parent
    source: icon
    shadowEnabled: true
    shadowBlur: 1
    shadowOpacity: 0.50
  }

  MouseArea {
    anchors.fill: parent
    onClicked: powermenuloader.item.visible = ! powermenuloader.item.visible
  }

  LazyLoader {
    id: powermenuloader
    loading: true

    PanelWindow {
      id: powermenu
      visible: false
      focusable: true
      implicitWidth: 200
      implicitHeight: 175
      color: "transparent"
      property var theme: Theme {}
      property int currentIndex: 0
      anchors.top: parent.top
      anchors.right: parent.right

      onVisibleChanged: {
        if (visible) {
          currentIndex = 0
          Qt.callLater(() => menuroot.forceActiveFocus())
          widthAnim.from = 0
          widthAnim.to = implicitWidth
          heightAnim.from = 0
          heightAnim.to = implicitHeight
          widthAnim.start()
          heightAnim.start()
        } 
      }

      Rectangle {
        id: menuroot
        anchors.top: parent.top
        anchors.right: parent.right
        bottomLeftRadius: 10
        color: theme.colBg

        PropertyAnimation {
          id: widthAnim
          target: menuroot
          property: "width"
          duration: 250
          easing.type: Easing.OutQuad
          easing.amplitude: 1.0
          easing.period: 2.0
        }

        PropertyAnimation {
          id: heightAnim
          target: menuroot
          property: "height"
          duration: 250
          easing.type: Easing.OutQuad
          easing.amplitude: 1.0
          easing.period: 2.0
        }

        Keys.onEscapePressed: powermenu.visible = false
        Keys.onUpPressed: currentIndex = (currentIndex - 1 + menulist.count) % menulist.count
        Keys.onDownPressed: currentIndex = (currentIndex + 1) % menulist.count
        Keys.onReturnPressed: menulist.activate(currentIndex)
        Keys.onEnterPressed: menulist.activate(currentIndex)

        ColumnLayout {
          id: menulist
          anchors.centerIn: parent
          spacing: 8
          property int count: 3

          function activate(index) {
            switch (index) {
              case 0: button1.startDetached(); break
              case 1: button2.startDetached(); break
              case 2: button3.startDetached(); break
            }
            powermenu.visible = false
          }

          Item {
            implicitWidth: 150
            implicitHeight: 45

            RectangularShadow {
              anchors.centerIn: parent
              implicitWidth: 150
              implicitHeight: 45
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
                anchors.verticalCenter: parent.verticalCenter
                anchors.centerIn: parent
                color: theme.colAccent
                font.family: theme.fontFamily
                font.pixelSize: 22
                text: ""
              }

              MouseArea {
                id: button1area
                anchors.fill: parent
                hoverEnabled: true
                onEntered: currentIndex = 0
                onClicked: {
                  currentIndex = 0
                  button1.startDetached()
                  powermenu.visible = false
                }
              }

              Process { id: button1; command: ["hyprlock"] }
            }
          }

          Item {
            implicitWidth: 150
            implicitHeight: 45

            RectangularShadow {
              anchors.centerIn: parent
              implicitWidth: 150
              implicitHeight: 45
              blur: 5
              spread: 0
              radius: 10
            }

            Rectangle {
              anchors.fill: parent
              radius: 10
              color: currentIndex === 1 || button2area.containsMouse ? theme.colSelect : theme.colBg
              border.width: 2
              border.color: theme.colAccent

              Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.centerIn: parent
                color: theme.colAccent
                font.family: theme.fontFamily
                font.pixelSize: 22
                text: ""
              }

              MouseArea {
                id: button2area
                anchors.fill: parent
                hoverEnabled: true
                onEntered: currentIndex = 1
                onClicked: {
                  currentIndex = 1
                  button2.startDetached()
                  powermenu.visible = false
                }
              }

              Process { id: button2; command: ["systemctl", "reboot"] }
            }
          }

          Item {
            implicitWidth: 150
            implicitHeight: 45

            RectangularShadow {
              anchors.centerIn: parent
              implicitWidth: 150
              implicitHeight: 45
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
                anchors.verticalCenter: parent.verticalCenter
                anchors.centerIn: parent
                color: theme.colAccent
                font.family: theme.fontFamily
                font.pixelSize: 22
                text: ""
              }

              MouseArea {
                id: button3area
                anchors.fill: parent
                hoverEnabled: true
                onEntered: currentIndex = 2
                onClicked: {
                  currentIndex = 2
                  button3.startDetached()
                  powermenu.visible = false
                }
              }

              Process { id: button3; command: ["systemctl", "poweroff"] }
            }
          }
        }
      }
    }
  }
}
