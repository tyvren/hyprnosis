import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.Themes
import qs.Services
import qs.Components

ColumnLayout {
  id: wallpaperPane
  spacing: 15

  property bool active: false
  property string wallpaperDir: Quickshell.env("HOME") + "/Pictures/wallpapers"
  property var wallpaperList: []

  Process {
    id: scanWallpapers
    command: ["find", "-L", wallpaperPane.wallpaperDir, "-type", "f", "!", "-name", ".*"]
    running: wallpaperPane.active
    stdout: StdioCollector {
      onStreamFinished: {
        const wallList = text.trim().split('\n').filter(p => p.length > 0);
        wallpaperPane.wallpaperList = wallList;
      }
    }
  }

  ColumnLayout {
    spacing: 10
    Layout.fillWidth: true

    RowLayout {
      spacing: 10

      Text { 
        text: "Select a wallpaper to apply:"
        color: Theme.colAccent
        font.pointSize: 14
        font.family: Theme.fontFamily
      }

      Text {
        text: "~/Pictures/wallpapers"
        color: Theme.colMuted
        font.pointSize: 14
        font.family: Theme.fontFamily
      }
    }

    DividerLine {
      Layout.fillWidth: true
    }
  }

  Rectangle {
    Layout.fillWidth: true
    Layout.fillHeight: true
    radius: 10
    color: "transparent" 

    ScrollView {
      anchors.fill: parent
      clip: true
      ScrollBar.vertical.policy: ScrollBar.AsNeeded

      GridView {
        id: wallGrid
        anchors.fill: parent
        cellWidth: 225
        cellHeight: 160
        model: wallpaperPane.wallpaperList

        delegate: Rectangle {
          id: imageBox
          width: 215
          height: 150
          color: "transparent"
          border.color: wallMouse.containsMouse ? Theme.colAccent : "transparent"
          border.width: 1
          radius: 15

          ClippingRectangle {
            id: clipImage
            anchors.fill: imageBox
            anchors.margins: 2
            color: "transparent"
            radius: 15
          
            Image {
              anchors.fill: parent
              source: "file://" + modelData
              fillMode: Image.PreserveAspectCrop
              asynchronous: true
              mipmap: true
              cache: true
            }
          }

          MouseArea {
            id: wallMouse
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
              Config.updateWallpaper(modelData);
              Quickshell.execDetached([
                Quickshell.env("HOME") + "/.config/hyprnosis/modules/style/wallpaper_changer.sh",
                modelData
              ]);
            }
          }
        }
      }
    }
  }
}
