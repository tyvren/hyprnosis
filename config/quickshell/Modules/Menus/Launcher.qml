import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Widgets
import qs.Themes

PanelWindow {
  id: launcherMenu
  visible: false
  focusable: true
  implicitWidth: 540
  implicitHeight: 520
  color: "transparent"
  property string query: ""
  property var filteredApps: DesktopEntries.applications.values
  exclusionMode: ExclusionMode.Ignore

  property bool open: false
  property bool showContent: false

  anchors {
    bottom: true
  }

  onVisibleChanged: {
    if (visible) {
      open = true
    } else {
      open = false
    }
    query = ""
  }

  onQueryChanged: {
    if (query === "") {
      filteredApps = DesktopEntries.applications.values
    } else {
      filteredApps = DesktopEntries.applications.values.filter(app =>
        app.name.toLowerCase().includes(query.toLowerCase())
      )
    }
  }

  IpcHandler {
    target: "launcher-menu"

    function toggle(): void {
      if (launcherMenu.visible && launcherMenu.open) {
        launcherMenu.open = false
      } else {
        launcherMenu.visible = true
      }
    }

    function hide(): void {
      launcherMenu.open = false
    }
  }

  Item {
    id: launcherContainer
    width: 520
    height: 520
    anchors.horizontalCenter: parent.horizontalCenter
    state: launcherMenu.open ? "open" : "closed"
    focus: true

    Keys.onEscapePressed: launcherMenu.open = false

    states: [
      State {
        name: "closed"
        PropertyChanges {
          target: launcherContainer
          opacity: 0
          y: 520
        }
      },
      State {
        name: "open"
        PropertyChanges {
          target: launcherContainer
          opacity: 1
          y: 0
        }
      }
    ]

    transitions: [
      Transition {
        from: "closed"
        to: "open"
        SequentialAnimation {
          NumberAnimation {
            properties: "opacity, y"
            duration: 150
            easing.type: Easing.OutQuart
          }
          ScriptAction { 
            script: {
              launcherMenu.showContent = true
            } 
          }
        }
      },
      Transition {
        from: "open"
        to: "closed"
        SequentialAnimation {
          ScriptAction { script: launcherMenu.showContent = false }
          NumberAnimation {
            properties: "opacity, y"
            duration: 300
            easing.type: Easing.InQuart
          }
          ScriptAction { script: launcherMenu.visible = false }
        }
      }
    ]

    Rectangle {
      id: mainBackground
      anchors.fill: parent
      anchors.topMargin: 20
      topLeftRadius: 15
      topRightRadius: 15
      color: Theme.colBg
      clip: true

      Image {
        id: logoImage
        anchors.centerIn: parent
        width: 520
        height: 500
        source: Theme.logoPath
        mipmap: true
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        opacity: 0.3
      }

      Loader {
        id: contentLoader
        anchors.fill: parent
        active: launcherMenu.showContent
        focus: true
        sourceComponent: launcherContent
      }
    }

    MultiEffect {
      id: launcherShadow
      anchors.fill: mainBackground
      source: mainBackground
      shadowEnabled: true
      shadowColor: Theme.colAccent
      shadowBlur: 0.2
      z: -1
    }
  }

  Component {
    id: launcherContent
    ColumnLayout {
      anchors.fill: parent
      anchors.topMargin: 20
      anchors.bottomMargin: 10
      spacing: 15
      opacity: 0
      Component.onCompleted: {
        opacity = 1
        searchField.forceActiveFocus()
      }
      Behavior on opacity { NumberAnimation { duration: 250 } }

      Rectangle {
        Layout.alignment: Qt.AlignHCenter
        width: 440
        height: 35
        radius: 50
        color: Theme.colBg
        border.color: Theme.colAccent
        border.width: 1

        TextField {
          id: searchField
          anchors.fill: parent
          anchors.leftMargin: 15
          placeholderText: "Search apps..."
          placeholderTextColor: Theme.colAccent
          color: Theme.colAccent
          font.family: Theme.fontFamily
          font.pointSize: 14
          background: null
          focus: true
          text: launcherMenu.query

          onTextChanged: {
            if (activeFocus) {
              launcherMenu.query = text
            }
          }

          Keys.onPressed: event => {
            if ((event.key === Qt.Key_Return || event.key === Qt.Key_Enter)
                && gridview.currentIndex >= 0) {
              const app = gridview.model[gridview.currentIndex]
              Quickshell.execDetached({
                command: ["sh", "-c", app.execute()]
              })
              launcherMenu.open = false
              event.accepted = true
            }

            if (event.key === Qt.Key_Down || event.key === Qt.Key_Tab) {
              gridview.forceActiveFocus()
              event.accepted = true
            }
          }
        }
      }

      GridView {
        id: gridview
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.leftMargin: 25
        Layout.rightMargin: 25
        model: launcherMenu.filteredApps
        clip: true
        keyNavigationEnabled: true
        cellWidth: 94
        cellHeight: 105
        focus: true
        currentIndex: launcherMenu.filteredApps.length > 0 ? 0 : -1

        ScrollBar.vertical: ScrollBar {
          policy: ScrollBar.AsNeeded
        }

        Keys.onPressed: event => {
          if ((event.key === Qt.Key_Return || event.key === Qt.Key_Enter)
              && currentIndex >= 0) {
            const app = model[currentIndex]
            Quickshell.execDetached({
              command: ["sh", "-c", app.execute()]
            })
            launcherMenu.open = false
            event.accepted = true
          }
        }

        delegate: Item {
          id: appDelegate
          width: 80
          height: 80
          property bool isHighlighted: GridView.isCurrentItem || mouseArea.containsMouse

          RectangularShadow {
            anchors.centerIn: parent
            width: appDelegate.width
            height: appDelegate.height
            blur: 2
            spread: 1
            radius: appDelegate.width
            color: Theme.colAccent
            visible: isHighlighted
          }

          Rectangle {
            anchors.fill: parent
            radius: width
            color: isHighlighted ? Theme.colSelect : Theme.colBg
            border.color: Theme.colAccent
            border.width: 2
            
            ColumnLayout {
              anchors.centerIn: parent
              width: parent.width - 15
              spacing: 4

              IconImage {
                source: Quickshell.iconPath(modelData.icon, true) || ""
                Layout.preferredWidth: 34
                Layout.preferredHeight: 34
                Layout.alignment: Qt.AlignHCenter
              }

              Text {
                text: modelData.name
                color: Theme.colAccent
                font.family: Theme.fontFamily
                font.pointSize: 7
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                elide: Text.ElideRight
                maximumLineCount: 1
              }
            }

            MouseArea {
              id: mouseArea
              anchors.fill: parent
              hoverEnabled: true
              onClicked: {
                Quickshell.execDetached({
                  command: ["sh", "-c", modelData.execute()]
                })
                launcherMenu.open = false
              }
            }
          }
        }
      }
    }
  }
}
