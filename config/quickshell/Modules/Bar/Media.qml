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
  property bool open: false
  property bool showContent: false

  onVisibleChanged: {
    if (visible) open = true
  }

  Item {
    id: playerContainer
    width: 0
    height: 200
    state: root.open ? "open" : "closed"

    states: [
      State {
        name: "closed"
        PropertyChanges { 
          target: playerContainer
          opacity: 0
          width: 0
        }
      },
      State {
        name: "open"
        PropertyChanges {
          target: playerContainer
          opacity: 1
          width: 220
        }
      }
    ]

    transitions: [
      Transition {
        from: "closed"
        to: "open"
        SequentialAnimation {
          NumberAnimation {
            properties: "opacity, width"
            duration: 1000
            easing.type: Easing.InOutCubic
          } 
          ScriptAction { script: root.showContent = true }
        }
      },
      Transition {
        from: "open"
        to: "closed"
        SequentialAnimation {
          ScriptAction { script: root.showContent = false }
          NumberAnimation {
            properties: "opacity, width"
            duration: 1000
            easing.type: Easing.InOutCubic
          }
          ScriptAction { script: root.visible = false }
        }
      }
    ]

    RectangularShadow {
      anchors.centerIn: parent
      width: playerContainer.width
      height: playerContainer.height
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
        topRightRadius: 15
        bottomRightRadius: 15
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

      Loader {
        id: playerLoader
        anchors.fill: parent
        active: root.showContent
        sourceComponent: playerContents
      }
    }
  }

  Component {
    id: playerContents

    Rectangle {
      id: playerBox
      anchors.fill: parent
      color: "transparent"
      topRightRadius: 15
      bottomRightRadius: 15
      opacity: 0
      Component.onCompleted: opacity = 1
      Behavior on opacity { NumberAnimation { duration: 250 } }

      Rectangle {
        id: trackTitleBox
        width: 200
        height: 20
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        color: theme.colBg
        radius: 20
        clip: true

        Text {
          id: trackTitleText
          anchors.left: parent.left
          anchors.verticalCenter: parent.verticalCenter
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
