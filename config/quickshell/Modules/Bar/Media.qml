import Quickshell
import Quickshell.Widgets
import QtQuick.Effects
import QtQuick
import QtQuick.Layouts
import qs
import qs.Services

Item {
  id: root
  width: 220
  height: 200

  RectangularShadow {
  anchors.centerIn: parent
  width: 220
  height: 200
  blur: 5
  spread: 1
  radius: 20
  }

  Rectangle {
    id: playerMain
    anchors.fill: parent
    color: "transparent"

    ClippingRectangle {
      id: imageContainer
      anchors.fill: playerMain
      radius: 20

      Image {
        id: backgroundImage
        anchors.fill: parent
        mipmap: true
        asynchronous: true
        cache: true
        fillMode: Image.PreserveAspectCrop
        source: Players.active?.trackArtUrl ?? "" 
      }
    }

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
        anchors.topMargin: 1
        anchors.horizontalCenter: playerBox.horizontalCenter
        color: "transparent"
        clip: true 

        Text {
          id: trackTitleText
          anchors.centerIn: trackTitleBox
          color: theme.colAccent
          font.pointSize: 11
          font.family: theme.fontFamily
          text: Players.active ? Players.active.trackTitle : ""
          elide: Text.ElideRight
          maximumLineCount: 10
        }
      }

      RowLayout {
        id: playerControls
        anchors.centerIn: parent
        anchors.horizontalCenter: playerBox.horizontalCenter
        spacing: 20

        Text {
          id: previousTrack
          color: prevTrackArea.containsMouse ? theme.colHilight : theme.colAccent
          font.pointSize: 40
          font.family: theme.fontFamily
          text: "󰙤"

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
          font.pointSize: 40
          font.family: theme.fontFamily
          text: Players.active && Players.active.isPlaying ? "" : ""

          MouseArea {
            id: playpauseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: Players.active?.togglePlaying()
          }
        }

        Text {
          id: nextTrack
          color: nextTrackArea.containsMouse ? theme.colHilight : theme.colAccent
          font.pointSize: 40
          font.family: theme.fontFamily
          text: "󰙢"

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
}
