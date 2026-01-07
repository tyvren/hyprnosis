import QtQuick.Controls
import Quickshell
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Hyprland
import qs.Themes

PanelWindow {
  id: launcherMenu
  visible: false
  focusable: true
  color: "transparent"
  property string query: ""
  property var filteredApps: DesktopEntries.applications.values

  anchors {
    top: true
    bottom: true
    left: true
    right: true
  }

  onVisibleChanged: {
    if (visible) {
      query = ""
      Qt.callLater(() => searchField.forceActiveFocus())
    } else {
      query = ""
      searchField.text = ""
      listview.currentIndex = -1
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
    listview.currentIndex = filteredApps.length > 0 ? 0 : -1
  }

  IpcHandler {
    target: "launcher-menu"

    function toggle(): void {
      launcherMenu.visible = !launcherMenu.visible
    }

    function hide(): void {
      launcherMenu.visible = false
    }
  }

  RectangularShadow {
    anchors.centerIn: parent
    width: 450
    height: 500
    blur: 10
    spread: 0
    radius: 10
    color: "transparent"
  }

  Rectangle {
    anchors.centerIn: parent
    width: 450
    height: 500
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

    Keys.onEscapePressed: launcherMenu.visible = false

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 12
      spacing: 12

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

          onTextChanged: launcherMenu.query = text

          Keys.onPressed: event => {
            if ((event.key === Qt.Key_Return || event.key === Qt.Key_Enter)
                && listview.currentIndex >= 0) {
              const app = listview.model[listview.currentIndex]
              Quickshell.execDetached({
                command: ["sh", "-c", app.execute()]
              })
              launcherMenu.visible = false
              event.accepted = true
            }

            if (event.key === Qt.Key_Down) {
              listview.forceActiveFocus()
              event.accepted = true
            }
          }
        }
      }

      ListView {
        id: listview
        Layout.fillWidth: true
        Layout.fillHeight: true
        model: launcherMenu.filteredApps
        orientation: ListView.Vertical
        spacing: 6
        clip: true
        keyNavigationEnabled: true

        Keys.onPressed: event => {
          if ((event.key === Qt.Key_Return || event.key === Qt.Key_Enter)
              && currentIndex >= 0) {
            const app = model[currentIndex]
            Quickshell.execDetached({
              command: ["sh", "-c", app.execute()]
            })
            launcherMenu.visible = false
            event.accepted = true
          }
        }

        delegate: Rectangle {
          width: 325
          height: 60
          radius: 50
          color: (ListView.isCurrentItem || mouseArea.containsMouse)
                 ? Theme.colSelect
                 : Theme.colBg
          border.width: 2
          border.color: Theme.colAccent
          clip: true
          anchors.horizontalCenter: parent.horizontalCenter

          IconImage {
            id: appIcon
            anchors.verticalCenter: parent.verticalCenter
            x: 15
            implicitSize: 32
            source: Quickshell.iconPath(modelData.icon, true) || ""
          }

          Text {
            id: appText
            anchors.verticalCenter: parent.verticalCenter
            x: 65
            text: modelData.name
            color: Theme.colAccent
            font.family: Theme.fontFamily
            font.pointSize: 14
          }

          MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
              Quickshell.execDetached({
                command: ["sh", "-c", modelData.execute()]
              })
              launcherMenu.visible = false
            }
          }
        }
      }
    }
  }
}
