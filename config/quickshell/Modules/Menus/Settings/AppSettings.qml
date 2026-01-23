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

ColumnLayout {
  id: appPane
  spacing: 10

  property var fullAppList: []
  property var filteredList: []
  property string searchQuery: ""

  Text {
    text: "App Management"
    color: Theme.colAccent
    font.pointSize: 16
    font.family: Theme.fontFamily
  }

  DividerLine {
    Layout.fillWidth: true
  }

  RowLayout {
    Layout.fillWidth: true
    spacing: 10

    Rectangle {
      id: searchBar
      Layout.fillWidth: true
      Layout.preferredHeight: 45
      color: Theme.colBg
      radius: 10
      border.color: Theme.colAccent
      border.width: 1

      RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 15
        anchors.rightMargin: 10

        TextInput {
          id: searchInput
          Layout.fillWidth: true
          verticalAlignment: Text.AlignVCenter
          color: Theme.colAccent
          font.family: Theme.fontFamily
          font.pointSize: 12
          clip: true
          focus: true
          
          onTextChanged: {
            appPane.searchQuery = text.toLowerCase()
            filterModel()
          }
        }

        Text {
          text: "󰑐"
          font.pointSize: 14
          color: refreshMa.containsMouse ? Theme.colAccent : Theme.colMuted
          opacity: loader.running ? 0.5 : 1.0

          MouseArea {
            id: refreshMa
            anchors.fill: parent
            hoverEnabled: true
            onClicked: loader.running = true
          }

          RotationAnimation on rotation {
            from: 0; to: 360; duration: 1000
            running: loader.running
            loops: Animation.Infinite
          }
        }
      }

      Text {
        anchors.fill: parent
        anchors.leftMargin: 15
        verticalAlignment: Text.AlignVCenter
        text: "Search " + fullAppList.length + " installed apps..."
        color: Theme.colAccent
        opacity: 0.3
        font.family: Theme.fontFamily
        visible: !searchInput.text && !searchInput.focus
      }
    }
  }

  Rectangle {
    Layout.fillWidth: true
    Layout.fillHeight: true
    color: "transparent"
    clip: true

    ListView {
      id: appView
      anchors.fill: parent
      model: appPane.filteredList
      spacing: 8
      clip: true
      ScrollBar.vertical: ScrollBar {
        policy: ScrollBar.AsNeeded
      }

      delegate: Rectangle {
        id: appRow
        width: appView.width
        height: 50
        radius: 10
        
        property bool isHovered: rowMa.containsMouse || uninstallMa.containsMouse
        
        color: isHovered ? Theme.colMuted : Theme.colBg
        border.color: Theme.colAccent
        border.width: 1
        opacity: isHovered ? 1.0 : 0.6

        MouseArea {
          id: rowMa
          anchors.fill: parent
          hoverEnabled: true
        }

        Item {
          anchors.fill: parent

          Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
            text: modelData
            color: Theme.colAccent
            font.family: Theme.fontFamily
            font.pointSize: 11
            font.bold: appRow.isHovered
          }

          Item {
            width: 85
            height: 28
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 15

            Rectangle {
              id: uninstallBtnRect
              anchors.fill: parent
              radius: 6
              color: uninstallMa.containsMouse ? Theme.colAccent : "transparent"
              border.color: Theme.colAccent
              border.width: 1

              Text {
                anchors.centerIn: parent
                text: "Uninstall"
                font.pointSize: 9
                font.family: Theme.fontFamily
                color: uninstallMa.containsMouse ? Theme.colBg : Theme.colAccent
                font.bold: true
              }

              MouseArea {
                id: uninstallMa
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                  uninstallProc.appToRemove = modelData
                  uninstallProc.running = true
                }
              }
            }
          }
        }
      }
    }
  }

  function filterModel() {
    if (searchQuery === "") {
      filteredList = fullAppList
    } else {
      filteredList = fullAppList.filter(app => app.includes(searchQuery))
    }
  }

  Process {
    id: loader
    command: ["sh", "-c", "yay -Qqe"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        appPane.fullAppList = text.trim().split("\n")
        appPane.filteredList = appPane.fullAppList
      }
    }
  }

  Process {
    id: uninstallProc
    property string appToRemove: ""
    command: ["sh", "-c", "ghostty -e sudo pacman -Rns " + appToRemove]
    onExited: {
      loader.running = true
    }
  }
}
