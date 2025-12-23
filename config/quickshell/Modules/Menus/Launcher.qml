import QtQuick.Controls
import Quickshell
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Hyprland
import qs

PanelWindow {
  id: launcherMenu
  visible: false
  focusable: true
  color: "transparent"
  property var theme: Theme {}
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
    //border.width: 2
    //border.color: theme.colAccent
    
    Image {
      id: logoImage
      anchors.centerIn: parent
      width: 500
      height: 500
      source: theme.logoPath
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
        height: 40
        radius: 8
        color: theme.colSelect

        TextField {
          id: searchField
          anchors.fill: parent
          placeholderText: "Search apps..."
          color: theme.colAccent
          font.family: theme.fontFamily
          font.pixelSize: 16

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
          height: 50
          radius: 10
          color: (ListView.isCurrentItem || mouseArea.containsMouse)
                 ? theme.colSelect
                 : theme.colBg
          border.width: 2
          border.color: theme.colAccent
          clip: true
          anchors.horizontalCenter: parent.horizontalCenter

          IconImage {
            id: appIcon
            anchors.verticalCenter: parent.verticalCenter
            x: 10
            implicitSize: 30
            source: Quickshell.iconPath(modelData.icon, true) || ""
          }

          Text {
            id: appText
            anchors.verticalCenter: parent.verticalCenter
            x: 60
            text: modelData.name
            color: theme.colAccent
            font.family: theme.fontFamily
            font.pixelSize: 18
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
