import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.Components
import qs.Services
import qs.Themes

PopupWindow {
    id: root
    implicitWidth: 250
    implicitHeight: 350
    color: "transparent"
    property bool open: false
    property bool showContent: false

    onVisibleChanged: {
      if (visible) { 
        open = true
      } else {
        open = false
      }
    }

    Item {
        id: playerContainer
        width: 250
        height: 350
        state: root.open ? "open" : "closed"

        states: [
            State {
                name: "closed"
                PropertyChanges { 
                    target: playerContainer
                    opacity: 0
                }
            },
            State {
                name: "open"
                PropertyChanges {
                    target: playerContainer
                    opacity: 1
                }
            }
        ]

        transitions: [
            Transition {
                from: "closed"
                to: "open"
                SequentialAnimation {
                    NumberAnimation {
                        properties: "opacity"
                        duration: 500
                        easing.type: Easing.InCubic
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
                        properties: "opacity"
                        duration: 500
                        easing.type: Easing.InCubic
                    }
                    ScriptAction { script: root.visible = false }
                }
            }
        ]

        MultiEffect {
            id: mediaShadow
            anchors.fill: playerMain
            source: playerMain
            shadowEnabled: true
            shadowColor: Theme.colAccent
            shadowBlur: 0.2
            shadowOpacity: 1
            opacity: playerContainer.opacity
        }

        Rectangle {
            id: playerMain
            anchors.fill: parent
            color: "transparent"

            ClippingRectangle {
                id: bgImageContainer
                anchors.fill: playerMain
                anchors.topMargin: 5
                anchors.bottomMargin: 5
                anchors.rightMargin: 5
                anchors.leftMargin: 5
                opacity: 0.6
                radius: 15
                color: "transparent"

                Image {
                    id: backgroundImage
                    anchors.fill: parent
                    asynchronous: true
                    fillMode: Image.PreserveAspectCrop
                    visible: false
                    source: {
                        const url = Players.active?.trackArtUrl;
                        if (!url) return "";
                        return (url.startsWith("/") && !url.startsWith("file://")) ? "file://" + url : url;
                    }
                }

                MultiEffect {
                    id: bgImageEffect
                    anchors.fill: parent
                    source: backgroundImage
                    blurEnabled: true
                    blur: 1
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
            opacity: 0
            Component.onCompleted: opacity = 1
            Behavior on opacity { NumberAnimation { duration: 500 } }

            Rectangle {
                id: trackInfo
                width: 190
                height: 240
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.colBg
                radius: 15
                clip: true

                ColumnLayout {
                    anchors.fill: parent 
                    anchors.topMargin: 4
                    anchors.bottomMargin: 4
                    spacing: 4

                    Text {
                        id: title
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        color: Theme.colAccent
                        font.pointSize: 10
                        font.bold: true
                        font.family: Theme.fontFamily
                        text: Players.active ? Players.active.trackTitle : ""
                    }
  
                    Item {
                        Layout.fillHeight: true
                    }

                    Text {
                        id: artist
                        Layout.fillWidth: true 
                        horizontalAlignment: Text.AlignHCenter
                        color: Theme.colAccent
                        font.pointSize: 10
                        font.bold: true
                        font.family: Theme.fontFamily
                        text: Players.active ? Players.active.trackArtist : ""
                        elide: Text.ElideRight
                        maximumLineCount: 1
                    }
                }
            }

            Rectangle {
                id: albumArt
                anchors.centerIn: trackInfo
                color: "transparent"
                width: 200
                height: 200
                radius: 15

                RectangularShadow {
                    anchors.fill: parent
                    anchors.leftMargin: 15
                    anchors.rightMargin: 15
                    color: Theme.colAccent
                    blur: 20
                    spread: -5
                    radius: 15
                    opacity: playerContainer.opacity
                }

                ClippingRectangle {
                    id: imageContainer
                    anchors.fill: albumArt
                    anchors.topMargin: 5
                    anchors.bottomMargin: 5
                    anchors.rightMargin: 5
                    anchors.leftMargin: 5 
                    radius: 15
                    color: "transparent" 

                    Image {
                        id: albumImage
                        anchors.fill: parent
                        asynchronous: true
                        fillMode: Image.PreserveAspectCrop
                        source: {
                            const url = Players.active?.trackArtUrl;
                            if (!url) return "";
                            return (url.startsWith("/") && !url.startsWith("file://")) ? "file://" + url : url;
                        }
                    }
                }
            }

            ColumnLayout {
                id: sliderContainer
                width: 180
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: trackInfo.bottom
                anchors.bottom: playerControls.top
                spacing: 0

                Slider {
                    id: trackBar
                    Layout.fillWidth: true
                    from: 0
                    to: Players.active ? Players.active.length : 0
                    value: Players.active ? Players.active.position : 0
                    onMoved: {
                        if (Players.active && Players.active.canSeek) {
                            Players.active.position = value
                        }
                    }

                    background: Rectangle {
                        x: trackBar.leftPadding
                        y: trackBar.topPadding + trackBar.availableHeight / 2 - height / 2
                        implicitHeight: 4
                        width: trackBar.availableWidth
                        height: implicitHeight
                        radius: 2
                        color: Theme.colBg
                        opacity: 0.5

                        Rectangle {
                            width: trackBar.visualPosition * parent.width
                            height: parent.height
                            color: Theme.colAccent
                            radius: 2
                        }
                    }

                    handle: Rectangle {
                        x: trackBar.leftPadding + trackBar.visualPosition * (trackBar.availableWidth - width)
                        y: trackBar.topPadding + trackBar.availableHeight / 2 - height / 2
                        implicitWidth: 10
                        implicitHeight: 10
                        radius: 5
                        color: Theme.colAccent
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    Layout.topMargin: -8

                    Text {
                        text: Players.formatTime(Players.active ? Players.active.position : 0)
                        font.family: Theme.fontFamily
                        font.pointSize: 7
                        color: Theme.colAccent
                        opacity: 0.8
                    }

                    Item { Layout.fillWidth: true }

                    Text {
                        text: Players.formatTime(Players.active ? Players.active.length : 0)
                        font.family: Theme.fontFamily
                        font.pointSize: 7
                        color: Theme.colAccent
                        opacity: 0.8
                    }
                }
            }

            RowLayout {
                id: playerControls
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: playerBox.bottom
                anchors.bottomMargin: 15
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
