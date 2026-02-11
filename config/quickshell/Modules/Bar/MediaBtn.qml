import QtQuick
import Quickshell
import qs.Components
import qs.Services
import qs.Themes

Rectangle {
    id: mediaBtn
    width: 25
    height: 25
    color: "transparent"
    radius: 50
    visible: Players.active

    Image {
        id: activeLogo
        anchors.fill: mediaBtn
        source: Theme.logoPath
        mipmap: true
        asynchronous: true
        opacity: 0.5
        fillMode: Image.PreserveAspectFit

        RotationAnimation on rotation {
            id: infiniteSpinAnim
            running: true
            loops: Animation.Infinite
            from: 0
            to: 360
            duration: 6000
        }
    }

    Item {
        id: textContainer
        anchors.fill: mediaBtn

        Text {
            id: musicIcon
            anchors.left: textContainer.left
            anchors.leftMargin: 3
            color: Theme.colAccent
            font.bold: true
            font.family: Theme.fontFamily
            font.pointSize: 16
            text: ""
            visible: false
        }

        BtnTextShadow {
            anchors.fill: musicIcon 
            source: musicIcon
        }
    }

    MouseArea {
        id: mediaBtnArea
        anchors.fill: mediaBtn
        hoverEnabled: true
        onEntered: {
            if (!mediaPlayer.open) {
                mediaPlayer.visible = true 
            } else {
                mediaPlayer.open = false
            }
        }
    }
}
