import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import qs
import qs.Services
import qs.Components

PopupWindow {
  id: root
  implicitWidth: 220
  implicitHeight: 200

  Item {
    id:playerContainer
    width: 220
    height: 200

    state: root.visible ? "open" : "closed"

    states:
      State {
        name: "closed"
        PropertyChanges { 
          target: playerContainer
          opacity: 0
        }
      }
      State {
        name: "open"
        PropertyChanges {
          target: playerContainer
          opacity: 1
        }
      }

    transitions: 
      Transition {
        from: "closed"
        to: "open"
        NumberAnimation {
          properties: "opacity"
          duration: 1000
          easing.type: Easing.InOutCubic
        } 
      }

    RectangularShadow {
      anchors.centerIn: parent
      width: 220
      height: 200
      blur: 2
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
        color: "transparent"

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
            maximumLineCount: 1
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
            onClicked: Players.active?.previous()
          }

          StyledButton {
            id: playPause
            text: Players.active && Players.active.isPlaying ? "" : ""
            onClicked: Players.active?.togglePlaying()
          }

          StyledButton {
            id: nextTrack
            text: "󰒭"
            onClicked: Players.active?.next()
          }
        }
      }
    }
  }
}
