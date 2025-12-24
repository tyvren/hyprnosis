import Quickshell
import QtQuick
import QtQuick.Layouts
import qs
import qs.Services

Rectangle {
  id: root
  width: 220
  height: 200
  color: "transparent"
  property var theme: Theme {}

  Rectangle {
    id: playerBox
    anchors.fill: parent
    color: "transparent"
    border.color: theme.colAccent
    border.width: 2
    radius: 20

    Rectangle {
      id: trackTitleBox
      width: 200
      height: 20
      anchors.top: playerBox.top
      anchors.topMargin: 10
      anchors.horizontalCenter: playerBox.horizontalCenter
      color: "transparent"
      border.color: theme.colAccent
      border.width: 2
      radius: 20

      Text {
        id: trackTitleText
        anchors.fill: trackTitleBox
        color: theme.colAccent
        font.pixelSize: 12
        font.family: theme.fontFamily
        text: Players.active ? Players.active.trackTitle : ""
        elide: Text.ElideRight
      }
    }

    Rectangle {
      id: trackImageBox
      width: 200
      height: 125
      anchors.top: playerBox.top
      anchors.horizontalCenter: playerBox.horizontalCenter
      anchors.topMargin: 30
      color: "transparent"

      Image {
        id: albumArt
        anchors.centerIn: trackImageBox
        width: 120
        height: 120
        mipmap: true
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        source: Players.active?.trackArtUrl ?? ""
        visible: source !== ""
      }
    }

    RowLayout {
      id: playerControls
      anchors.bottom: playerBox.bottom
      anchors.horizontalCenter: playerBox.horizontalCenter
      anchors.bottomMargin: 5
      spacing: 8

      Text {
        id: previousTrack
        color: prevTrackArea.containsMouse ? theme.colHilight : theme.colAccent
        font.pixelSize: 30
        font.family: theme.fontFamily
        text: "󰙣"

        MouseArea {
          id: prevTrackArea
          anchors.fill: parent
          hoverEnabled: true
          onClicked: Players.active?.previous()
        }
      }

      Text {
        id: playPause
        color: playpauseArea.containsMouse ? theme.colHilight : theme.colAccent
        font.pixelSize: 30
        font.family: theme.fontFamily
        text: Players.active && Players.active.isPlaying ? "" : ""

        MouseArea {
          id: playpauseArea
          anchors.fill: parent
          hoverEnabled: true
          onClicked: Players.active?.togglePlaying()
        }
      }

      Text {
        id: nextTrack
        color: prevTrackArea.containsMouse ? theme.colHilight : theme.colAccent
        font.pixelSize: 30
        font.family: theme.fontFamily
        text: "󰙡"

        MouseArea {
          id: nextTrackArea
          anchors.fill: parent
          hoverEnabled: true
          onClicked: Players.active?.next()
        }
      }
    }
  }
}
