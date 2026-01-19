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
  implicitWidth: 380
  implicitHeight: 320
  color: "transparent"
  property string query: ""
  property var filteredApps: DesktopEntries.applications.values
  exclusionMode: ExclusionMode.Ignore

  property bool open: false
  property bool showContent: false

  anchors {
    top: true
  }

  onVisibleChanged: {
    if (visible) {
      open = true
      query = ""
    } else {
      open = false
      query = ""
      searchField.text = ""
      gridview.currentIndex = -1
    }
  }

  onQueryChanged: {
    if (query === "") {
      filteredApps = DesktopEntries.applications.values
    } else {
      filteredApps = DesktopEntries.applications.values.filter(app =>
        app.name.toLowerCase().includes(query.toLowerCase())
      )
    }
    gridview.currentIndex = filteredApps.length > 0 ? 0 : -1
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
    id: animationContainer
    width: 380
    height: 0
    state: launcherMenu.open ? "open" : "closed"
    focus: true

    Keys.onEscapePressed: launcherMenu.open = false

    states: [
      State {
        name: "closed"
        PropertyChanges {
          target: animationContainer
          opacity: 0
          height: 0
        }
      },
      State {
        name: "open"
        PropertyChanges {
          target: animationContainer
          opacity: 1
          height: 320
        }
      }
    ]

    transitions: [
      Transition {
        from: "closed"
        to: "open"
        SequentialAnimation {
          NumberAnimation {
            properties: "opacity, height"
            duration: 750
            easing.type: Easing.InOutCubic
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
            properties: "opacity, height"
            duration: 750
            easing.type: Easing.InOutCubic
          }
          ScriptAction { script: launcherMenu.visible = false }
        }
      }
    ]

    RectangularShadow {
      anchors.fill: parent
      blur: 10
      spread: 0
      radius: 10
      color: "transparent"
    }

    Rectangle {
      id: mainBackground
      anchors.fill: parent
      bottomLeftRadius: 10
      bottomRightRadius: 10
      color: Theme.colBg
      clip: true
      
      Image {
        id: logoImage
        anchors.centerIn: parent
        width: 380
        height: 320
        source: Theme.logoPath
        mipmap: true
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        opacity: 0.7
      }

      Loader {
        id: contentLoader
        anchors.fill: parent
        active: launcherMenu.showContent
        focus: true
        sourceComponent: launcherContent
      }
    }
  }

  Component {
    id: launcherContent
    ColumnLayout {
      anchors.fill: parent
      anchors.topMargin: 12
      anchors.bottomMargin: 12
      spacing: 12
      opacity: 0
      Component.onCompleted: {
        opacity = 1
        searchField.forceActiveFocus()
      }
      Behavior on opacity { NumberAnimation { duration: 250 } }

      Rectangle {
        Layout.alignment: Qt.AlignHCenter
        width: 325
        height: 30
        radius: 50
        color: Theme.colBg
        border.color: Theme.colAccent
        border.width: 1

        TextField {
          id: searchField
          anchors.fill: parent
          anchors.leftMargin: 10
          placeholderText: "Search apps..."
          color: Theme.colAccent
          font.family: Theme.fontFamily
          font.pointSize: 14
          background: null
          focus: true

          onTextChanged: launcherMenu.query = text

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

            if (event.key === Qt.Key_Down) {
              gridview.forceActiveFocus()
              event.accepted = true
            }
          }
        }
      }

      GridView {
        id: gridview
        Layout.fillHeight: true
        Layout.preferredWidth: 340
        Layout.alignment: Qt.AlignHCenter
        model: launcherMenu.filteredApps
        clip: true
        keyNavigationEnabled: true
        cellWidth: 85
        cellHeight: 85
        focus: true
        
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

        delegate: Rectangle {
          width: 75
          height: 75
          radius: 50
          color: (GridView.isCurrentItem || mouseArea.containsMouse)
                  ? Theme.colSelect
                  : Theme.colBg
          border.width: 2
          border.color: Theme.colAccent
          clip: true

          ColumnLayout {
            anchors.centerIn: parent
            width: parent.width - 10
            spacing: 2

            IconImage {
              source: Quickshell.iconPath(modelData.icon, true) || ""
              Layout.preferredWidth: 32
              Layout.preferredHeight: 32
              Layout.alignment: Qt.AlignHCenter
            }

            Text {
              text: modelData.name
              color: Theme.colAccent
              font.family: Theme.fontFamily
              font.pointSize: 8
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
