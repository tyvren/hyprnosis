pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs

Scope {
  id: root

  property string wallpaperDir: "/home/tyvren/.config/hyprnosis/wallpapers/Mocha"
  property string searchQuery: ""
  property var theme: Theme {}
  property var wallpaperList: []
  property var filteredWallpaperList: {
    if (searchQuery === "")
      return wallpaperList;
    return wallpaperList.filter(path => {
      const filename = path.split('/').pop();
      return filename.toLowerCase().includes(searchQuery.toLowerCase());
    });
  }

  property int currentPreviewIndex: 0

  onWallpaperDirChanged: {
    scanWallpapers.start();
  }

  Process {
    id: scanWallpapers
    workingDirectory: root.wallpaperDir
    command: ["sh", "-c", `find -L "${root.wallpaperDir}" -type f ! -name ".*"`]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        const wallList = text.trim().split('\n').filter(p => p.length > 0);
        root.wallpaperList = wallList;
      }
    }
  }

  PanelWindow {
    id: wallpaperWindow
    implicitWidth: 800
    implicitHeight: 600
    visible: false
    color: "transparent"
    WlrLayershell.layer: WlrLayer.Top
    focusable: true

    Rectangle {
      anchors.fill: parent
      color: theme.colBg
      radius: 12
      border.color: theme.colAccent
      border.width: 2

      ColumnLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 12

        TextField {
          id: searchField
          Layout.fillWidth: true
          Layout.preferredHeight: 45
          placeholderText: "Search wallpapers..."
          text: root.searchQuery
          color: theme.colBg
          font.pixelSize: theme.fontSize
          focus: true

          onTextChanged: {
            root.searchQuery = text;
            if (pathView.count > 0) {
              pathView.currentIndex = 0;
              root.currentPreviewIndex = 0;
            }
          }

          Keys.onDownPressed: pathView.focus = true
          Keys.onEscapePressed: wallpaperWindow.visible = false
        }

        PathView {
          id: pathView
          Layout.fillWidth: true
          Layout.fillHeight: true
          clip: true
          model: root.filteredWallpaperList
          pathItemCount: 7

          delegate: Item {
            id: delegateItem
            required property var modelData
            required property int index
            implicitWidth: 500
            implicitHeight: 350
            scale: PathView.scale
            z: PathView.z

            Rectangle {
              anchors.fill: parent
              anchors.margins: 10
              color: theme.colBg
              radius: 8
              border.color: pathView.currentIndex === delegateItem.index ? theme.colAccent : "transparent"
              border.width: 2

              Image {
                anchors.fill: parent
                anchors.margins: 3
                source: "file://" + delegateItem.modelData
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
                smooth: true

                Text {
                  anchors.bottom: parent.bottom
                  anchors.left: parent.left
                  anchors.right: parent.right
                  anchors.margins: 8
                  text: delegateItem.modelData.split('/').pop()
                  color: "white"
                  font.pixelSize: 12
                  elide: Text.ElideMiddle
                  style: Text.Outline
                  styleColor: "black"
                }
              }

              MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                  pathView.currentIndex = delegateItem.index;
                }

                onClicked: {
                  Quickshell.execDetached({
                    command: ["sh", "-c", `$HOME/.config/hyprnosis/modules/style/wallpaper_changer.sh ${delegateItem.modelData}`]
                  });
                  wallpaperWindow.visible = false;
                }
              }
            }
          }

          path: Path {
            startX: pathView.width / 2
            startY: -100

            PathAttribute { name: "z"; value: 0 }
            PathAttribute { name: "scale"; value: 0.6 }

            PathLine { x: pathView.width / 2; y: pathView.height / 2 }

            PathAttribute { name: "z"; value: 10 }
            PathAttribute { name: "scale"; value: 1.0 }

            PathLine { x: pathView.width / 2; y: pathView.height + 100 }

            PathAttribute { name: "z"; value: 0 }
            PathAttribute { name: "scale"; value: 0.6 }
          }

          preferredHighlightBegin: 0.5
          preferredHighlightEnd: 0.5

          Keys.onPressed: event => {
            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
              Quickshell.execDetached({
                command: ["sh", "-c", `$HOME/.config/hyprnosis/modules/style/wallpaper_changer.sh ${model[currentIndex]}`]
              });
              wallpaperWindow.visible = false;
            }
            if (event.key === Qt.Key_Up) decrementCurrentIndex();
            if (event.key === Qt.Key_Down) incrementCurrentIndex();
            if (event.key === Qt.Key_Tab) searchField.focus = true;
            if (event.key === Qt.Key_Escape) wallpaperWindow.visible = false;
          }
        }
      }
    }
  }

  IpcHandler {
    target: "wallpapersmenu"

    function toggle(): void {
      wallpaperWindow.visible = !wallpaperWindow.visible;
      if (wallpaperWindow.visible) {
        searchField.text = "";
        pathView.currentIndex = 0;
        root.currentPreviewIndex = 0;
        scanWallpapers.start();
      }
    }

    function hide(): void {
      wallpaperWindow.visible = false;
    }
  }
}
