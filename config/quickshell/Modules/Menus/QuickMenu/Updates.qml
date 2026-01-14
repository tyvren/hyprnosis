import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.Themes

PanelWindow {
  id: updatemenu
  visible: false
  focusable: true
  color: "transparent"
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
      Qt.callLater(() => menuRoot.forceActiveFocus())
    }
  }

  IpcHandler {
    target: "updatemenu"
    function toggle(): void { updatemenu.visible = !updatemenu.visible }
    function hide(): void { updatemenu.visible = false }
  }

  RectangularShadow {
    anchors.centerIn: parent
    width: 400
    height: 300
    blur: 10
    spread: 0
    radius: 10
    color: "transparent"
  }

  Rectangle {
    id: menuRoot
    focus: true
    anchors.centerIn: parent
    width: 400
    height: 300
    radius: 10
    color: "transparent"
    
    Image {
      id: logoImage
      anchors.centerIn: parent
      width: 500
      height: 500
      source: Theme.logoPath
      mipmap: true
      asynchronous: true
      fillMode: Image.PreserveAspectFit
      opacity: 0.7
    }

    Keys.onEscapePressed: updatemenu.visible = false
    Keys.onUpPressed: currentIndex = (currentIndex - 1 + buttonList.count) % buttonList.count
    Keys.onDownPressed: currentIndex = (currentIndex + 1) % buttonList.count
    Keys.onReturnPressed: buttonList.activate(currentIndex)
    Keys.onEnterPressed: buttonList.activate(currentIndex)

    ColumnLayout {
      id: buttonList
      anchors.centerIn: parent
      spacing: 8
      property int count: 3

      function activate(index) {
        switch(index) {
          case 0: button1.startDetached(); break
          case 1: button2.startDetached(); break
          case 2: button3.startDetached(); break
        }
        updatemenu.visible = false
      }

      component UpdateButton : Item {
        property string label: ""
        property string script: ""
        property int index: 0
        property alias process: proc
        implicitWidth: 225
        implicitHeight: 60

        RectangularShadow {
          anchors.centerIn: parent
          width: 225
          height: 60
          blur: 5
          spread: 1
          radius: 50
        }

        Rectangle {
          anchors.fill: parent
          radius: 50
          color: currentIndex === index || mouseArea.containsMouse ? Theme.colSelect : Theme.colBg
          border.width: 2
          border.color: Theme.colAccent

          Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 15
            color: Theme.colAccent
            font.family: Theme.fontFamily
            font.pointSize: 18
            text: ""
          }

          Text {
            anchors.centerIn: parent
            color: Theme.colAccent
            font.family: Theme.fontFamily
            font.pointSize: 14
            text: label
          }

          MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onEntered: currentIndex = index
            onClicked: {
              currentIndex = index
              proc.startDetached()
              updatemenu.visible = false
            }
          }

          Process {
            id: proc
            command: ["sh", "-c", `ghostty -e ~/.config/hyprnosis/modules/updates/${script}`]
          }
        }
      }

      UpdateButton { index: 0; label: "System"; script: "update_system.sh"; id: button1 }
      UpdateButton { index: 1; label: "AUR"; script: "update_aur.sh"; id: button2 }
      UpdateButton { index: 2; label: "Hyprnosis"; script: "update_hyprnosis.sh"; id: button3 }
    }
  }
}
