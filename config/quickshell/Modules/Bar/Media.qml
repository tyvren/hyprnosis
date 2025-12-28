import Quickshell
import Quickshell.Widgets
import QtQuick.Effects
import QtQuick
import QtQuick.Layouts
import qs
import qs.Services
import qs.Components

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
  color: theme.colAccent
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
        anchors.topMargin: 5
        anchors.horizontalCenter: playerBox.horizontalCenter
        color: theme.colBg
        radius: 20
        clip: true 

        Text {
          id: trackTitleText
          anchors.left: trackTitleBox.left
          anchors.verticalCenter: trackTitleBox.verticalCenter
          anchors.leftMargin: 5
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
        spacing: 10

        StyledButton {
          id: previousTrack
          text: "󰒮"
          opacity: menuContainer.visible ? 1.0 : 0.0
          Behavior on opacity { NumberAnimation { duration: 1000 } }
          onClicked: Players.active?.previous()
        }

        StyledButton {
          id: playPause
          text: Players.active && Players.active.isPlaying ? "" : ""
          opacity: menuContainer.visible ? 1.0 : 0.0
          Behavior on opacity { NumberAnimation { duration: 1000 } }
          onClicked: Players.active?.togglePlaying()
        }

        StyledButton {
          id: nextTrack
          text: "󰒭"
          opacity: menuContainer.visible ? 1.0 : 0.0
          Behavior on opacity { NumberAnimation { duration: 1000 } }
          onClicked: Players.active?.next()
        }
      }
    }
  }
}
